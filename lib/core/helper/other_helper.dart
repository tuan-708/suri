// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:suri_checking_event_app/core/constants/variables/color_constant.dart';
import 'package:suri_checking_event_app/core/helper/dimensions_helper.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

class OtherHelper {
  static const MethodChannel _channel = MethodChannel('app_settings');

  ///
  /// open link url
  ///
  static Future openLink({required String url}) async {
    try {
      if (!StringValid.nullOrEmpty(url)) {
        if (await canLaunch(url)) {
          await launch(url);
        }
      }
    } catch (e) {}
  }

  ///
  /// Open link Android or IOS.
  ///
  static Future<void> openApp({required String linkApp}) async {
    final Uri url = Uri.parse(linkApp);
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  static String htmlUnescape(String htmlString) {
    final unescape = HtmlUnescape();
    return unescape.convert(htmlString);
  }

  static Future callPhone({required String phone}) async {
    // Check for phone call support
    if (await canLaunch(Platform.isIOS ? "tel://$phone" : "tel:$phone")) {
      await launch(Platform.isIOS ? "tel://$phone" : "tel:$phone");
    }
  }

  static void primaryFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static Future<void> openAppSettings({
    bool asAnotherTask = false,
  }) async {
    _channel.invokeMethod('app_settings', {
      'asAnotherTask': asAnotherTask,
    });
  }

  /// Future async method call to open internal storage settings.
  static Future<void> openInternalStorageSettings({
    bool asAnotherTask = false,
  }) async {
    _channel.invokeMethod('internal_storage', {
      'asAnotherTask': asAnotherTask,
    });
  }

  static Future<Uint8List> resizeImage(String imageUrl) async {
    // ignore: unused_local_variable
    Uint8List targetlUinit8List;
    Uint8List originalUnit8List;
    final http.Response response = await http.get(Uri.parse(imageUrl));
    originalUnit8List = response.bodyBytes;

    // final ui.Image originalUiImage = await decodeImageFromList(originalUnit8List);
    // final ByteData? originalByteData = await originalUiImage.toByteData();
    // print('original image ByteData size is ${originalByteData!.lengthInBytes}');

    final codec = await ui.instantiateImageCodec(originalUnit8List,
        targetHeight: 1280, targetWidth: 1280);
    final frameInfo = await codec.getNextFrame();
    final ui.Image targetUiImage = frameInfo.image;

    final ByteData? targetByteData =
        await targetUiImage.toByteData(format: ui.ImageByteFormat.png);
    print('target image ByteData size is ${targetByteData!.lengthInBytes}');
    return targetlUinit8List = targetByteData.buffer.asUint8List();
  }

  /// blocks rotation; sets orientation to: portrait
  static void portraitModeOnly() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  List<BoxShadow> boxShadow = [
    BoxShadow(
        offset: const Offset(0, 2.43),
        blurRadius: DimensionsHelper.BLUR_RADIUS_3X,
        color: ColorConstants.PRIMARY_1.withAlpha(5),
        spreadRadius: 0),
    BoxShadow(
        offset: const Offset(0, 2.43),
        blurRadius: DimensionsHelper.BLUR_RADIUS_3X,
        color: ColorConstants.PRIMARY_1.withAlpha(5),
        spreadRadius: 0),
    BoxShadow(
        offset: const Offset(0, 2.43),
        blurRadius: DimensionsHelper.BLUR_RADIUS_3X,
        color: ColorConstants.PRIMARY_1.withAlpha(5),
        spreadRadius: 0),
    BoxShadow(
        offset: const Offset(0, 2.43),
        blurRadius: DimensionsHelper.BLUR_RADIUS_3X,
        color: ColorConstants.PRIMARY_1.withAlpha(5),
        spreadRadius: 0),
  ];
}
