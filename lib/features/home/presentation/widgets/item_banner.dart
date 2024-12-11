import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/button_linnear_gradient.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/features/event/data/models/event_detail_page_arguments.dart';
import 'package:suri_checking_event_app/features/event/domain/entities/event_entity.dart';
import 'package:intl/intl.dart';

class ItemBanner extends StatelessWidget {
  const ItemBanner({
    super.key,
    required this.event,
  });
  final EventEntity event;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth >= 600;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.07),
                spreadRadius: 0,
                blurRadius: 20,
                offset: Offset(0, 4))
          ],
        ),
        child: Stack(children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.EVENT_DETAIL_PAGE,
                  arguments: EventDetailPageArguments(id: event.id));
            },
            child: SizedBox(
              child: Center(
                  child: ImageBase(
                "$BASE_URL${event.photo}",
                width: DimensionsHelper.iziSize.width * 0.8,
                height: isTablet
                    ? DimensionsHelper.ONE_UNIT_SIZE * 800
                    : DimensionsHelper.ONE_UNIT_SIZE * 475,
                fit: BoxFit.fill,
              )),
            ),
          ),
          Positioned(
            bottom: DimensionsHelper.iziSize.width * 0.03,
            left: DimensionsHelper.iziSize.width * 0.03,
            right: DimensionsHelper.iziSize.width * 0.03,
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.EVENT_DETAIL_PAGE,
                    arguments: EventDetailPageArguments(id: event.id));
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                height: DimensionsHelper.ONE_UNIT_SIZE * 195,
                width: DimensionsHelper.iziSize.width * 0.71,
                decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.07),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: Offset(0, 2))
                    ],
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextBase(
                      maxLine: 2,
                      text: event.name,
                      style: TextStyle(
                        fontFamily: Fonts.Lexend.name,
                        fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.8,
                        fontWeight: FontWeight.w400,
                        color: ColorConstants.BLACK,
                      ),
                    ),
                    SizedBox(
                      height: DimensionsHelper.SPACE_SIZE_1X * 0.8,
                    ),
                    Row(
                      children: [
                        ImageBase(ImagePathConstants.IC_ADDRESS),
                        SizedBox(
                          width: DimensionsHelper.SPACE_SIZE_2X,
                        ),
                        Expanded(
                          child: TextBase(
                              text: event.info,
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
                        ButtonLinearGradient(
                          title: "Tham gia",
                          width: DimensionsHelper.ONE_UNIT_SIZE * 150,
                          height: DimensionsHelper.ONE_UNIT_SIZE * 45,
                          borderRadius: DimensionsHelper.ONE_UNIT_SIZE * 27,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
