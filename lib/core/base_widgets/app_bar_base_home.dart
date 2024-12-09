import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/base_widgets/image_base.dart';
import 'package:suri_checking_event_app/core/base_widgets/input_base.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';

class AppBarBaseHome extends StatelessWidget {
  const AppBarBaseHome(
      {Key? key,
      this.iconBack,
      this.onBack,
      this.actions = const [],
      this.callbackSearch,
      this.colorTitle,
      this.colorBG,
      this.widthIconBack,
      this.widthActions,
      this.height,
      required this.isBack})
      : super(key: key);

  final Color? colorTitle;
  final Color? colorBG;
  final Widget? iconBack;
  final Function? onBack;
  final bool isBack;
  final List<Widget>? actions;
  final Function(String)? callbackSearch;
  final double? widthIconBack, widthActions, height;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      padding: EdgeInsets.only(top: statusBarHeight),
      decoration:
          BoxDecoration(color: colorBG ?? Colors.white, boxShadow: const [
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.07),
            spreadRadius: 0,
            blurRadius: 20,
            offset: Offset(0, 4))
      ]),
      height: height ??
          kToolbarHeight, // Đặt chiều cao tùy chỉnh, mặc định là kToolbarHeight

      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (isBack)
                Container(
                    height: height ?? kToolbarHeight, // Chiều cao đồng bộ
                    padding: EdgeInsets.only(
                      left: DimensionsHelper.SPACE_SIZE_2X,
                    ),
                    alignment: Alignment.centerLeft,
                    width:
                        widthIconBack ?? DimensionsHelper.iziSize.width * 0.125,
                    child: iconBack ??
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                if (onBack != null) {
                                  onBack!();
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: DimensionsHelper.SPACE_SIZE_1X),
                                width: DimensionsHelper.ONE_UNIT_SIZE * 50,
                                height: DimensionsHelper.ONE_UNIT_SIZE * 50,
                                decoration: const BoxDecoration(
                                  color: ColorConstants.PLACE1,
                                  shape: BoxShape.circle,
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: DimensionsHelper.ONE_UNIT_SIZE * 15,
                                      top: DimensionsHelper.ONE_UNIT_SIZE * 10,
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        color: ColorConstants.BLACK,
                                        size:
                                            DimensionsHelper.ONE_UNIT_SIZE * 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ))
              else
                Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: DimensionsHelper.SPACE_SIZE_2X,
                    ),
                    child: ImageBase(
                      ImagePathConstants.LOGO_APP,
                      width: DimensionsHelper.ONE_UNIT_SIZE * 210,
                      height: DimensionsHelper.ONE_UNIT_SIZE * 75,
                    )),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: DimensionsHelper.SPACE_SIZE_3X,
                  ),
                  child: InputBase(
                    type: InputBaseType.TEXT,
                    onChanged: (value) {
                      if (!StringValid.nullOrEmpty(callbackSearch)) {
                        callbackSearch!(value);
                      }
                    },
                    onTap: () {
                      if (!isBack) {}
                    },
                    allowEdit: isBack,
                    width: DimensionsHelper.iziSize.width,
                    borderRadius: DimensionsHelper.ONE_UNIT_SIZE * 50,
                    height: DimensionsHelper.ONE_UNIT_SIZE * 60,
                    contentPaddingIncrement:
                        const EdgeInsets.only(top: 20, left: 15, right: 15),
                    placeHolder: isBack ? 'Tìm kiếm' : '',
                    fillColor: ColorConstants.PLACE1,
                    suffixIcon: Container(
                      height: DimensionsHelper.ONE_UNIT_SIZE * 45,
                      width: DimensionsHelper.ONE_UNIT_SIZE * 45,
                      margin: EdgeInsets.only(
                        left: DimensionsHelper.ONE_UNIT_SIZE * 20,
                        top: DimensionsHelper.ONE_UNIT_SIZE * 7,
                        right: DimensionsHelper.ONE_UNIT_SIZE * 10,
                        bottom: DimensionsHelper.ONE_UNIT_SIZE * 7,
                      ),
                      decoration: BoxDecoration(
                          color: ColorConstants.WHITE,
                          border:
                              Border.all(color: ColorConstants.ICON, width: 1),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        Icons.search,
                        color: ColorConstants.ICON,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                color: ColorConstants.BACK_GROUND,
                height: height ?? kToolbarHeight, // Chiều cao đồng bộ
                padding: EdgeInsets.only(
                    right: DimensionsHelper.SPACE_SIZE_2X,
                    top: DimensionsHelper.ONE_UNIT_SIZE * 5),
                alignment: Alignment.centerRight,
                width: widthActions ??
                    (DimensionsHelper.iziSize.width * 0.2) * actions!.length,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions!,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
