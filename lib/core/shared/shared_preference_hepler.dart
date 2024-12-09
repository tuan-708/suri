import 'dart:convert';

import 'package:suri_checking_event_app/core/constants/variables/preference.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';
import 'package:suri_checking_event_app/features/auth/domain/entities/profile_entity.dart';

class SharedPreferenceHelper {
  // shared pref instance
  final SharedPreferences _sharedPreference;

  // constructor
  SharedPreferenceHelper(this._sharedPreference);

  void setLogged({required bool status}) {
    _sharedPreference.setBool(Preferences.isLogin, status);
  }

  bool get getLogged {
    return _sharedPreference.getBool(Preferences.isLogin) ?? false;
  }

  bool get getIsOpenedIntroduction {
    return _sharedPreference.getBool(Preferences.isOpenedIntroduction) ?? false;
  }

  void setIsOpenedIntroduction({required bool status}) {
    _sharedPreference.setBool(Preferences.isOpenedIntroduction, status);
  }

  String get getTimeZoneName {
    return _sharedPreference.getString(Preferences.idTimeZoneName) ?? '';
  }

  void setTimeZoneName({required String idTimeZoneName}) {
    _sharedPreference.setString(Preferences.idTimeZoneName, idTimeZoneName);
  }

  void setLocale(String locale) {
    _sharedPreference.setString(Preferences.locale, locale);
  }

  // locale
  String get getLocale {
    return _sharedPreference.getString(Preferences.locale) ?? '';
  }

  // JwtToken
  String get getJwtToken {
    return _sharedPreference.getString(Preferences.jwtToken) ?? '';
  }

  void setJwtToken(String authToken) {
    _sharedPreference.setString(Preferences.jwtToken, authToken);
  }

  void removeJwtToken() {
    _sharedPreference.remove(Preferences.jwtToken);
  }

  //  Refresh
  String get refreshToken {
    return _sharedPreference.getString(Preferences.refreshToken) ?? '';
  }

  void setRefreshToken(String refreshToken) {
    _sharedPreference.setString(Preferences.refreshToken, refreshToken);
  }

  void removeRefreshToken() {
    _sharedPreference.remove(Preferences.refreshToken);
  }

  void setShowModalSpecialEvent(bool isShowModal) {
    _sharedPreference.setBool(Preferences.isShowModal, isShowModal);
  }

  bool get getShowModalSpecialEvent {
    return _sharedPreference.getBool(Preferences.isShowModal) ?? true;
  }

  // Profile
  Future<Profile?> getProfile() async {
    String? jsonString = _sharedPreference.getString(Preferences.profile);

    if (!StringValid.nullOrEmpty(jsonString)) {
      Map<String, dynamic> profileMap = jsonDecode(jsonString!);
      return Profile.fromJson(profileMap);
    }
    return null;
  }

  void setProfile(String profile) {
    _sharedPreference.setString(Preferences.profile, profile);
  }

  void removeProfile() {
    _sharedPreference.remove(Preferences.profile);
  }
}
