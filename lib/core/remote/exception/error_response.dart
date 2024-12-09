// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:suri_checking_event_app/core/utils/string_valid.dart';

/// errors : [{"code":"l_name","message":"The last name field is required."},{"code":"password","message":"The password field is required."}]

class ErrorResponse {
  late List<Errors> _errors;

  List<Errors> get errors => _errors;

  ErrorResponse({required List<Errors> errors}) {
    _errors = errors;
  }

  ErrorResponse.fromJson(dynamic json) {
    if (!StringValid.nullOrEmpty(json['errors'])) {
      _errors = [];
      json['errors'].forEach((v) {
        _errors.add(Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['errors'] = _errors.map((v) => v.toJson()).toList();
    return map;
  }

  @override
  String toString() => 'ErrorResponse(_errors: $_errors)';
}

/// code : "l_name"
/// message : "The last name field is required."

class Errors {
  late String _status;
  late String _resources;
  late String _title;
  late String _errors;

  String get status => _status;
  String get resources => _resources;
  String get title => _title;
  String get errors => _errors;

  Errors(
      {required String status,
      required String resources,
      required String title,
      required String errors}) {
    status = status;
    _resources = resources;
    _title = title;
    _errors = errors;
  }

  Errors.fromJson(dynamic json) {
    _status = json['status'].toString();
    _resources = json['resources'].toString();
    _title = json['title'].toString();
    _errors = json['errors'].toString();
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['resources'] = _resources;
    map['title'] = _title;
    map['errors'] = _errors;
    return map;
  }
}
