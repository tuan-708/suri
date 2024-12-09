import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:suri_checking_event_app/core/utils/string_valid.dart';

///
/// Format datetime
///
mixin DateHelper {
  static String formatDate(DateTime dateTime, {String format = "dd-MM-yyyy"}) {
    /// yyyy-MM-dd hh:mm:ss
    /// HH:mm dd-MM-yyyy
    /// dd MMM yyyy
    /// dd-MM-yyyy
    /// dd/MM/yyyy
    /// hh:mm
    /// yyyy-MM-dd

    return DateFormat(format, 'vi').format(dateTime);
  }

  static String formatDate2(DateTime dateTime, {String format = "HH:mm"}) {
    /// yyyy-MM-dd hh:mm:ss
    /// HH:mm dd-MM-yyyy
    /// dd MMM yyyy
    /// dd-MM-yyyy
    /// dd/MM/yyyy
    /// hh:mm
    /// yyyy-MM-dd

    return DateFormat(format, 'vi').format(dateTime);
  }

  static DateTime formatDateTime(
    String dateTime, {
    String format = "dd-MM-yyyy",
  }) {
    if (!StringValid.nullOrEmpty(dateTime)) {
      return DateFormat(format).parse(dateTime);
    }
    return DateTime(2000);
  }

  static String formatTime(DateTime dateTime, {String format = "hh:mm"}) {
    /// yyyy-MM-dd hh:mm:ss
    /// HH:mm dd-MM-yyyy
    /// dd MMM yyyy
    /// dd-MM-yyyy
    /// dd/MM/yyyy
    /// hh:mm
    /// yyyy-MM-dd

    return DateFormat(format, 'vi').format(dateTime);
  }

  static DateTime parse(String dateTime) {
    if (!StringValid.nullOrEmpty(dateTime)) {
      return DateTime.parse(dateTime).toLocal();
    }
    return DateTime(2000);
  }

  static String formatTime24Hour(BuildContext context, DateTime dateTime) {
    return TimeOfDay.fromDateTime(dateTime).format(context);
  }

  static int differenceDate(
      {required DateTime startDate, required DateTime endDate}) {
    return endDate.difference(startDate).inDays;
  }

  static int toTimeStamp(DateTime dateTime) {
    return int.parse(dateTime.millisecondsSinceEpoch.toStringAsFixed(0));
  }

  static String fromTimeStamp(int timeStamp) {
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return DateFormat('dd/MM/yyyy', 'vi').format(time);
  }

  static String fromTimeStampToHour(int timeStamp) {
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return DateFormat('HH:mm', 'vi').format(time);
  }

  static String fromTimeStampToHourAMPM(int timeStamp) {
    final time = DateTime.fromMillisecondsSinceEpoch(timeStamp);
    return DateFormat('HH:mm a', 'en').format(time);
  }

  static DateTime stringToDateTimeFormat(String date, String pattern) {
    try {
      final dateFormat = DateFormat(pattern); // Adjust format if needed
      return dateFormat.parse(date);
    } catch (e) {
      return DateTime.now();
    }
  }
}
