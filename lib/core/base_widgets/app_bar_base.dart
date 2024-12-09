import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/text_base.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class AppBarBase extends StatefulWidget implements PreferredSizeWidget {
  const AppBarBase(
      {Key? key,
      required this.title,
      this.back = true,
      this.onBack,
      this.actions,
      this.backgroundColor,
      this.titleStyle,
      this.centerTitle,
      this.elevation
      // ignore: avoid_field_initializers_in_const_classes
      })
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  State<AppBarBase> createState() => _AppBarBaseState();

  final String title;
  final bool back;
  final Function? onBack;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final bool? centerTitle;
  final double? elevation;
}

class _AppBarBaseState extends State<AppBarBase> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: widget.elevation ?? 12,
      shadowColor: Colors.black.withOpacity(0.2),
      backgroundColor: widget.backgroundColor ?? ColorConstants.PRIMARY_1,
      actions: widget.actions,
      leading: widget.back
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (widget.onBack != null) {
                      widget.onBack!();
                    } else {
                      Navigator.pop(context);
                    }
                  },
                  child: Container(
                    margin:
                        EdgeInsets.only(left: DimensionsHelper.SPACE_SIZE_1X),
                    width: DimensionsHelper.ONE_UNIT_SIZE * 50,
                    height: DimensionsHelper.ONE_UNIT_SIZE * 50,
                    decoration: BoxDecoration(
                        color: ColorConstants.WHITE,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: ColorConstants.BLACK)),
                    child: Stack(
                      children: [
                        Positioned(
                          left: DimensionsHelper.ONE_UNIT_SIZE * 14,
                          top: DimensionsHelper.ONE_UNIT_SIZE * 10,
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: ColorConstants.BLACK,
                            size: DimensionsHelper.ONE_UNIT_SIZE * 27,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : const SizedBox(),
      title: TextBase(
        text: widget.title,
        style: widget.titleStyle ??
            TextStyle(
              fontFamily: Fonts.Lexend.name,
              fontWeight: FontWeight.w400,
              fontSize: DimensionsHelper.FONT_SIZE_H6,
              color: ColorConstants.WHITE,
            ),
      ),
      centerTitle: widget.centerTitle ?? false,
    );
  }
}
