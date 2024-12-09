import 'package:intl/intl.dart';

///
/// Convert currency
///
mixin PriceHelper {
  static String currencyConverterVND(double value, {String? locale = 'vi-VN'}) {
    return NumberFormat.currency(name: "", decimalDigits: 0, locale: locale)
        .format(value)
        .replaceAll(',', '.');
  }

  static String currencyConverter(double value, {String? locale = 'en-US'}) {
    return NumberFormat.currency(name: "", decimalDigits: 0, locale: locale)
        .format(value);
  }
}
