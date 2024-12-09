import 'package:get_time_ago/get_time_ago.dart';
import 'package:intl/intl.dart';

enum Pattern {
  byDay,
  byDateSql,
  byFullTime,
  byFullTime1,
  byHour,
  byHourAndMinute,
  byDayAndHourAndMinute
}

// ignore: avoid_classes_with_only_static_members
class DateValid {
  // Tính toán thời gian quá khứ so với thời gian hiện tại
  // return 1 phút trước,...
  static String timeAgo(String time, String location) {
    try {
      final dateTime = DateTime.parse(time);

      // DateTime dateTimenow = DateTime.now();

      // print('1: ${dateTime}');
      // print('2: ${DateTime.now().microsecond}');
      // print('3: ${DateTime.now().millisecond}');
      // print('3: ${dateTimenow}');

      // print(dateTime);

      final newDate = DateTime(2024, 6, 6, 16, 22, 06, 598, 967);

      // // print(newDate);
      // print(DateTime.now().subtract(const Duration(days: 2)));

      return GetTimeAgo.parse(DateTime.now(), locale: location);
    } catch (e) {
      return '';
    }
  }

  static String timeAgoCustom(String time) {
    final dateTime = DateTime.parse(time);
    Duration diff = DateTime.now().difference(dateTime);
    if (diff.inDays > 365) {
      return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "năm" : "năm"} trước";
    }
    if (diff.inDays > 30) {
      return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "tháng" : "tháng"} trước";
    }
    if (diff.inDays > 7) {
      return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "tuần" : "tuần"} trước";
    }
    if (diff.inDays > 0) return DateFormat.E().add_jm().format(dateTime);
    if (diff.inHours > 0) return "ngày ${DateFormat('jm').format(dateTime)}";
    if (diff.inMinutes > 0) {
      return "${diff.inMinutes} ${diff.inMinutes == 1 ? "phút" : "phút"} trước";
    }
    return "bây giờ";
  }

  // Return true nếu 2 ngày bằng nhau
  // Chỉ so sánh ngày tháng năm
  static bool is2DayAreEqual(String date1, String date2) {
    try {
      DateTime d1 = DateTime.parse(date1);
      DateTime d2 = DateTime.parse(date2);
      //
      if (d1.day == d2.day && d1.month == d2.month && d1.year == d2.year)
        // ignore: curly_braces_in_flow_control_structures
        return true;
      else
        // ignore: curly_braces_in_flow_control_structures
        return false;
    } catch (e) {
      return false;
    }
  }

  // So sánh 2 ngày
  // Return true nếu 2024-04-12T15:17:42 > 2024-04-10T15:17:42
  static bool compareTwoDate(String date1, String date2) {
    try {
      return DateTime.parse(date1).compareTo(DateTime.parse(date2)) > 0
          ? true
          : false;
    } catch (e) {
      return false;
    }
  }

  // Chuyển đổi thời gian theo format
  static String formatDateTime(Pattern pattern, String time) {
    try {
      switch (pattern) {
        case Pattern.byDay:
          return DateFormat('dd/MM/yyyy').format(DateTime.parse(time));
        case Pattern.byDateSql:
          return DateFormat('yyyy-MM-dd').format(DateTime.parse(time));
        case Pattern.byFullTime:
          return DateFormat('dd/MM/yyyy hh:mm:ss').format(DateTime.parse(time));
        case Pattern.byFullTime1:
          return DateFormat('dd/MM/yyyy - hh:mm:ss')
              .format(DateTime.parse(time));
        case Pattern.byHour:
          return DateFormat('HH:mm').format(DateTime.parse(time));
        case Pattern.byHourAndMinute:
          return DateFormat('hh:mm:ss').format(DateTime.parse(time));
        default:
          return '';
      }
    } catch (e) {
      return '';
    }
  }

  static String convertDateTimeSql(String date) {
    final time = date.split("/");
    return "${time[2]}-${time[1]}-${time[0]}";
  }

  static DateTime convertStringToDate(String date) {
    try {
      DateFormat formatter = DateFormat('dd/MM/yyyy');
      DateTime newDate = formatter.parse(date);
      return newDate;
    } catch (e) {
      // Handle parsing error
      print("Invalid date format");
      return DateTime.now();
    }
  }
}
