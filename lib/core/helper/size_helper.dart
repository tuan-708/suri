import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeHelper {
  // constructor
  SizeHelper() {
    init();
  }

  static Size _size = const Size(0, 0);

  // call this method from init()
  static Future<void> init() async {
    update(width: Get.width, height: Get.height);
  }

  static Size get size {
    return Get.size;
  }

  static void update({required double width, required double height}) {
    _size = Size(width, height);
  }

  static bool isScreen4_3({double? width, double? height}) {
    double width0 = width ?? _size.width;
    double height0 = height ?? _size.height;

    if (width0 <= 0 || height0 <= 0) {
      // Sử dụng giá trị mặc định nếu kích thước không hợp lệ
      width0 = 360;
      height0 = 640;
    }

    // Default screen portrait
    if (width0 > height0) {
      // Screen landscape
      final double temp = height0;
      height0 = width0;
      width0 = temp;
    }
    final ratio = height0 / width0;
    if (((4 / 3) - ratio).abs() < 0.1) {
      return true;
    }
    return false;
  }

  /*
  * DO NOT OVERIDE PARAM size
  * */
  double getFontSize({double? width, double? height, double size = 1000}) {
    double width0 = width ?? _size.width;
    double height0 = height ?? _size.height;

    if (width0 <= 0 || height0 <= 0) {
      // Sử dụng giá trị mặc định nếu kích thước không hợp lệ
      width0 = 360;
      height0 = 640;
    }

    // Default screen portrait
    if (width0 > height0) {
      // Screen landscape
      final double temp = height0;
      height0 = width0;
      width0 = temp;
    }

    final ratio = height0 / width0;

    if (ratio >= 1.9) {
      return (width0 * 1.675) / size;
    } else if (ratio >= 1.7) {
      return height0 / size;
    } else if (ratio > 1.575) {
      return (width0 * 1.575) / size;
    } else {
      return width0 / size;
    }
  }

  // table
  static DeviceHelper get device {
    try {
      final data = MediaQueryData.fromWindow(WidgetsBinding.instance.window);
      return data.size.shortestSide < 550
          ? DeviceHelper.IPHONE
          : DeviceHelper.TABLE;
    } catch (e) {
      return DeviceHelper.IPHONE;
    }
  }
}

enum DeviceHelper {
  TABLE,
  IPHONE,
}
