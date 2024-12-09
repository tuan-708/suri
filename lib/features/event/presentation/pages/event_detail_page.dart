import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_linnear_gradient.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_detail_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_special_detail_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/share_event_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/spin_wheel_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/ticket_info_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/ticket_info_special_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_detail_entity.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';
import 'package:intl/intl.dart';
import 'package:suri_checking_event_app/features/gift/data/models/gift_event_detail_page_arguments.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({super.key, required this.args});
  final EventDetailPageArguments args;

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late int id;

  Offset _position = Offset(DimensionsHelper.iziSize.width * 0.7,
      DimensionsHelper.iziSize.height * 0.73);
  final Offset _dragOffset = Offset.zero;
  final _sharedHelper = sl.get<SharedPreferenceHelper>();

  @override
  void initState() {
    super.initState();
    id = widget.args.id;

    context.read<EventBloc>().add(GetEventDetail(id));
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return BlocBuilder<EventBloc, EventState>(
      buildWhen: (previous, current) {
        return current is EventDetailLoading ||
            current is EventDetailSuccess ||
            current is EventDetailFailure;
      },
      builder: (context, state) {
        double screenWidth = MediaQuery.of(context).size.width;
        bool isTablet = screenWidth >= 600;

        return Scaffold(
            appBar: _header(state),
            body: Stack(children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (state is EventDetailLoading)
                      const Expanded(
                          child: Center(
                              child: CircularProgressIndicator(
                        strokeWidth: 2,
                      )))
                    else if (state is EventDetailSuccess)
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              _banner(state.event!),
                              Container(
                                padding: EdgeInsets.only(
                                  top: DimensionsHelper.ONE_UNIT_SIZE * 20,
                                  left: DimensionsHelper.HORIZONTAL_SCREEN,
                                  right: DimensionsHelper.HORIZONTAL_SCREEN,
                                ),
                                child: Column(
                                  children: [
                                    Center(
                                      child: Text("Thông tin sự kiện",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: Fonts.Lexend.name,
                                            fontSize: DimensionsHelper
                                                    .FONT_SIZE_SPAN *
                                                0.9,
                                            fontWeight: FontWeight.w400,
                                            color: ColorConstants.BLACK,
                                          )),
                                    ),
                                    SizedBox(
                                      height: DimensionsHelper.SPACE_SIZE_2X,
                                    ),
                                    Text(state.event!.description),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                            height:
                                                DimensionsHelper.SPACE_SIZE_2X);
                                      },
                                      itemCount:
                                          state.event!.imageString.length,
                                      itemBuilder: (context, index) {
                                        return ImageBase(
                                          '$BASE_URL${state.event!.imageString[index]}',
                                          fit: BoxFit.fitHeight,
                                          height: isTablet
                                              ? DimensionsHelper.ONE_UNIT_SIZE *
                                                  700
                                              : DimensionsHelper.ONE_UNIT_SIZE *
                                                  550,
                                        );
                                      },
                                    ),
                                    SizedBox(
                                      height:
                                          DimensionsHelper.HORIZONTAL_SCREEN,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (state is EventDetailSuccess) switchButton(state.event!)
                  ],
                ),
              ),
              spinWheel(screenSize)
            ]));
      },
    );
  }

  GestureDetector switchButton(EventDetailEntity event) {
    if (event.isSender == false && event.eventStatusName == "Sắp diễn ra") {
      return _btnRegister(event);
    }

    if (event.isSender == true &&
        event.eventStatusName == "Sắp diễn ra" &&
        event.isSpecialEvent == true) {
      return GestureDetector(
        child: _btnJoinEvent(event),
      );
    }
    return GestureDetector(
      child: const Text(''),
    );
  }

  Positioned spinWheel(Size screenSize) {
    return Positioned(
      left: _position.dx,
      top: _position.dy,
      child: GestureDetector(
        onTap: () {
          if (StringValid.nullOrEmpty(_sharedHelper.getJwtToken)) {
            Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
          } else {
            Navigator.pushNamed(context, AppRoutes.SPIN_WHEEL_PAGE,
                arguments: SpinWheelArguments(
                    eventId: id, token: _sharedHelper.getJwtToken));
          }
        },
        onPanUpdate: (details) {
          double newX = _position.dx + details.delta.dx;
          double newY = _position.dy + details.delta.dy;

          if (newX < screenSize.width * 0.7 &&
              newY < screenSize.height * 0.76) {
            setState(() {
              _position = Offset(
                newX.clamp(
                    0, screenSize.width - DimensionsHelper.ONE_UNIT_SIZE * 160),
                newY.clamp(0,
                    screenSize.height - DimensionsHelper.ONE_UNIT_SIZE * 120),
              );
            });
          }
        },
        child: Container(
            width: DimensionsHelper.ONE_UNIT_SIZE * 160,
            height: DimensionsHelper.ONE_UNIT_SIZE * 120,
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(66, 134, 133, 133),
                  blurRadius: 100,
                  offset: Offset(0, 0.5),
                ),
              ],
            ),
            child: ImageBase(ImagePathConstants.IMAGE_SPIN_WHEEL)),
      ),
    );
  }

  GestureDetector _btnRegister(event) {
    return GestureDetector(
      onTap: () {
        if (StringValid.nullOrEmpty(_sharedHelper.getJwtToken)) {
          Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
        } else {
          Navigator.pushNamed(context, AppRoutes.REGISTER_EVENT_PAGE,
              arguments: event);
        }
      },
      child: AbsorbPointer(
        child: Container(
          width: DimensionsHelper.iziSize.width,
          height: DimensionsHelper.ONE_UNIT_SIZE * 70,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: Offset(0, 4))
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X),
                topRight: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X),
              ),
              gradient: const LinearGradient(colors: [
                ColorConstants.LINEAR_GRADIENT1,
                ColorConstants.LINEAR_GRADIENT2
              ])),
          child: Center(
            child: TextBase(
              text: "Đăng ký tham gia",
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w300,
                color: ColorConstants.WHITE,
              ),
            ),
          ),
        ),
      ),
    );
  }

  GestureDetector _btnJoinEvent(event) {
    return GestureDetector(
      onTap: () {
        if (StringValid.nullOrEmpty(_sharedHelper.getJwtToken)) {
          Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
        } else {
          Navigator.pushNamed(context, AppRoutes.EVENT_SPECIAL_DETAIL_PAGE,
              arguments: EventDetailSpecialPageArguments(event: event));
        }
      },
      child: AbsorbPointer(
        child: Container(
          width: DimensionsHelper.iziSize.width,
          height: DimensionsHelper.ONE_UNIT_SIZE * 70,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.05),
                    spreadRadius: 0,
                    blurRadius: 20,
                    offset: Offset(0, 4))
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X),
                topRight: Radius.circular(DimensionsHelper.BORDER_RADIUS_3X),
              ),
              gradient: const LinearGradient(colors: [
                ColorConstants.LINEAR_GRADIENT1,
                ColorConstants.LINEAR_GRADIENT2
              ])),
          child: Center(
            child: TextBase(
              text: "Tham gia sự kiện",
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                fontWeight: FontWeight.w300,
                color: ColorConstants.WHITE,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Stack _banner(EventDetailEntity event) {
    return Stack(clipBehavior: Clip.none, children: [
      Container(
          padding:
              EdgeInsets.only(bottom: DimensionsHelper.ONE_UNIT_SIZE * 120),
          child: Column(
            children: [
              ImageBase(
                '$BASE_URL${event.photo}',
                width: DimensionsHelper.iziSize.width,
                height: DimensionsHelper.ONE_UNIT_SIZE * 400,
                fit: BoxFit.cover,
              ),
            ],
          )),
      Positioned(
          bottom: -DimensionsHelper.ONE_UNIT_SIZE * 0,
          child: Container(
            padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
            margin: EdgeInsets.symmetric(
                horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
            width: DimensionsHelper.iziSize.width -
                DimensionsHelper.HORIZONTAL_SCREEN * 2,
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                      spreadRadius: 0,
                      blurRadius: 20,
                      offset: Offset(0, 4))
                ],
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_5X),
                color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextBase(
                    text: event.name,
                    maxLine: 2,
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
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
                    SizedBox(
                      width: DimensionsHelper.SPACE_SIZE_1X,
                    ),
                    Expanded(
                      child: TextBase(
                          text: event.info,
                          maxLine: 2,
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
                            .format(event.startDate),
                        style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.PRIMARY_1,
                        )),
                    TextBase(
                        text: event.eventStatusName,
                        style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.PRIMARY_3,
                        )),
                  ],
                ),
                SizedBox(
                  height: DimensionsHelper.SPACE_SIZE_1X * 0.7,
                ),
                _btn(event)
              ],
            ),
          )),
    ]);
  }

  Row _btn(EventDetailEntity event) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (event.isSender == true && event.eventStatusName == "Sắp diễn ra")
          Expanded(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.SHARE_EVENT_PAGE,
                    arguments: ShareEventPageArguments(event: event));
              },
              child: AbsorbPointer(
                child: Container(
                  height: DimensionsHelper.ONE_UNIT_SIZE * 55,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          DimensionsHelper.BORDER_RADIUS_4X),
                      border: Border.all(color: ColorConstants.BORDER)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ImageBase(
                        ImagePathConstants.IC_QR,
                        width: DimensionsHelper.ONE_UNIT_SIZE * 25,
                        height: DimensionsHelper.ONE_UNIT_SIZE * 25,
                      ),
                      TextBase(
                        text: " Mã QR",
                        style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.8,
                          fontWeight: FontWeight.w200,
                          color: ColorConstants.BLACK,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        if (event.isSender == true && event.eventStatusName == "Sắp diễn ra")
          SizedBox(
            width: DimensionsHelper.SPACE_SIZE_2X,
          ),
        if (event.isSender == true && event.eventStatusName == "Sắp diễn ra")
          Expanded(
            child: InkWell(
              onTap: () {
                event.isSpecialEvent
                    ? Navigator.pushNamed(
                        context, AppRoutes.TICKET_SPECIAL_PAGE,
                        arguments: TicketInfoSpecialPageArguments(event: event))
                    : Navigator.pushNamed(context, AppRoutes.TICKET_PAGE,
                        arguments: TicketInfoPageArguments(event: event));
              },
              child: Container(
                height: DimensionsHelper.ONE_UNIT_SIZE * 55,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        DimensionsHelper.BORDER_RADIUS_4X),
                    border: Border.all(color: ColorConstants.BORDER)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImageBase(
                      ImagePathConstants.IC_TICKET,
                      width: DimensionsHelper.ONE_UNIT_SIZE * 25,
                      height: DimensionsHelper.ONE_UNIT_SIZE * 25,
                    ),
                    TextBase(
                      text: " Vé mời",
                      style: TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.8,
                        fontWeight: FontWeight.w200,
                        color: ColorConstants.BLACK,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        if (event.isSender == true && event.eventStatusName == "Sắp diễn ra")
          SizedBox(
            width: DimensionsHelper.SPACE_SIZE_2X,
          ),
        Expanded(
          child: ButtonLinearGradient(
            onTap: () {
              if (StringValid.nullOrEmpty(_sharedHelper.getJwtToken)) {
                Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
              } else {
                Navigator.pushNamed(context, AppRoutes.GIFT_EVENT_DETAIL_PAGE,
                    arguments: GiftEventDetailPageArguments(id: id));
              }
            },
            title: "Xem quà",
            fontWeight: FontWeight.w400,
            borderRadius: DimensionsHelper.ONE_UNIT_SIZE * 15,
          ),
        )
      ],
    );
  }

  AppBarBase _header(EventState state) {
    return AppBarBase(
        title: state is EventDetailLoading
            ? "Đang tải ..."
            : state is EventDetailSuccess
                ? state.event!.name
                : '',
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
