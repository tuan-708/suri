import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:intl/intl.dart';
import 'package:suri_checking_event_app/core/shared/shared_preference_hepler.dart';
import 'package:suri_checking_event_app/di_controller.dart';
import 'package:timezone/data/latest_all.dart' as latest_all;
import 'package:timezone/timezone.dart' as time_zone;

class TimeZoneHelper {
  //
  // You can pass into the timezone name parameter when call TimeZoneHelper class
  // to set time zone which you want to set the timezone.
  String? timeZoneName;

  TimeZoneHelper({
    this.timeZoneName,
  });

  ///
  /// Initialize time zone.
  ///
  Future<void> initializeTimeZones() async {
    //
    // Initialize time zones.
    latest_all.initializeTimeZones();

    // Set time zone.
    setTimeZone(timeZoneName: timeZoneName);
  }

  ///
  /// Set time zone.
  ///
  static Future<void> setTimeZone({required String? timeZoneName}) async {
    //
    // Declare zone name.
    String zoneName = 'unknown';

    // If timeZoneName is equal to null then get local timezone.
    if (timeZoneName != null) {
      zoneName = timeZoneName;
    } else {
      zoneName = await FlutterNativeTimezone.getLocalTimezone();
    }

    // Set time zone.
    time_zone.setLocalLocation(time_zone.getLocation(zoneName));
    sl<SharedPreferenceHelper>().setTimeZoneName(idTimeZoneName: zoneName);
  }

  ///
  /// Get date time now.
  ///
  static DateTime dateTimeNow() {
    return time_zone.TZDateTime.now(time_zone.local);
  }

  ///
  /// Compare microsecondsSinceEpoch to date time.
  ///
  static DateTime microsecondsSinceEpochToDateTime(
      {required int microsecondsSinceEpoch}) {
    //
    // Get timezone from shared preferences.
    // return time_zone.TZDateTime.fromMicrosecondsSinceEpoch(time_zone.getLocation(sl<SharedPreferenceHelper>().getTimeZoneName), microsecondsSinceEpoch).toLocal();

    final timezoneName = sl<SharedPreferenceHelper>().getTimeZoneName;
    final location = time_zone.getLocation(timezoneName);

    // Handle DST if necessary
    final dateTime = time_zone.TZDateTime.fromMicrosecondsSinceEpoch(
        location, microsecondsSinceEpoch);

    return dateTime.toLocal();
  }

  ///
  /// Compare milisecondsSinceEpoch to date time.
  ///
  static DateTime millisecondsSinceEpochToDateTime(
      {required int millisecondsSinceEpoch}) {
    //
    // Get timezone from shared preferences.
    return time_zone.TZDateTime.fromMillisecondsSinceEpoch(
            time_zone.getLocation(sl<SharedPreferenceHelper>().getTimeZoneName),
            millisecondsSinceEpoch)
        .toLocal();
  }

  ///
  /// Parse date time.
  ///
  static String parseDateTime(DateTime dateTime,
      {String format = 'MM-dd-yyyy'}) {
    final dateTime0 = time_zone.TZDateTime.from(dateTime,
        time_zone.getLocation(sl<SharedPreferenceHelper>().getTimeZoneName));
    return DateFormat(format).format(dateTime0);
  }

  ///
  /// Format date time.
  ///
  static DateTime formatDateTime(String dateTime,
      {String format = 'MM-dd-yyyy'}) {
    final dateTime0 = DateFormat(format).parse(dateTime);
    return time_zone.TZDateTime.from(dateTime0,
        time_zone.getLocation(sl<SharedPreferenceHelper>().getTimeZoneName));
  }
}
