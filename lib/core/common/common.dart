import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';

void setOrientation() {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
}

String randomName(int length) {
  const chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random rnd = Random();

  return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
}

String decodeBase64(String text) {
  String base64String = text;

  List<int> bytes = base64.decode(base64String);

  String decodedString = utf8.decode(bytes);

  return decodedString;
}
