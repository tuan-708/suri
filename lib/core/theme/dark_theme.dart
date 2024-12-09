import 'package:flutter/material.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';

ThemeData darkTheme = ThemeData(
  primaryColor: const Color(0xFF0DAC43),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFc7c7c7),
  sliderTheme: const SliderThemeData(
    showValueIndicator: ShowValueIndicator.always,
  ),
  pageTransitionsTheme: const PageTransitionsTheme(builders: {
    TargetPlatform.android: ZoomPageTransitionsBuilder(),
    TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
  }),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.black.withOpacity(0),
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: ColorConstants.WHITE,
  ),
);
