import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class ButtonLinearGradient extends StatefulWidget {
  const ButtonLinearGradient(
      {super.key,
      this.height,
      this.width,
      required this.title,
      this.color,
      this.onTap,
      this.fontWeight,
      this.fonSize,
      this.borderRadius,
      this.isDisable});
  final double? width;
  final double? height;
  final String title;
  final double? borderRadius;
  final Color? color;
  final double? fonSize;
  final FontWeight? fontWeight;
  final bool? isDisable;
  final Function()? onTap;

  @override
  State<ButtonLinearGradient> createState() => _ButtonLinearGradientState();
}

class _ButtonLinearGradientState extends State<ButtonLinearGradient> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isDisable == true ? () {} : widget.onTap,
      child: AbsorbPointer(
        child: Container(
          width: widget.width ?? DimensionsHelper.iziSize.width,
          height: widget.height ?? DimensionsHelper.ONE_UNIT_SIZE * 55,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  widget.borderRadius ?? DimensionsHelper.BORDER_RADIUS_2X),
              gradient: widget.isDisable == true
                  ? const LinearGradient(
                      colors: [ColorConstants.PLACE1, ColorConstants.PLACE1])
                  : const LinearGradient(colors: [
                      ColorConstants.LINEAR_GRADIENT1,
                      ColorConstants.LINEAR_GRADIENT2
                    ])),
          child: Center(
            child: TextBase(
              text: widget.title,
              maxLine: 2,
              style: TextStyle(
                fontFamily: Fonts.Lexend.name,
                fontSize:
                    widget.fonSize ?? DimensionsHelper.FONT_SIZE_SPAN * 0.9,
                fontWeight: widget.fontWeight ?? FontWeight.w200,
                color: widget.color ?? ColorConstants.WHITE,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
