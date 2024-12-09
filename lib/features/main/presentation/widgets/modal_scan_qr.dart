import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/common/common.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/features/event/data/models/scan_qr_payload.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';

class ScanQRView extends StatefulWidget {
  const ScanQRView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanQRViewState();
}

class _ScanQRViewState extends State<ScanQRView> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isOpenFlash = false;
  bool _isApiCalled = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          BlocBuilder<EventBloc, EventState>(
            buildWhen: (previous, current) {
              if (current is ScanQrCodeSuccess) {
                ToastHelper.toastSuccess(title: current.res, context: context);
                Navigator.pop(context);
                _isApiCalled = false;
              }

              if (current is ScanQrCodeFailure) {
                ToastHelper.toastError(title: current.error, context: context);
                Navigator.pop(context);
                _isApiCalled = false;
              }

              return current is ScanQrCodeLoading ||
                  current is ScanQrCodeSuccess ||
                  current is ScanQrCodeFailure;
            },
            builder: (context, state) {
              if (state is ScanQrCodeLoading) {
                return const Expanded(
                    child: Center(
                        child: CircularProgressIndicator(
                  strokeWidth: 2,
                )));
              }

              return Expanded(
                child: Stack(children: [
                  _buildQrView(context),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: DimensionsHelper.HORIZONTAL_SCREEN),
                      width: DimensionsHelper.iziSize.width,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                              onTap: () async {
                                await controller?.toggleFlash();
                                setState(() {
                                  isOpenFlash = !isOpenFlash;
                                });
                              },
                              child: isOpenFlash
                                  ? ImageBase(
                                      ImagePathConstants.IC_FLASH_OFF,
                                      width: 40,
                                      height: 40,
                                    )
                                  : ImageBase(
                                      ImagePathConstants.IC_FLASH_ON,
                                      width: 40,
                                      height: 40,
                                    )),
                          GestureDetector(
                            onTap: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: ImageBase(
                                ImagePathConstants.IC_CHANGE_CAMERA,
                                width: 45,
                                height: 45),
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: TextBase(
                                  text: "Hủy",
                                  style: TextStyle(
                                    fontFamily: Fonts.Lexend.name,
                                    fontSize:
                                        DimensionsHelper.FONT_SIZE_SPAN * 1.2,
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstants.WHITE,
                                  )))
                        ],
                      ),
                    ),
                  ),
                ]),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 300 ||
            MediaQuery.of(context).size.height < 300)
        ? 150.0
        : 250.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: ColorConstants.PRIMARY_1,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  bool validateQrEvent(String qr) {
    return !(qr.contains("EventAccountId") && qr.contains("AccountId"));
  }

  bool validateAccountGift(String qr) {
    return !(qr.contains("GiftId") &&
        qr.contains("AccountId") &&
        qr.contains("fm"));
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;

      if (!_isApiCalled) {
        _isApiCalled = true;
        // Quét vé tham gia sự kiện

        try {
          String qr = decodeBase64(result!.code!);

          if (validateQrEvent(qr) && validateAccountGift(qr)) {
            ToastHelper.toastWarning(
                title: "QR code không hợp lệ!", context: context);

            // Delay Time
            Timer(const Duration(seconds: 2), () {
              _isApiCalled = false;
            });
          } else {
            ScanQrPayload payload =
                ScanQrPayload(Latitude: "", Longitude: "", token: result!.code);

            context.read<EventBloc>().add(PostEventScanQrEvent(payload));
          }
        } catch (e) {
          ToastHelper.toastWarning(
              title: "QR code không hợp lệ!", context: context);

          // Delay Time
          Timer(const Duration(seconds: 2), () {
            _isApiCalled = false;
          });
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      ToastHelper.toastInfo(
          title: "Vui lòng cấp quyền camera", context: context);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
