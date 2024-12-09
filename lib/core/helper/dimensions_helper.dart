// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suri_checking_event_app/core/helper/size_helper.dart';
import 'package:suri_checking_event_app/di_controller.dart';

mixin DimensionsHelper {
  // Max size safe area default without top and bottom
  static Size iziSize = SizeHelper.size;

  // Divide screen to 1000 unit, get one unit to make base
  static double ONE_UNIT_SIZE = sl<SizeHelper>().getFontSize();

  static double HORIZONTAL_SCREEN = 20.0 * ONE_UNIT_SIZE;

  // 13 14 16 18 22
  // Font size text and icon
  // static double FONT_SIZE_SPAN_SMALL_EXTRA = 10.0 * ONE_UNIT_SIZE * ONE_UNIT_SIZE;
  static double FONT_SIZE_SPAN_SMALL_EXTRA =
      15.0 * ONE_UNIT_SIZE; // 10 // Cho các trường hợp chữ nhỏ.
  static double FONT_SIZE_SPAN_SMALL =
      22.0 * ONE_UNIT_SIZE; // 13 // Nội dung chi tiết.
  static double FONT_SIZE_SPAN = 24.0 * ONE_UNIT_SIZE; // 14 // Bình thường.
  static double FONT_SIZE_H6 =
      26.0 * ONE_UNIT_SIZE; // 16 // Tiêu đề danh sách dịch vụ.
  static double FONT_SIZE_DEFAULT = 22.5 * ONE_UNIT_SIZE;
  static double FONT_SIZE_H5 =
      28.0 * ONE_UNIT_SIZE; // 18 // Button lớn, splash, đăng ký, đăng nhập.
  static double FONT_SIZE_H4 = 32.0 * ONE_UNIT_SIZE; // 22 // Chữ lớn.
  static double FONT_SIZE_H3 = 34.0 * ONE_UNIT_SIZE;
  static double FONT_SIZE_H2 = 36.0 * ONE_UNIT_SIZE;
  static double FONT_SIZE_H1 = 38.0 * ONE_UNIT_SIZE;

  // Padding , Margin
  static double SPACE_SIZE_1X = 10.0 * ONE_UNIT_SIZE;
  static double SPACE_SIZE_2X = 15.0 * ONE_UNIT_SIZE;
  static double SPACE_SIZE_3X = 20.0 * ONE_UNIT_SIZE;
  static double SPACE_SIZE_4X = 25.0 * ONE_UNIT_SIZE;
  static double SPACE_SIZE_5X = 30.0 * ONE_UNIT_SIZE;

  // BORDER RADIUS
  static double BORDER_RADIUS_1X = 5.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_2X = 7.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_3X = 10.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_4X = 15.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_5X = 25.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_6X = 30.0 * ONE_UNIT_SIZE;
  static double BORDER_RADIUS_7X = 50.0 * ONE_UNIT_SIZE;

  //BLUR RADIUS
  static double BLUR_RADIUS_1X = 5 * ONE_UNIT_SIZE;
  static double BLUR_RADIUS_2X = 10 * ONE_UNIT_SIZE;
  static double BLUR_RADIUS_3X = 15 * ONE_UNIT_SIZE;
  static double BLUR_RADIUS_4X = 20 * ONE_UNIT_SIZE;
  static double BLUR_RADIUS_5X = 25 * ONE_UNIT_SIZE; //spread Radius

  static double SPREAD_RADIUS_1X = 0.05 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_2X = 0.1 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_3X = 0.2 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_4X = 0.4 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_5X = 0.6 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_6X = 1 * ONE_UNIT_SIZE;
  static double SPREAD_RADIUS_7X = 2 * ONE_UNIT_SIZE;

  static final double SERVICE_TAB_BAR_HEIGHT = ONE_UNIT_SIZE * 60;
  static final double FULL_SERVICE_TAB_HEIGHT =
      kToolbarHeight + Get.mediaQuery.padding.top + SERVICE_TAB_BAR_HEIGHT;
  static final double REVIEWER_AVATAR = ONE_UNIT_SIZE * 70;
  static final double HOME_AVATAR = ONE_UNIT_SIZE * 70;

  /// Search page
  static final double STORE_AVATAR_SIZE = ONE_UNIT_SIZE * 140;
  static final double SEARCHED_SERVICE_AVATAR_SIE = ONE_UNIT_SIZE * 90;
}
