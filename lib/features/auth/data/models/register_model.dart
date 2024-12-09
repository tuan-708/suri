import 'package:equatable/equatable.dart';
import 'package:suri_checking_event_app/features/auth/domain/entities/register_entity.dart';

class RegisterModel extends RegisterEntity with EquatableMixin {
  const RegisterModel(
      {required int id,
      String? firstName,
      String? lastName,
      String? middleName,
      String? email,
      String? username,
      String? password,
      String? phone,
      String? name,
      String? address})
      : super(
            id: id,
            firstName: firstName,
            lastName: lastName,
            middleName: middleName,
            email: email,
            username: username,
            password: password,
            phone: phone,
            name: name,
            address: address);

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
        id: json['id'] as int,
        firstName: json['firstName'] as String?,
        lastName: json['lastName'] as String?,
        middleName: json['middleName'] as String?,
        email: json['email'] as String?,
        username: json['username'] as String?,
        password: json['password'] as String?,
        phone: json['phone'] as String?,
        name: json['name'] as String?,
        address: json['address'] as String?);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'middleName': middleName,
        'email': email,
        'username': username,
        'password': password,
        'phone': phone,
        'name': name,
        'address': address
      };

  @override
  List<Object?> get props => [id, email, username, password];
}
