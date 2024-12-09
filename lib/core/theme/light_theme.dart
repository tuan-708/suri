import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: ColorConstants.WHITE,
    primaryColor: const Color(0xFF0DAC43),
    brightness: Brightness.light,
    sliderTheme: const SliderThemeData(
      showValueIndicator: ShowValueIndicator.always,
    ),
    // scaffoldBackgroundColor: ColorResources.BACKGROUND,
    hintColor: const Color(0xFF9E9E9E),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
      TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
    }),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Colors.black.withOpacity(0),
    ),
    colorScheme: ColorScheme.fromSwatch()
        .copyWith(
          secondary: Colors.white,
        )
        .copyWith(
          background: ColorConstants.WHITE,
        ));
