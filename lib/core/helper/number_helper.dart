class NumberHelper {
  static double parseDouble(dynamic number, {double fault = 0.0}) {
    if (number != null) {
      if (number is double) {
        return number;
      } else if (number is int) {
        return number * 1.0;
      } else if (number is String) {
        if (number.contains('.')) {
          return double.parse(number);
        } else {
          return int.parse(number) * 1.0;
        }
      }
    }
    return fault;
  }

  static int parseInt(dynamic number, {int fault = 0}) {
    try {
      if (number != null) {
        if (number is double) {
          return number.round();
        } else if (number is int) {
          return number;
        } else if (number is String) {
          if (number.contains('.')) {
            return double.parse(number).round();
          } else {
            return int.parse(number);
          }
        }
      }
      return fault;
    } catch (e) {
      return 0;
    }
  }
}
