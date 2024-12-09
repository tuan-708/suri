import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';

enum ButtonBaseType {
  DEFAULT,
  OUTLINE,
}

class ButtonBase extends StatelessWidget {
  const ButtonBase(
      {Key? key,
      required this.onTap,
      this.label,
      this.height,
      this.maxLine,
      this.type = ButtonBaseType.DEFAULT,
      this.isEnabled = true,
      this.padding,
      this.margin,
      this.borderRadius,
      this.icon,
      this.iconRight,
      this.imageUrlIconRight,
      this.color = ColorConstants.WHITE,
      this.colorBGDisabled = ColorConstants.PLACE,
      this.colorDisible = ColorConstants.BLACK,
      this.colorBG = ColorConstants.PRIMARY_1,
      this.colorIcon,
      this.colorText,
      this.imageUrlIcon,
      this.withBorder,
      this.width,
      this.fontSizedLabel,
      this.space,
      this.fontWeight,
      this.colorBorder,
      this.fillColor,
      this.sizeIcon,
      this.isLoading})
      : super(key: key);

  // OnTap
  // Decoration defaul nền xanh
  // Title defaul căn giữ , maxLine defaul 1 dòng , có thể truyền thêm số dòng, nếu quá dòng là overflow
  // clickble (có thể có or không defaul true) Nếu true click vào thì mới thực hiện onTap esle thì không
  final String? label;
  final Color? color;
  final Color? colorDisible;
  final Color? colorBGDisabled;
  final Color? colorBG;
  final Function onTap;
  final double? height;
  final int? maxLine;
  final ButtonBaseType? type;
  final Color? colorIcon;
  final Color? colorText;
  final Color? colorBorder;
  final Color? fillColor;
  final bool? isEnabled;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? borderRadius;
  final IconData? icon, iconRight;
  final String? imageUrlIcon, imageUrlIconRight;
  final double? withBorder;
  final double? width;
  final double? fontSizedLabel;
  final double? space;
  final double? sizeIcon;
  final FontWeight? fontWeight;
  final bool? isLoading;

  Color getColorBG(ButtonBaseType type) {
    if (type == ButtonBaseType.DEFAULT) {
      if (isEnabled!) {
        return colorBG!;
      }
      return colorBGDisabled!;
    } else if (type == ButtonBaseType.OUTLINE) {
      if (isEnabled!) {
        return fillColor ?? ColorConstants.BACK_GROUND;
      }
      return ColorConstants.WHITE;
    }
    return colorBG!;
  }

  Color getColor(ButtonBaseType type) {
    if (type == ButtonBaseType.DEFAULT) {
      if (isEnabled!) {
        return color!;
      }
      return colorDisible!;
    } else if (type == ButtonBaseType.OUTLINE) {
      if (isEnabled!) {
        return colorBG!;
      }
      return ColorConstants.PLACE;
    }
    return color!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled! && isLoading != true
          ? () {
              onTap();
            }
          : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: width ?? DimensionsHelper.iziSize.width,
        padding: padding ??
            EdgeInsets.symmetric(
              // vertical: DimensionsHelper.SPACE_SIZE_4X,
              horizontal: DimensionsHelper.SPACE_SIZE_4X,
            ),
        margin: margin ??
            EdgeInsets.symmetric(
              vertical: DimensionsHelper.SPACE_SIZE_2X,
            ),
        decoration: BoxDecoration(
          color: getColorBG(type!),
          border: type == ButtonBaseType.DEFAULT
              ? null
              : Border.all(
                  color: colorBorder ?? ColorConstants.PRIMARY_1,
                  width: withBorder ?? DimensionsHelper.ONE_UNIT_SIZE * 3,
                ),
          borderRadius: BorderRadius.circular(
            borderRadius ?? DimensionsHelper.ONE_UNIT_SIZE * 20,
          ),
        ),
        height: height ?? 50,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!StringValid.nullOrEmpty(imageUrlIcon))
              SizedBox(
                height: sizeIcon ?? DimensionsHelper.ONE_UNIT_SIZE * 30,
                width: sizeIcon ?? DimensionsHelper.ONE_UNIT_SIZE * 30,
                child: ImageBase(
                  imageUrlIcon.toString(),
                ),
              ),
            if (icon != null)
              Icon(
                icon,
                color: colorIcon ?? getColor(type!),
                size: sizeIcon ?? DimensionsHelper.FONT_SIZE_H5 * 1.25,
              )
            else
              const SizedBox(),
            SizedBox(
              width:
                  space == null ? 0 : DimensionsHelper.ONE_UNIT_SIZE * space!,
            ),
            // Loading
            if (isLoading == true)
              SizedBox(
                width: DimensionsHelper.ONE_UNIT_SIZE * 33,
                height: DimensionsHelper.ONE_UNIT_SIZE * 33,
                child: CircularProgressIndicator(
                  color: color,
                  strokeWidth: 2,
                ),
              ),
            if (label != null)
              if (isLoading == true)
                Flexible(
                  child: Text(
                    "  Đang tải ...",
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: fontSizedLabel ?? DimensionsHelper.FONT_SIZE_H5,
                      color: colorText ?? getColor(type!),
                      fontWeight: fontWeight ?? FontWeight.w400,
                    ),
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              else
                Flexible(
                  child: Text(
                    " $label",
                    style: TextStyle(
                      fontFamily: Fonts.Lexend.name,
                      fontSize: fontSizedLabel ?? DimensionsHelper.FONT_SIZE_H5,
                      color: colorText ?? getColor(type!),
                      fontWeight: fontWeight ?? FontWeight.w400,
                    ),
                    maxLines: maxLine ?? 1,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            SizedBox(
              width: DimensionsHelper.SPACE_SIZE_1X,
            ),
            if (!StringValid.nullOrEmpty(imageUrlIconRight))
              SizedBox(
                height: DimensionsHelper.ONE_UNIT_SIZE * 30,
                width: DimensionsHelper.ONE_UNIT_SIZE * 30,
                child: ImageBase(
                  imageUrlIconRight.toString(),
                ),
              ),
            if (iconRight != null)
              Icon(
                iconRight,
                color: colorIcon ?? getColor(type!),
                size: DimensionsHelper.FONT_SIZE_H6 * 1.25,
              )
            else
              const SizedBox(),
          ],
        ),
      ),
    );
  }
}
