import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_linnear_gradient.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/features/event/data/models/ticket_info_special_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/ticket_special_info_entity.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_bloc.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_state.dart';

class TicketSpecialPage extends StatefulWidget {
  const TicketSpecialPage({super.key, required this.args});

  final TicketInfoSpecialPageArguments args;

  @override
  State<TicketSpecialPage> createState() => _TicketSpecialPageState();
}

class _TicketSpecialPageState extends State<TicketSpecialPage> {
  late int id;
  var captureKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    id = widget.args.event.id;
    context.read<EventBloc>().add(GetTicketSpecialInfoEvent(id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: BlocBuilder<EventBloc, EventState>(
            buildWhen: (previous, current) {
              return current is TicketSpecialInfoLoading ||
                  current is TicketSpecialInfoSuccess ||
                  current is TicketSpecialInfoFailure;
            },
            builder: (context, state) {
              if (state is TicketSpecialInfoLoading) {
                return SizedBox(
                    height: DimensionsHelper.iziSize.height -
                        DimensionsHelper.ONE_UNIT_SIZE * 200,
                    child: const Center(
                        child: CircularProgressIndicator(
                      strokeWidth: 2,
                    )));
              }
              if (state is TicketSpecialInfoSuccess) {
                return Column(
                  children: [
                    _space(),
                    _boxEvent(state.ticketInfo),
                  ],
                );
              }

              return SizedBox(
                  height: DimensionsHelper.iziSize.height - 200,
                  child: const BoxEmpty());
            },
          ),
        ),
      ),
    );
  }

  Container _boxEvent(TicketSpecialInfoEntity ticket) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth >= 600;
    final profile = BlocProvider.of<MainBloc>(context);

    return Container(
      decoration: BoxDecoration(
          borderRadius:
              BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_5X)),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RepaintBoundary(
                key: captureKey,
                child: Stack(
                    alignment: Alignment.center,
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            DimensionsHelper.BORDER_RADIUS_4X),
                        child: ImageBase(
                          "$BASE_URL${ticket.eventBanner}",
                          fit: BoxFit.fill,
                          height: isTablet
                              ? DimensionsHelper.ONE_UNIT_SIZE * 1000
                              : DimensionsHelper.ONE_UNIT_SIZE * 850,
                        ),
                      ),
                      Positioned(
                          top: DimensionsHelper.ONE_UNIT_SIZE * 10,
                          right: DimensionsHelper.ONE_UNIT_SIZE * 10,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    DimensionsHelper.BORDER_RADIUS_2X)),
                            child: QrImageView(
                              padding: const EdgeInsets.all(0),
                              data: base64Encode(utf8.encode(
                                  "{\"EventAccountId\": ${ticket.id}, \"AccountId\": ${profile.state.profile!.id!}}")),
                              version: QrVersions.auto,
                              size: DimensionsHelper.ONE_UNIT_SIZE * 70,
                            ),
                          )),
                      if (!state.isProfileLoading! && state.profile != null)
                        Positioned(
                          top: DimensionsHelper.ONE_UNIT_SIZE * 10,
                          left: 0,
                          right: 0,
                          child: Column(
                            children: [
                              TextBase(
                                text: "DEAR",
                                style: TextStyle(
                                  fontFamily: Fonts.Lexend.name,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstants.WHITE,
                                  fontSize: isTablet
                                      ? DimensionsHelper.FONT_SIZE_SPAN * 1.5
                                      : DimensionsHelper.FONT_SIZE_SPAN * 0.7,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: DimensionsHelper.ONE_UNIT_SIZE * 5,
                              ),
                              TextBase(
                                text: state.profile!.name!,
                                style: TextStyle(
                                  fontFamily: Fonts.Lexend.name,
                                  fontWeight: FontWeight.w400,
                                  color: ColorConstants.WHITE,
                                  fontSize: isTablet
                                      ? DimensionsHelper.FONT_SIZE_SPAN * 1.5
                                      : DimensionsHelper.FONT_SIZE_SPAN * 1,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: DimensionsHelper.ONE_UNIT_SIZE * 5,
                              ),
                              TextBase(
                                text: 'YOU ARE CORDIALLY INVITED TO',
                                style: TextStyle(
                                  fontFamily: Fonts.Lexend.name,
                                  fontWeight: FontWeight.w200,
                                  color: ColorConstants.WHITE,
                                  fontSize: isTablet
                                      ? DimensionsHelper.FONT_SIZE_SPAN * 1.5
                                      : DimensionsHelper.FONT_SIZE_SPAN * 0.65,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: DimensionsHelper.ONE_UNIT_SIZE * 7,
                              ),
                              Container(
                                padding: EdgeInsets.all(
                                    DimensionsHelper.ONE_UNIT_SIZE * 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        DimensionsHelper.ONE_UNIT_SIZE * 150)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      DimensionsHelper.ONE_UNIT_SIZE * 150),
                                  child: ImageBase(
                                    StringValid.nullOrEmpty(
                                            state.profile!.photo)
                                        ? ImagePathConstants.IMAGE_USER_TEST
                                        : state.profile!.photo!,
                                    width: isTablet
                                        ? DimensionsHelper.ONE_UNIT_SIZE * 280
                                        : DimensionsHelper.ONE_UNIT_SIZE * 100,
                                    height: isTablet
                                        ? DimensionsHelper.ONE_UNIT_SIZE * 280
                                        : DimensionsHelper.ONE_UNIT_SIZE * 100,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: DimensionsHelper.ONE_UNIT_SIZE * 5,
                              ),
                              TextBase(
                                text: 'MOM & BABY MEGA EXPO',
                                style: TextStyle(
                                  fontFamily: Fonts.Lexend.name,
                                  fontWeight: FontWeight.w200,
                                  color: ColorConstants.WHITE,
                                  fontSize: isTablet
                                      ? DimensionsHelper.FONT_SIZE_SPAN * 1.5
                                      : DimensionsHelper.FONT_SIZE_SPAN * 0.65,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: DimensionsHelper.ONE_UNIT_SIZE * 5,
                              ),
                              ImageBase(
                                ImagePathConstants.IMAGE_TICKET_SPECIAL,
                                width: isTablet
                                    ? DimensionsHelper.ONE_UNIT_SIZE * 280
                                    : DimensionsHelper.ONE_UNIT_SIZE * 350,
                                height: isTablet
                                    ? DimensionsHelper.ONE_UNIT_SIZE * 280
                                    : DimensionsHelper.ONE_UNIT_SIZE * 130,
                              )
                            ],
                          ),
                        ),
                    ]),
              ),
              SizedBox(
                height: DimensionsHelper.SPACE_SIZE_5X,
              ),
              ButtonLinearGradient(
                title: "Tải vé mời",
                onTap: () {
                  handleCaptureImage();
                },
                height: DimensionsHelper.ONE_UNIT_SIZE * 65,
                fonSize: DimensionsHelper.ONE_UNIT_SIZE * 24,
              )
            ],
          );
        },
      ),
    );
  }

  SizedBox _space() {
    return SizedBox(
      height: DimensionsHelper.HORIZONTAL_SCREEN,
    );
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
              title: 'Tải vé mời thành công', context: context);
        }
      } catch (e) {
        ToastHelper.toastError(title: 'Lỗi tải vé mời', context: context);
      }
    }
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Vé mời sự kiện đặc biệt",
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
