import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/routers/app_router.dart';
import 'package:suri_checking_event_app/features/sponsor/data/models/sponsor_detail_page_arguments.dart';

class ItemSponsor extends StatelessWidget {
  const ItemSponsor(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.subTitle,
      required this.id});
  final String imageUrl;
  final String title;
  final String subTitle;
  final int id;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isTablet = screenWidth >= 600;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.SPONSOR_DETAIL_PAGE,
            arguments: SponsorDetailPageArguments(id: id));
      },
      child: AbsorbPointer(
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ColorConstants.PRIMARY_2, width: 0.2),
              borderRadius:
                  BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_5X)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft:
                            Radius.circular(DimensionsHelper.BORDER_RADIUS_5X),
                        topRight: Radius.circular(
                            DimensionsHelper.BORDER_RADIUS_5X))),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_3X),
                  child: ImageBase(
                    '$BASE_URL$imageUrl',
                    height: isTablet
                        ? DimensionsHelper.ONE_UNIT_SIZE * 400
                        : DimensionsHelper.ONE_UNIT_SIZE * 200,
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextBase(
                        text: title,
                        textAlign: TextAlign.center,
                        maxLine: 3,
                        style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * .9,
                          fontWeight: FontWeight.w400,
                          color: ColorConstants.BLACK,
                        )),
                    SizedBox(
                      height: DimensionsHelper.SPACE_SIZE_1X,
                    ),
                    TextBase(
                        maxLine: 3,
                        text: subTitle,
                        style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.8,
                          fontWeight: FontWeight.w200,
                          color: ColorConstants.BLACK,
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
