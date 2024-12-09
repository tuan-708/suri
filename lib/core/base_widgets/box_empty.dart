import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

import 'image_base.dart';

class BoxEmpty extends StatelessWidget {
  const BoxEmpty(
      {super.key,
      this.title,
      this.width,
      this.height,
      this.icWidth,
      this.icHeight});
  final String? title;
  final double? width;
  final double? height;
  final double? icWidth;
  final double? icHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? DimensionsHelper.iziSize.width,
      height: height ?? DimensionsHelper.ONE_UNIT_SIZE * 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ImageBase(
            ImagePathConstants.IMAGE_EMPTY,
            width: icWidth ?? DimensionsHelper.ONE_UNIT_SIZE * 150,
            height: icHeight ?? DimensionsHelper.ONE_UNIT_SIZE * 150,
          ),
          SizedBox(
            height: DimensionsHelper.SPACE_SIZE_2X,
          ),
          TextBase(
            text: title ?? 'Không có dữ liệu',
            style: TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontWeight: FontWeight.w200,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN * 0.9,
              color: ColorConstants.BLACK,
            ),
          )
        ],
      ),
    );
  }
}
