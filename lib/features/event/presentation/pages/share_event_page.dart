import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/features/event/data/models/share_event_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/ticket_info_entity.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';
import 'package:intl/intl.dart';

class ShareEventPage extends StatefulWidget {
  const ShareEventPage({super.key, required this.args});
  final ShareEventPageArguments args;

  @override
  State<ShareEventPage> createState() => _ShareEventPageState();
}

class _ShareEventPageState extends State<ShareEventPage> {
  late int id;
  var captureKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    id = widget.args.event.id;

    context.read<EventBloc>().add(GetTicketInfoEvent(id));
  }

  Future<void> handleCaptureImage() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        final boundary = captureKey.currentContext?.findRenderObject()
            as RenderRepaintBoundary?;
        final image = await boundary?.toImage(pixelRatio: 3.0);
        final byteData = await image?.toByteData(format: ImageByteFormat.png);
        final pngBytes = byteData?.buffer.asUint8List();
        if (pngBytes != null) {
          final result =
              await ImageGallerySaver.saveImage(pngBytes.buffer.asUint8List());
          final temp = result.toString();
          ToastHelper.toastSuccess(
              title: 'Tải Qr code thành công', context: context);
        }
      } catch (e) {
        ToastHelper.toastError(title: 'Lỗi tải Qr code', context: context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth >= 600;

    return Scaffold(
        appBar: _header(),
        body: BlocBuilder<EventBloc, EventState>(
          buildWhen: (previous, current) {
            return current is TicketInfoLoading ||
                current is TicketInfoSuccess ||
                current is TicketInfoFailure;
          },
          builder: (context, state) {
            if (state is TicketInfoLoading) {
              return SizedBox(
                  height: DimensionsHelper.iziSize.height -
                      DimensionsHelper.ONE_UNIT_SIZE * 200,
                  child: const Center(
                      child: CircularProgressIndicator(
                    strokeWidth: 2,
                  )));
            }

            if (state is TicketInfoSuccess) {
              return Container(
                  margin: EdgeInsets.only(
                    top: DimensionsHelper.ONE_UNIT_SIZE * 70,
                  ),
                  height: isTablet
                      ? DimensionsHelper.ONE_UNIT_SIZE * 920
                      : DimensionsHelper.ONE_UNIT_SIZE * 700,
                  width: DimensionsHelper.iziSize.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          ImagePathConstants.IMAGE_BG_QRCODE,
                        )),
                  ),
                  child: Column(
                    children: [
                      _imageQRCode(state.ticketInfo),
                      _content(state.ticketInfo),
                    ],
                  ));
            }
            return SizedBox(
                height: DimensionsHelper.iziSize.height - 200,
                child: const BoxEmpty());
          },
        ));
  }

  Center _imageQRCode(TicketInfoEntity ticket) {
    String cleanBase64 = ticket.info.split(',').last;
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth >= 600;

    return Center(
        child: Container(
            margin: EdgeInsets.only(
                top: isTablet
                    ? DimensionsHelper.ONE_UNIT_SIZE * 60
                    : DimensionsHelper.ONE_UNIT_SIZE * 40),
            padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_2X),
            width: DimensionsHelper.iziSize.width * 0.5,
            height: DimensionsHelper.iziSize.width * 0.5,
            decoration: BoxDecoration(
                color: const Color.fromRGBO(249, 249, 249, 1),
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.ONE_UNIT_SIZE * 30)),
            child: RepaintBoundary(
                key: captureKey, child: base64ImageWidget(cleanBase64))));
  }

  Widget base64ImageWidget(String base64String) {
    Uint8List imageBytes = base64Decode(base64String);

    return ClipRRect(
      borderRadius: BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_5X),
      child: Image.memory(
        imageBytes,
        width: DimensionsHelper.ONE_UNIT_SIZE * 140,
        height: DimensionsHelper.ONE_UNIT_SIZE * 140,
      ),
    );
  }

  Container _content(TicketInfoEntity ticket) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth >= 600;
    return Container(
      margin: EdgeInsets.only(
        top: DimensionsHelper.ONE_UNIT_SIZE * 20,
        left: DimensionsHelper.HORIZONTAL_SCREEN * 1.5,
        right: DimensionsHelper.HORIZONTAL_SCREEN * 1.5,
      ),
      padding: EdgeInsets.all(isTablet
          ? DimensionsHelper.SPACE_SIZE_5X * 1.2
          : DimensionsHelper.SPACE_SIZE_3X),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBase(
              text: widget.args.event.name,
              maxLine: 2,
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                fontWeight: FontWeight.w400,
                color: ColorConstants.PRIMARY_1,
              )),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_1X * 0.7,
          ),
          Row(
            children: [
              ImageBase(ImagePathConstants.IC_ADDRESS),
              SizedBox(
                width: DimensionsHelper.SPACE_SIZE_1X,
              ),
              Expanded(
                child: TextBase(
                    maxLine: 2,
                    text: widget.args.event.info,
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                      fontWeight: FontWeight.w200,
                      color: ColorConstants.BLACK,
                    )),
              )
            ],
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_1X * 0.7,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextBase(
                  text: DateFormat('dd.MM.yyyy - hh:mm')
                      .format(widget.args.event.startDate),
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.PRIMARY_1,
                  )),
              TextBase(
                  text: widget.args.event.eventStatusName,
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.BLACK,
                  )),
            ],
          ),
          Container(
            margin:
                EdgeInsets.symmetric(vertical: DimensionsHelper.SPACE_SIZE_3X),
            width: DimensionsHelper.iziSize.width,
            height: DimensionsHelper.ONE_UNIT_SIZE * 2,
            color: ColorConstants.LINE,
          ),
          Center(
            child: TextBase(
                text: "Vui lòng chia sẻ mã QR để \nchia sẻ sự kiện đến bạn bè.",
                maxLine: 2,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                  fontWeight: FontWeight.w200,
                  color: ColorConstants.BLACK,
                )),
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_3X,
          ),
          GestureDetector(
            onTap: () {
              handleCaptureImage();
            },
            child: Center(
              child: TextBase(
                  text: "Tải xuống",
                  maxLine: 2,
                  style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.NEUTRALS_4,
                      decoration: TextDecoration.underline)),
            ),
          ),
        ],
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Chia sẻ sự kiện",
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        titleStyle: TextStyle(
          fontFamily: Fonts.Lexend.name,
          fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
          fontWeight: FontWeight.w400,
          color: ColorConstants.BLACK,
        ));
  }
}
