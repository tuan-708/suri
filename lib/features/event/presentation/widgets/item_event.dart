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

class ItemEvent extends StatefulWidget {
  const ItemEvent(
      {super.key,
      required this.id,
      required this.imageUrl,
      required this.name,
      required this.info,
      required this.startDate,
      required this.isSpecialEvent});
  final String imageUrl;
  final String name;
  final String info;
  final String startDate;
  final int id;
  final bool isSpecialEvent;

  @override
  State<ItemEvent> createState() => _ItemEventState();
}

class _ItemEventState extends State<ItemEvent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.EVENT_DETAIL_PAGE,
            arguments: EventDetailPageArguments(id: widget.id));
      },
      child: Container(
          padding: EdgeInsets.all(DimensionsHelper.HORIZONTAL_SCREEN),
          child: Column(
            children: [
              Row(
                children: [
                  _image(),
                  SizedBox(
                    width: DimensionsHelper.SPACE_SIZE_2X,
                  ),
                  _description(),
                ],
              ),
              // SizedBox(
              //   height: DimensionsHelper.SPACE_SIZE_2X,
              // ),
              // _btn()
            ],
          )),
    );
  }

  Row _btn() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: DimensionsHelper.ONE_UNIT_SIZE * 55,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
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
                  text: " QR Sự kiện",
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
        SizedBox(
          width: DimensionsHelper.SPACE_SIZE_2X,
        ),
        Expanded(
          child: Container(
            height: DimensionsHelper.ONE_UNIT_SIZE * 55,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
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
        SizedBox(
          width: DimensionsHelper.SPACE_SIZE_2X,
        ),
        Expanded(
          child: ButtonLinearGradient(
            title: "Tham gia",
            borderRadius: DimensionsHelper.ONE_UNIT_SIZE * 17,
          ),
        )
      ],
    );
  }

  Expanded _description() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextBase(
            text: widget.name,
            maxLine: 2,
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
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
                width: DimensionsHelper.SPACE_SIZE_1X,
              ),
              Expanded(
                child: TextBase(
                    text: widget.info,
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
                  text: widget.startDate,
                  style: TextStyle(
                    fontFamily: Fonts.Lexend.name,
                    fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                    fontWeight: FontWeight.w400,
                    color: ColorConstants.PRIMARY_1,
                  )),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector _image() {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(DimensionsHelper.BORDER_RADIUS_4X),
        child: ImageBase(
          '$BASE_URL${widget.imageUrl}',
          height: DimensionsHelper.ONE_UNIT_SIZE * 134,
          width: DimensionsHelper.ONE_UNIT_SIZE * 170,
        ),
      ),
    );
  }
}
