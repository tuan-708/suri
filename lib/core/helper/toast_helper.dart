import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/constants/enums/constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';

class ToastHelper {
  ToastHelper();

  static toastSuccess({String? title, BuildContext? context}) {
    CherryToast.success(
            description: Text(title ?? "",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: Fonts.Lexend.name,
                  fontWeight: FontWeight.w200,
                  color: Colors.black,
                )),
            animationType: AnimationType.fromTop,
            animationDuration: const Duration(milliseconds: 250),
            borderRadius: DimensionsHelper.BORDER_RADIUS_2X,
            shadowColor: ColorConstants.NEUTRALS_1.withOpacity(0.07))
        .show(context!);
  }

  static toastInfo({String? title, BuildContext? context}) {
    CherryToast.info(
            description: Text(title ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontFamily: Fonts.Lexend.name,
                    color: Colors.black)),
            animationType: AnimationType.fromTop,
            animationDuration: const Duration(milliseconds: 250),
            borderRadius: DimensionsHelper.BORDER_RADIUS_2X,
            shadowColor: ColorConstants.NEUTRALS_1.withOpacity(0.07))
        .show(context!);
  }

  static toastWarning({String? title, BuildContext? context}) {
    CherryToast.warning(
            description: Text(title ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontFamily: Fonts.Lexend.name,
                    color: Colors.black)),
            animationType: AnimationType.fromTop,
            animationDuration: const Duration(milliseconds: 250),
            borderRadius: DimensionsHelper.BORDER_RADIUS_2X,
            shadowColor: ColorConstants.NEUTRALS_1.withOpacity(0.07))
        .show(context!);
  }

  static toastError({String? title, BuildContext? context}) {
    CherryToast.error(
            description: Text(title ?? "",
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontFamily: Fonts.Lexend.name,
                    color: Colors.black)),
            animationType: AnimationType.fromTop,
            animationDuration: const Duration(milliseconds: 250),
            borderRadius: DimensionsHelper.BORDER_RADIUS_2X,
            shadowColor: ColorConstants.NEUTRALS_1.withOpacity(0.07))
        .show(context!);
  }
}
