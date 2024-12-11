import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_special_detail_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/spin_wheel_arguments.dart';
import 'package:suri_checking_event_app/features/event/data/models/ticket_info_special_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/presentation/widgets/item_event_special.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/list_gift_event_arguments.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/list_ponsors_event_page_arguments.dart';
import 'package:widget_zoom/widget_zoom.dart';

class EventSpecialDetailPage extends StatefulWidget {
  const EventSpecialDetailPage({super.key, required this.args});
  final EventDetailSpecialPageArguments args;

  @override
  State<EventSpecialDetailPage> createState() => _EventSpecialDetailPageState();
}

class _EventSpecialDetailPageState extends State<EventSpecialDetailPage> {
  final _sharedHelper = sl.get<SharedPreferenceHelper>();

  final List<String> items = [
    'Deal hot',
    'Gian hàng',
    'Quà của tôi',
    'Timeline',
    'Vote',
    'Hạng của tôi',
    'Vé mời',
    'Vòng quay',
    'Hướng dẫn',
  ];

  final List<String> icons = [
    ImagePathConstants.IC_DEAL_HOT,
    ImagePathConstants.IC_BOOTH,
    ImagePathConstants.IC_My_GIFT,
    ImagePathConstants.IC_TIMELINE,
    ImagePathConstants.IC_VOTE,
    ImagePathConstants.IC_MY_RANK,
    ImagePathConstants.IC_TICKET_SPECIAL,
    ImagePathConstants.IC_WHEEL_SPIN,
    ImagePathConstants.IC_GUIDE,
  ];

  late List<VoidCallback> callbacks;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      callbacks = [
        () => Navigator.pushNamed(context, AppRoutes.DEAL_HOT_PAGE),
        () => Navigator.pushNamed(context, AppRoutes.LIST_SPONSORS_EVENT_PAGE,
            arguments:
                ListSponsorsEventPageArguments(id: widget.args.event.id)),
        () => Navigator.pushNamed(context, AppRoutes.MY_GIFT_EVENT_PAGE,
            arguments: ListGiftEventArguments(id: widget.args.event.id)),
        () => Navigator.pushNamed(context, AppRoutes.EVENT_TIMELINE_PAGE),
        () => Navigator.pushNamed(context, AppRoutes.QUEUE_TABLE_KOL_PAGE),
        () => Navigator.pushNamed(context, AppRoutes.MY_RANK_PAGE),
        () {
          Navigator.pushNamed(context, AppRoutes.TICKET_SPECIAL_PAGE,
              arguments:
                  TicketInfoSpecialPageArguments(event: widget.args.event));
        },
        () => Navigator.pushNamed(context, AppRoutes.SPIN_WHEEL_PAGE,
            arguments: SpinWheelArguments(
                eventId: widget.args.event.id,
                token: _sharedHelper.getJwtToken)),
        () => Navigator.pushNamed(context, AppRoutes.EVENT_GUIDE_PAGE),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: DimensionsHelper.HORIZONTAL_SCREEN * 1.2,
                vertical: DimensionsHelper.HORIZONTAL_SCREEN,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    ImagePathConstants.IMAGE_BG_EVENT_SPECIAL,
                  ),
                ),
              ),
              child: Column(
                children: [
                  WidgetZoom(
                    heroAnimationTag: 'tag',
                    zoomWidget: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          DimensionsHelper.BORDER_RADIUS_5X),
                      child: ImageBase(
                        "$BASE_URL/upload/admin/banner-1512.jpg",
                        fit: BoxFit.fitWidth,
                        width: DimensionsHelper.iziSize.width,
                        height: DimensionsHelper.ONE_UNIT_SIZE * 220 * 1.25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: DimensionsHelper.SPACE_SIZE_4X,
                  ),
                  SizedBox(
                    height: DimensionsHelper.ONE_UNIT_SIZE * 850,
                    child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // Số cột
                          crossAxisSpacing:
                              DimensionsHelper.HORIZONTAL_SCREEN * 1.5,
                          mainAxisSpacing:
                              DimensionsHelper.HORIZONTAL_SCREEN * 0.4,
                          childAspectRatio:
                              0.68, // Tỷ lệ giữa chiều rộng và chiều cao
                        ),
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return ItemEventSpecial(
                              key: Key('$index'),
                              onTap: (index) {
                                callbacks[index]();
                              },
                              index: index,
                              icon: icons[index],
                              item: items[index]);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: widget.args.event.name,
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
