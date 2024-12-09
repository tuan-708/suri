import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class TextBase extends StatelessWidget {
  const TextBase({
    Key? key,
    this.textAlign,
    required this.text,
    this.style,
    this.maxLine,
    this.overflow,
  }) : super(key: key);

  final TextAlign? textAlign;
  final String text;
  final TextStyle? style;
  final int? maxLine;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLine ?? 1,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: style ??
          TextStyle(
              fontFamily: Fonts.Lexend.name,
              decoration: TextDecoration.none,
              fontSize: DimensionsHelper.FONT_SIZE_SPAN,
              color: ColorConstants.TEXT_1,
              fontWeight: FontWeight.w200),
    );
  }
}
