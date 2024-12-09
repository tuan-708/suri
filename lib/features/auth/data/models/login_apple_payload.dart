class LoginApplePayload {
  final String? FullName;
  final String? Email;
  final String? Id;
  const LoginApplePayload({this.FullName, this.Email, this.Id});
  LoginApplePayload copyWith(
      {String? FullName, String? Email, String? Photo, String? Id}) {
    return LoginApplePayload(
        FullName: FullName ?? this.FullName,
        Email: Email ?? this.Email,
        Id: Id ?? this.Id);
  }

  Map<String, Object?> toJson() {
    return {'FullName': FullName, 'Email': Email, 'Id': Id};
  }

  static LoginApplePayload fromJson(Map<String, Object?> json) {
    return LoginApplePayload(
        FullName: json['FullName'] == null ? null : json['FullName'] as String,
        Email: json['Email'] == null ? null : json['Email'] as String,
        Id: json['Id'] == null ? null : json['Id'] as String);
  }
}
