import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suri_checking_event_app/core/base_widgets/box_empty.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_linnear_gradient.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/timer_coundown.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/helper/toast_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_special_detail_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/list_event_payload.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_event.dart';
import 'package:suri_checking_event_app/features/event/presentation/bloc/event_state.dart';
import 'package:suri_checking_event_app/features/event/presentation/pages/list_event_page.dart';
import 'package:suri_checking_event_app/features/home/presentation/widgets/item_banner.dart';
import 'package:suri_checking_event_app/features/home/presentation/widgets/item_sponsor.dart';
import 'package:suri_checking_event_app/core/base_widgets/loading_image_card.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_bloc.dart';
import 'package:suri_checking_event_app/features/main/presentation/bloc/main_state.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/list_sponsor_payload.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_bloc.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_event.dart';
import 'package:suri_checking_event_app/features/sponsor/presentation/bloc/sponsor_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imgList = [
    ImagePathConstants.IMAGE_SLIDER,
    ImagePathConstants.IMAGE_SLIDER,
    ImagePathConstants.IMAGE_SLIDER,
  ];

  final sharedHelper = sl.get<SharedPreferenceHelper>();

  late int pageIndex = 1;
  late int pageSize = 20;
  late bool isKol = true;
  final _sharedHelper = sl.get<SharedPreferenceHelper>();

  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(GetEventDetail(1042));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isShowModalSpecialEvent = sharedHelper.getShowModalSpecialEvent;

      if (isShowModalSpecialEvent) {
        showModalSpecialEvent(context);
      }
    });

    ListSponsorsPayload payloadSponsors =
        ListSponsorsPayload(pageIndex: pageIndex, pageSize: pageSize);

    context.read<SponsorBloc>().add(GetListSponsors(payloadSponsors));

    ListEventsPayload payloadEvents = ListEventsPayload(
        pageIndex: pageIndex,
        pageSize: pageSize,
        statusId: statusEvent['Sắp diễn ra']);

    context.read<EventBloc>().add(GetHomeEvent(payloadEvents));
  }

  void showModalSpecialEvent(BuildContext contextParent) async {
    await showDialog(
      context: contextParent,
      builder: (BuildContext dialogContext) {
        return Dialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: BlocBuilder<EventBloc, EventState>(
              buildWhen: (previous, current) {
                return current is EventDetailLoading ||
                    current is EventDetailSuccess ||
                    current is EventDetailFailure;
              },
              builder: (context, state) {
                if (state is EventDetailSuccess) {
                  return SizedBox(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 530,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      child: SizedBox(
                          height: DimensionsHelper.ONE_UNIT_SIZE * 530,
                          child: Stack(children: [
                            GestureDetector(
                              onTap: () {
                                if (StringValid.nullOrEmpty(
                                    _sharedHelper.getJwtToken)) {
                                  ToastHelper.toastInfo(
                                      title:
                                          "Vui lòng đăng nhập để xem sự kiện",
                                      context: contextParent);
                                } else {
                                  Navigator.pushNamed(context,
                                      AppRoutes.EVENT_SPECIAL_DETAIL_PAGE,
                                      arguments:
                                          EventDetailSpecialPageArguments(
                                              event: state.event!));
                                }
                              },
                              child: ImageBase(
                                StringValid.url(state.event!.photo),
                                height: DimensionsHelper.ONE_UNIT_SIZE * 530,
                              ),
                            ),
                            Positioned(
                                right: 10,
                                top: 10,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pop(dialogContext);
                                  },
                                  child: ImageBase(
                                    ImagePathConstants.IC_CLOSE,
                                    height: DimensionsHelper.ONE_UNIT_SIZE * 40,
                                    width: DimensionsHelper.ONE_UNIT_SIZE * 40,
                                  ),
                                ))
                          ])),
                    ),
                  );
                }

                return Container(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 530,
                    color: Colors.transparent);
              },
            ));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              ColorConstants.LINEAR_GRADIENT3,
              ColorConstants.LINEAR_GRADIENT4
            ])),
        padding: EdgeInsets.symmetric(
            horizontal: DimensionsHelper.ONE_UNIT_SIZE * 15),
        child: Stack(children: [
          Column(
            children: [
              _header(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: DimensionsHelper.ONE_UNIT_SIZE * 15,
                      ),
                      if (isKol)
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, AppRoutes.QUEUE_TABLE_KOL_PAGE);
                          },
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  DimensionsHelper.BORDER_RADIUS_5X),
                              child: ImageBase(
                                ImagePathConstants.IMAGE_BG_KOL,
                                width: DimensionsHelper.iziSize.width,
                                height: DimensionsHelper.ONE_UNIT_SIZE * 300,
                              )),
                        )
                      else
                        _banner(),
                      SizedBox(
                        height: DimensionsHelper.ONE_UNIT_SIZE * 15,
                      ),
                      _header1(),
                      _slider(),
                      _header2(),
                      _listSponsors(),
                      SizedBox(
                        height: DimensionsHelper.SPACE_SIZE_5X,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
              bottom: DimensionsHelper.ONE_UNIT_SIZE * 10,
              right: DimensionsHelper.ONE_UNIT_SIZE * 0,
              child: BlocBuilder<EventBloc, EventState>(
                buildWhen: (previous, current) {
                  return current is EventDetailLoading ||
                      current is EventDetailSuccess ||
                      current is EventDetailFailure;
                },
                builder: (context, state) {
                  if (state is EventDetailSuccess) {
                    return GestureDetector(
                      onTap: () {
                        if (StringValid.nullOrEmpty(
                            _sharedHelper.getJwtToken)) {
                          ToastHelper.toastInfo(
                              title: "Vui lòng đăng nhập để xem sự kiện",
                              context: context);
                        } else {
                          Navigator.pushNamed(
                              context, AppRoutes.EVENT_SPECIAL_DETAIL_PAGE,
                              arguments: EventDetailSpecialPageArguments(
                                  event: state.event!));
                        }
                      },
                      child: Column(
                        children: [
                          // Lottie.asset(
                          //   ImagePathConstants.GIF_EVENT,
                          //   width: DimensionsHelper.ONE_UNIT_SIZE * 170,
                          //   height: DimensionsHelper.ONE_UNIT_SIZE * 170,
                          // ),
                          ImageBase(
                            ImagePathConstants.IMG_EVENT_HOME,
                            width: DimensionsHelper.ONE_UNIT_SIZE * 170,
                            height: DimensionsHelper.ONE_UNIT_SIZE * 130,
                          ),
                          SizedBox(
                            height: DimensionsHelper.ONE_UNIT_SIZE * 5,
                          ),
                          TimerCountdown(
                            format: CountDownTimerFormat.daysHours,
                            enableDescriptions: false,
                            spacerWidth: 3,
                            descriptionTextStyle: TextStyle(
                                fontSize: DimensionsHelper.ONE_UNIT_SIZE * 18),
                            timeTextStyle: TextStyle(
                                fontSize: DimensionsHelper.ONE_UNIT_SIZE * 18),
                            daysDescription: " ngày",
                            hoursDescription: " giờ",
                            endTime: DateTime(2024, 12, 15, 8, 0),
                            onEnd: () {
                              ToastHelper.toastInfo(
                                  title:
                                      'Sự kiện cộng đồng 15.12 đang diễn ra.',
                                  context: context);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  return Container();
                },
              ))
        ]),
      ),
    );
  }

  _listSponsors() {
    return BlocBuilder<SponsorBloc, SponsorState>(
      buildWhen: (previous, current) {
        return current is GetSponsorsSuccess ||
            current is GetSponsorsLoading ||
            current is GetSponsorsFailure;
      },
      builder: (context, state) {
        if (state is GetSponsorsLoading) {
          return GridView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: DimensionsHelper.HORIZONTAL_SCREEN,
                mainAxisSpacing: DimensionsHelper.HORIZONTAL_SCREEN,
                mainAxisExtent: DimensionsHelper.ONE_UNIT_SIZE * 400,
              ),
              itemCount: 6,
              itemBuilder: (BuildContext context, int index) {
                return const LoadingImageCard();
              });
        }
        if (state is GetSponsorsFailure) {
          return const BoxEmpty();
        }

        if (state is GetSponsorsSuccess && (state.sponsors ?? []).isNotEmpty) {
          double screenWidth = MediaQuery.of(context).size.width;
          bool isTablet = screenWidth >= 600;

          return GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: DimensionsHelper.HORIZONTAL_SCREEN,
              mainAxisSpacing: DimensionsHelper.HORIZONTAL_SCREEN,
              mainAxisExtent: isTablet
                  ? DimensionsHelper.ONE_UNIT_SIZE * 550
                  : DimensionsHelper.ONE_UNIT_SIZE * 400,
            ),
            itemCount: state.sponsors!.length,
            itemBuilder: (BuildContext context, int index) {
              return ItemSponsor(
                  id: state.sponsors![index].id,
                  imageUrl: state.sponsors![index].photo,
                  title: state.sponsors![index].name,
                  subTitle: state.sponsors![index].description);
            },
          );
        }

        return Container();
      },
    );
  }

  Container _slider() {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: DimensionsHelper.ONE_UNIT_SIZE * 15),
      child: BlocBuilder<EventBloc, EventState>(
        buildWhen: (previous, current) {
          return current is HomeEventsLoading ||
              current is HomeEventsSuccess ||
              current is HomeEventsFailure;
        },
        builder: (context, state) {
          if (state is HomeEventsLoading) {
            return CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 1.3,
                  enlargeCenterPage: true,
                ),
                items: imgList
                    .map((item) => LoadingImageCard(
                          width: DimensionsHelper.iziSize.width * 0.8,
                          height: DimensionsHelper.ONE_UNIT_SIZE * 475,
                        ))
                    .toList());
          }

          if (state is HomeEventsSuccess) {
            return CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  aspectRatio: 1.3,
                  initialPage: 6,
                  enlargeCenterPage: true,
                ),
                items: (state.list ?? [])
                    .map((item) => ItemBanner(
                          event: item,
                        ))
                    .toList());
          }
          return const BoxEmpty();
        },
      ),
    );
  }

  GestureDetector _header1() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ListEventPage(),
            ));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextBase(
              text: "Sự kiện nổi bật",
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize: DimensionsHelper.FONT_SIZE_SPAN * 1.05,
                fontWeight: FontWeight.w400,
                color: ColorConstants.BLACK,
              ),
            ),
            ButtonLinearGradient(
              title: "Xem thêm",
              width: DimensionsHelper.ONE_UNIT_SIZE * 150,
              borderRadius: DimensionsHelper.ONE_UNIT_SIZE * 30,
            )
          ],
        ),
      ),
    );
  }

  Container _header2() {
    return Container(
      padding: const EdgeInsets.only(top: 10, bottom: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextBase(
            text: "Danh sách nhà tài trợ",
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * 1.05,
              fontWeight: FontWeight.w400,
              color: ColorConstants.BLACK,
            ),
          ),
          // ButtonLinearGradient(
          //   title: "Xem thêm",
          //   width: DimensionsHelper.ONE_UNIT_SIZE * 150,
          //   borderRadius: DimensionsHelper.ONE_UNIT_SIZE * 30,
          // )
        ],
      ),
    );
  }

  Stack _banner() {
    return Stack(clipBehavior: Clip.none, children: [
      ImageBase(ImagePathConstants.IMAGE_BANNER),
      Positioned(
        right: 20,
        top: -10,
        child: ImageBase(
          ImagePathConstants.IMAGE_BANNER1,
          width: DimensionsHelper.ONE_UNIT_SIZE * 207.5,
          height: DimensionsHelper.ONE_UNIT_SIZE * 187.5,
        ),
      ),
    ]);
  }

  Container _header() {
    return Container(
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        padding: EdgeInsets.symmetric(
          vertical: DimensionsHelper.ONE_UNIT_SIZE * 15,
        ),
        height: DimensionsHelper.ONE_UNIT_SIZE * 117,
        width: DimensionsHelper.iziSize.width,
        child: BlocBuilder<MainBloc, MainState>(
          builder: (context, state) {
            if (!state.isProfileLoading! && state.profile != null) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TextBase(text: "Hello!"),
                      Row(
                        children: [
                          TextBase(text: state.profile!.name!),
                          SizedBox(
                            width: DimensionsHelper.SPACE_SIZE_1X,
                          ),
                          ImageBase(ImagePathConstants.IC_SMILE)
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            DimensionsHelper.ONE_UNIT_SIZE * 50),
                        child: ImageBase(
                          state.profile!.photo!,
                          width: DimensionsHelper.ONE_UNIT_SIZE * 80,
                          height: DimensionsHelper.ONE_UNIT_SIZE * 80,
                        ),
                      )
                    ],
                  )
                ],
              );
            }
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const TextBase(text: "Suri, xin chào!"),
                    Row(
                      children: [
                        const TextBase(text: "Vui lòng đăng nhập"),
                        SizedBox(
                          width: DimensionsHelper.SPACE_SIZE_1X,
                        ),
                        ImageBase(ImagePathConstants.IC_SMILE)
                      ],
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.LOGIN_PAGE);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            DimensionsHelper.ONE_UNIT_SIZE * 50),
                        child: Container(
                          height: DimensionsHelper.ONE_UNIT_SIZE * 65,
                          width: DimensionsHelper.ONE_UNIT_SIZE * 65,
                          padding: const EdgeInsets.all(5),
                          decoration: const BoxDecoration(
                              color: ColorConstants.PRIMARY_1),
                          child: ImageBase(
                            ImagePathConstants.IC_LOGIN,
                            width: DimensionsHelper.ONE_UNIT_SIZE * 40,
                            height: DimensionsHelper.ONE_UNIT_SIZE * 40,
                            colorIconsSvg: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            );
          },
        ));
  }
}
