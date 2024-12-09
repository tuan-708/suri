import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:suri_checking_event_app/core/multipe_language_service/language/st_en_us.dart';
import 'package:suri_checking_event_app/core/multipe_language_service/language/st_vi_vn.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/di_controller.dart';

class LocalizationService extends Translations {
// Get locale.
  static final locale = _getLocaleFromLanguage();

// Locale default.
  static const fallbackLocale = Locale('vi', 'VN');

// language code của những locale được support
  static final langCodes = [
    'vi',
    'en',
  ];

  // Locale have support.
  static final locales = [
    const Locale('vi', 'VN'),
    const Locale('en', 'US'),
  ];

// Language data to change.
  static final langs = LinkedHashMap.from({
    'en': 'en'.tr,
    'vi': 'vi'.tr,
  });

  ///
  /// On change language.
  ///
  static void changeLocale(String langCode) {
    //
    // Save locale.
    sl<SharedPreferenceHelper>().setLocale(langCode);
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys {
    return {'vi_VN': vi, 'en_US': en};
  }

  static Locale _getLocaleFromLanguage({String? langCode}) {
    late String lang;
    if (StringValid.nullOrEmpty(langCode) &&
        !StringValid.nullOrEmpty(sl<SharedPreferenceHelper>().getLocale)) {
      lang = sl<SharedPreferenceHelper>().getLocale.toString();
    } else if (!StringValid.nullOrEmpty(langCode)) {
      lang = langCode.toString();
    } else {
      lang = Get.deviceLocale!.languageCode;

      // Save locale.
      sl<SharedPreferenceHelper>().setLocale(lang);
    }
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }
    return Get.locale!;
  }
}
