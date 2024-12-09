import 'package:suri_checking_event_app/core/constants/variables/app_constants.dart';
import 'package:suri_checking_event_app/core/constants/variables/image_path_constant.dart';

class StringValid {
  // Check nullOrEmpty
  static bool nullOrEmpty(dynamic value) {
    if (value == null ||
        value == '' ||
        value.toString().isEmpty ||
        value.toString() == 'null' ||
        value.toString() == '{}' ||
        (value is List && value.isEmpty == true)) return true;
    return false;
  }

  static String? password(String password) {
    final conditions = [
      {'regex': RegExp(r'.{8,}'), 'message': 'Mật khẩu tối thiểu 8 ký tự!'},
      {
        'regex': RegExp(r'[a-z]'),
        'message': 'Mật khẩu phải có ít nhất 1 ký tự thường!'
      },
      {
        'regex': RegExp(r'[A-Z]'),
        'message': 'Mật khẩu phải có ít nhất 1 ký tự in hoa!'
      },
      {'regex': RegExp(r'[0-9]'), 'message': 'Mật khẩu phải có ít nhất 1 số!'},
      {
        'regex': RegExp(r'[!@#$%^&*(),.?":{}|<>]'),
        'message': 'Mật khẩu phải có ít nhất 1 ký tự đặc biệt!'
      },
    ];

    for (var condition in conditions) {
      final regex = condition['regex'] as RegExp;
      final message = condition['message'] as String;
      if (!regex.hasMatch(password)) {
        return message;
      }
    }

    return null;
  }

  static String? email(String text) {
    if (nullOrEmpty(text)) {
      return "Vui lòng nhập địa chỉ email!";
    }
    if (text.trim().toString() == "") {
      return "";
    }
    final RegExp reg = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (reg.hasMatch(text)) {
      return null;
    } else {
      return "Địa chỉ email không hợp lệ!";
    }
  }

  static String? phone(String text) {
    if (nullOrEmpty(text)) {
      return "Số điện thoại không được để trống!";
    }
    const pattern = r'^\d{10,12}$';
    final regex = RegExp(pattern);
    if (regex.hasMatch(text)) {
      return null;
    } else {
      return "Số điện thoại không hợp lệ";
    }
  }

  static String? userName(String text) {
    if (nullOrEmpty(text)) {
      return "Tên đăng nhập không được để trống!";
    }
    if (text.length < 8) {
      return "Tên đăng nhập chứa ít nhất 8 ký tự";
    }
    if (text.length > 30) {
      return "Tên đăng nhập quá dài!";
    }
    return null;
  }

  static String? cardId(String text) {
    if (nullOrEmpty(text)) {
      return "Căn cước công dân không được để trống!";
    }
    const pattern = r'^\d{12}$';
    final regex = RegExp(pattern);
    if (regex.hasMatch(text)) {
      return null;
    } else {
      return "Căn cước công dân không hợp lệ!";
    }
  }

  static String? taxNum(String text) {
    if (nullOrEmpty(text)) {
      return "Mã số thuế không được để trống!";
    }
    final RegExp reg = RegExp(r'^\d{10}$');
    if (reg.hasMatch(text)) {
      return null;
    } else {
      return "Mã số thuế không hợp lệ";
    }
  }

  static String? zipCode(String text) {
    if (nullOrEmpty(text)) {
      return "Mã bưu chính không được để trống!";
    }
    final RegExp reg = RegExp(r'^\d{5,8}$');
    if (reg.hasMatch(text)) {
      return null;
    } else {
      return "Mã bưu chính không hợp lệ";
    }
  }

  static String? bankNum(String text) {
    if (nullOrEmpty(text)) {
      return "Số tài khoản ngân hàng không được để trống!";
    }
    final RegExp reg = RegExp(r'^\d{1,25}$');
    if (reg.hasMatch(text)) {
      return null;
    } else {
      return "Số tài khoản không hợp lệ";
    }
  }

  static String? fullName(String text, {int? rangeFrom, int? rangeTo}) {
    if (nullOrEmpty(text)) {
      return "Tên không được để trống";
    }
    if (!nullOrEmpty(rangeFrom)) {
      if (text.length < rangeFrom!) {
        return "Tên ít nhất phải $rangeFrom ký tự!";
      }
    }
    if (!nullOrEmpty(rangeTo)) {
      if (text.length > rangeTo!) {
        return "Tên không được quá $rangeFrom ký tự!";
      }
    }
    return null;
  }

  static String? increment(String? number) {
    if (nullOrEmpty(number)) {
      number = '';
    }
    if (int.parse(number!) <= 0) {
      return "Số lượng không được bé hơn 0!";
    } else if (int.parse(number) >= 999) {
      return "Số lượng không được lớn hơn 999!";
    }
    return null;
  }

  static String getGenderString(dynamic value) {
    if (nullOrEmpty(value) == true) return 'Không xác định';

    if (value == 1 || value == '1') {
      return "Nam";
    } else if (value == 2 || value == '2') {
      return "Nữ";
    } else if (value == 2 || value == '3') {
      return "Tất cả";
    }
    return 'Không xác định';
  }

  static bool isNumeric(String s) {
    if (s == 'null') {
      return false;
    }

    return double.tryParse(s) != null || int.tryParse(s) != null;
  }

  static String url(String value) {
    if (nullOrEmpty(value) == true) return ImagePathConstants.IMAGE_USER_TEST;
    if (value.contains("https")) {
      return value;
    } else {
      return "$BASE_URL$value";
    }
  }
}
