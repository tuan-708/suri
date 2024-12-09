import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/event/data/models/ticket_info_page_arguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/ticket_info_entity.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_bloc.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_state.dart';

class TicketPage extends StatefulWidget {
  const TicketPage({super.key, required this.args});

  final TicketInfoPageArguments args;

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  late int id;
  // late Profile profile = Profile();
  var captureKey = GlobalKey();

  final _sharedHelper = sl.get<SharedPreferenceHelper>();

  @override
  void initState() {
    super.initState();
    id = widget.args.event.id;

    context.read<EventBloc>().add(GetTicketInfoEvent(id));
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
                return RepaintBoundary(
                  key: captureKey,
                  child: Column(
                    children: [
                      _space(),
                      _boxEvent(state.ticketInfo),
                      _space(),
                      _boxQrCode(state.ticketInfo),
                      _space(),
                    ],
                  ),
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

  Container _boxQrCode(TicketInfoEntity ticket) {
    String cleanBase64 = ticket.info.split(',').last;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(243, 101, 174, 0.2)),
          color: ColorConstants.WHITE,
          borderRadius:
              BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_5X)),
      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
      child: Row(
        children: [
          base64ImageWidget(cleanBase64),
          SizedBox(
            width: DimensionsHelper.SPACE_SIZE_2X,
          ),
          Expanded(
            child: Column(
              children: [
                Center(
                  child: TextBase(
                      maxLine: 2,
                      textAlign: TextAlign.center,
                      text: "Vui lòng sử dụng mã bên cạnh để check in sự kiện",
                      style: TextStyle(
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                        fontWeight: FontWeight.w200,
                        color: ColorConstants.BLACK,
                      )),
                ),
                SizedBox(
                  height: DimensionsHelper.SPACE_SIZE_1X,
                ),
                GestureDetector(
                  onTap: () {
                    handleCaptureImage();
                  },
                  child: Center(
                    child: Text(
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        "Tải xuống",
                        style: TextStyle(
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                          fontWeight: FontWeight.w200,
                          color: ColorConstants.TEXT_2,
                          decoration: TextDecoration.underline,
                        )),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container _boxEvent(TicketInfoEntity ticket) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth >= 600;

    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: const Color.fromRGBO(243, 101, 174, 0.2)),
          color: ColorConstants.WHITE,
          borderRadius:
              BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_5X)),
      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_2X),
      child: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(clipBehavior: Clip.none, children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
                  child: ImageBase(
                    "$BASE_URL${ticket.eventBanner}",
                    height: isTablet
                        ? DimensionsHelper.ONE_UNIT_SIZE * 1000
                        : DimensionsHelper.ONE_UNIT_SIZE * 750,
                  ),
                ),
                if (!state.isProfileLoading! && state.profile != null)
                  Positioned(
                      top: isTablet
                          ? DimensionsHelper.ONE_UNIT_SIZE * 60
                          : DimensionsHelper.ONE_UNIT_SIZE * 125,
                      left: isTablet
                          ? DimensionsHelper.ONE_UNIT_SIZE * 77
                          : DimensionsHelper.ONE_UNIT_SIZE * 40,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            DimensionsHelper.ONE_UNIT_SIZE * 150),
                        child: ImageBase(
                          StringValid.nullOrEmpty(state.profile!.photo)
                              ? ImagePathConstants.IMAGE_USER_TEST
                              : state.profile!.photo!,
                          width: isTablet
                              ? DimensionsHelper.ONE_UNIT_SIZE * 280
                              : DimensionsHelper.ONE_UNIT_SIZE * 160,
                          height: isTablet
                              ? DimensionsHelper.ONE_UNIT_SIZE * 280
                              : DimensionsHelper.ONE_UNIT_SIZE * 160,
                        ),
                      )),
                if (!state.isProfileLoading!)
                  Positioned(
                      top: state.profile!.name!.length > 15
                          ? DimensionsHelper.ONE_UNIT_SIZE * 170
                          : DimensionsHelper.ONE_UNIT_SIZE * 185,
                      left: isTablet
                          ? DimensionsHelper.ONE_UNIT_SIZE * 400
                          : DimensionsHelper.ONE_UNIT_SIZE * 210,
                      child: SizedBox(
                        width: isTablet
                            ? DimensionsHelper.ONE_UNIT_SIZE * 380
                            : DimensionsHelper.ONE_UNIT_SIZE * 240,
                        child: TextBase(
                            maxLine: state.profile!.name!.length > 15 ? 2 : 1,
                            text: state.profile!.name!,
                            style: TextStyle(
                              fontSize: isTablet
                                  ? DimensionsHelper.FONT_SIZE_SPAN * 1.5
                                  : DimensionsHelper.FONT_SIZE_SPAN,
                              fontWeight: FontWeight.w400,
                              color: ColorConstants.WHITE,
                            )),
                      ))
              ]),
              _content(ticket),
              _line(),
              Container(
                padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
                child: Column(
                  children: [
                    _boxAvatar(ticket),
                    SizedBox(
                      height: DimensionsHelper.SPACE_SIZE_2X,
                    ),
                    _boxInfo(ticket)
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Row _boxInfo(TicketInfoEntity ticket) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextBase(
                text: "Số điện thoại",
                style: TextStyle(
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                  fontWeight: FontWeight.w200,
                  color: ColorConstants.TEXT_2,
                )),
            SizedBox(
              height: DimensionsHelper.SPACE_SIZE_1X,
            ),
            TextBase(
                text: StringValid.nullOrEmpty(ticket.accountPhone!)
                    ? "Chưa rõ"
                    : ticket.accountPhone!,
                style: TextStyle(
                  fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                  fontWeight: FontWeight.w400,
                  color: ColorConstants.BLACK,
                )),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // TextBase(
            //     text: "hWDFGA312",
            //     style: TextStyle(
            //       fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
            //       fontWeight: FontWeight.w400,
            //       color: ColorConstants.PRIMARY_1,
            //     )),
            // SizedBox(
            //   height: DimensionsHelper.SPACE_SIZE_1X,
            // ),
            Row(
              children: [
                TextBase(
                    text: "Hạng vé: ",
                    style: TextStyle(
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.TEXT_1,
                    )),
                TextBase(
                    text: ticket.eventAccountTypeName,
                    style: TextStyle(
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                      fontWeight: FontWeight.w400,
                      color: ColorConstants.PRIMARY_1,
                    )),
              ],
            )
          ],
        )
      ],
    );
  }

  BlocBuilder _boxAvatar(TicketInfoEntity ticket) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return Row(
          children: [
            if (!state.isProfileLoading! && state.profile != null)
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.ONE_UNIT_SIZE * 100),
                child: ImageBase(
                  StringValid.nullOrEmpty(state.profile!.photo!)
                      ? ImagePathConstants.IMAGE_USER_TEST
                      : state.profile!.photo!,
                  width: DimensionsHelper.ONE_UNIT_SIZE * 80,
                  height: DimensionsHelper.ONE_UNIT_SIZE * 80,
                ),
              ),
            SizedBox(
              width: DimensionsHelper.SPACE_SIZE_2X,
            ),
            if (!state.isProfileLoading!)
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextBase(
                      text: "Khách mời",
                      style: TextStyle(
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                        fontWeight: FontWeight.w200,
                        color: ColorConstants.TEXT_2,
                      )),
                  SizedBox(
                    height: DimensionsHelper.SPACE_SIZE_1X,
                  ),
                  TextBase(
                      text: state.profile!.name!,
                      style: TextStyle(
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.BLACK,
                      )),
                ],
              ))
          ],
        );
      },
    );
  }

  Container _line() {
    return Container(
      width: DimensionsHelper.iziSize.width,
      height: 1,
      color: ColorConstants.BLACK.withOpacity(0.1),
    );
  }

  Container _content(TicketInfoEntity ticket) {
    return Container(
      padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextBase(
              text: widget.args.event.name,
              maxLine: 2,
              style: TextStyle(
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              )),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_1X * 0.7,
          ),
          Row(
            children: [
              ImageBase(ImagePathConstants.IC_ADDRESS),
              Expanded(
                child: TextBase(
                    maxLine: 2,
                    text: widget.args.event.info,
                    style: TextStyle(
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
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.PRIMARY_1,
                  )),
              TextBase(
                  text: widget.args.event.eventStatusName,
                  style: TextStyle(
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.BLACK,
                  )),
            ],
          ),
        ],
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Vé mời",
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        titleStyle: TextStyle(
          fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
          fontWeight: FontWeight.w400,
          color: ColorConstants.BLACK,
        ));
  }

  Widget base64ImageWidget(String base64String) {
    Uint8List imageBytes = base64Decode(base64String);

    return Image.memory(
      imageBytes,
      width: DimensionsHelper.ONE_UNIT_SIZE * 140,
      height: DimensionsHelper.ONE_UNIT_SIZE * 140,
    );
  }
}
