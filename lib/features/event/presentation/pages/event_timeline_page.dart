import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class EventTimeLinePage extends StatefulWidget {
  const EventTimeLinePage({super.key});

  @override
  State<EventTimeLinePage> createState() => _EventTimeLinePageState();
}

class _EventTimeLinePageState extends State<EventTimeLinePage> {
  final List<Map<String, String>> schedule = [
    {'time': 'Khung giờ', 'activity': 'Hoạt động'},
    {
      'time': '08h00 - 16h00',
      'activity': 'Check-in\nCheck-in Queen’s Color Team'
    },
    {'time': '08h00 - 10h00', 'activity': 'Tặng quà check-in sớm'},
    {'time': '8h30 - 12h00', 'activity': 'Tặng quà bầu\nCheck-in cực bồng'},
    {
      'time': '8h30 - 18h00',
      'activity':
          'Tặng quà hạng VIP, SVIP, VVIP\nTặng quà thí sinh cuộc thi “Nhật ký mẹ bầu”\nQuầy ăn dặm cho bé\nTham gia phòng Queen’s Room',
    },
    {'time': '9h30 - 16h30', 'activity': 'Đại hội Olympic gia đình'},
    {'time': '9h00 - 15h00', 'activity': 'Ngày hội thể thao Pickleball'},
    {'time': '9h00 - 17h00', 'activity': 'Vòng quay may mắn'},
    {'time': '10h00 - 17h00', 'activity': 'Super Mega Livestream'},
    {
      'time': '11h30 - 15h00',
      'activity':
          'Cuộc thi “Ông chồng của năm”\nGala chung kết Biệt Đội KOLs Nhí 2024'
    },
    {
      'time': '17h00 - 18h00',
      'activity': 'Bốc thăm may mắn\nTrao giải Chiến thần chi tiêu'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        width: DimensionsHelper.iziSize.width,
        height: DimensionsHelper.iziSize.height,
        padding: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              ImagePathConstants.IMAGE_BG_EVENT_SPECIAL,
            ),
          ),
        ),
        child: ListView.separated(
          separatorBuilder: (context, index) {
            return SizedBox(height: DimensionsHelper.HORIZONTAL_SCREEN);
          },
          itemCount: schedule.length,
          itemBuilder: (context, index) {
            return Container(
              clipBehavior: Clip.none,
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Khung giờ
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: DimensionsHelper.SPACE_SIZE_2X,
                          vertical: DimensionsHelper.SPACE_SIZE_2X,
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(
                                    DimensionsHelper.BORDER_RADIUS_4X),
                                topLeft: Radius.circular(
                                    DimensionsHelper.BORDER_RADIUS_4X)),
                            border: Border.all(width: 2, color: Colors.white),
                            color: index == 0
                                ? ColorConstants.PRIMARY_1
                                : ColorConstants.WHITE),
                        child: Center(
                          child: Text(
                            schedule[index]['time']!,
                            style: TextStyle(
                              fontSize: index == 0
                                  ? DimensionsHelper.FONT_SIZE_SPAN_SMALL * 1.1
                                  : DimensionsHelper.FONT_SIZE_SPAN_SMALL *
                                      0.85,
                              fontWeight: index == 0
                                  ? FontWeight.w400
                                  : FontWeight.w400,
                              color: index == 0 ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 2),
                    // Hoạt động
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(
                                    DimensionsHelper.BORDER_RADIUS_4X),
                                topRight: Radius.circular(
                                    DimensionsHelper.BORDER_RADIUS_4X)),
                            border: index == 0
                                ? Border.all(width: 2, color: Colors.white)
                                : null,
                            color: index == 0
                                ? ColorConstants.PRIMARY_1
                                : Colors.transparent),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: schedule[index]['activity']!
                              .split("\n")
                              .asMap()
                              .entries
                              .map((entry) {
                            return Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: index == 0
                                          ? ColorConstants.PRIMARY_1
                                          : Colors.white,
                                      borderRadius: BorderRadius.only(
                                          topRight: entry.key == 0
                                              ? Radius.circular(DimensionsHelper
                                                  .BORDER_RADIUS_4X)
                                              : const Radius.circular(0),
                                          bottomRight: entry.key ==
                                                  schedule[index]['activity']!
                                                          .split("\n")
                                                          .length -
                                                      1
                                              ? Radius.circular(DimensionsHelper
                                                  .BORDER_RADIUS_4X)
                                              : const Radius.circular(0)),
                                      border: index != 0
                                          ? Border.all(
                                              width: 2, color: Colors.white)
                                          : null),
                                  width: DimensionsHelper.iziSize.width,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: DimensionsHelper.SPACE_SIZE_2X,
                                    vertical: DimensionsHelper.SPACE_SIZE_2X,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        entry.value,
                                        style: TextStyle(
                                          fontSize: index == 0
                                              ? DimensionsHelper
                                                      .FONT_SIZE_SPAN_SMALL *
                                                  1.1
                                              : DimensionsHelper
                                                      .FONT_SIZE_SPAN_SMALL *
                                                  0.85,
                                          fontWeight: index == 0
                                              ? FontWeight.w400
                                              : FontWeight.w400,
                                          color: index == 0
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (index != 0 &&
                                    entry.key !=
                                        schedule[index]['activity']!
                                                .split("\n")
                                                .length -
                                            1)
                                  Container(
                                    height: 2,
                                    color: Colors.transparent,
                                  ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  AppBarBase _header() {
    return AppBarBase(
        title: 'Time line',
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
