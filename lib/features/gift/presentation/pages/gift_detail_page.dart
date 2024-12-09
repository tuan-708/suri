import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/app_bar_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/features/gift/data/models/gift_event_detail_page_arguments.dart';

class GiftDetailPage extends StatefulWidget {
  const GiftDetailPage({super.key, required this.args});

  final GiftEventDetailPageArguments args;

  @override
  State<GiftDetailPage> createState() => _GiftDetailPageState();
}

class _GiftDetailPageState extends State<GiftDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _header(),
      body: Container(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              _banner(),
              Container(
                padding: EdgeInsets.only(
                  top: DimensionsHelper.ONE_UNIT_SIZE * 120,
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
                            fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                            fontWeight: FontWeight.w400,
                            color: ColorConstants.BLACK,
                          )),
                    ),
                    SizedBox(
                      height: DimensionsHelper.SPACE_SIZE_2X,
                    ),
                    const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stack _banner() {
    return Stack(clipBehavior: Clip.none, children: [
      ImageBase(
        ImagePathConstants.IMAGE_GIFT,
        width: DimensionsHelper.iziSize.width,
      ),
      Positioned(
          bottom: -DimensionsHelper.ONE_UNIT_SIZE * 80,
          child: Container(
            padding: EdgeInsets.all(DimensionsHelper.SPACE_SIZE_3X),
            margin: EdgeInsets.symmetric(
                horizontal: DimensionsHelper.HORIZONTAL_SCREEN),
            height: DimensionsHelper.ONE_UNIT_SIZE * 160,
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextBase(
                  text: "Quà tặng khi check in ",
                  maxLine: 2,
                  style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      color: ColorConstants.BLACK,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    TextBase(
                      text: "Giá trị lên đến:",
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          color: ColorConstants.BLACK,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                          fontWeight: FontWeight.w200),
                    ),
                    TextBase(
                      text: " 10.000.000 đ",
                      style: TextStyle(
                          fontFamily: Fonts.Lexend.name,
                          color: ColorConstants.PRIMARY_1,
                          fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                TextBase(
                  text: "Đã nhận",
                  style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      color: ColorConstants.PRIMARY_3,
                      fontSize: DimensionsHelper.FONT_SIZE_SPAN * .95,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          )),
    ]);
  }

  AppBarBase _header() {
    return AppBarBase(
        title: "Quà tặng",
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
