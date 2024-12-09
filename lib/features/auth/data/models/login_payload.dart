class LoginPayload {
  final String? USERNAME;
  final String? PASSWORD;
  const LoginPayload({this.USERNAME, this.PASSWORD});
  LoginPayload copyWith({String? USERNAME, String? PASSWORD}) {
    return LoginPayload(
        USERNAME: USERNAME ?? this.USERNAME,
        PASSWORD: PASSWORD ?? this.PASSWORD);
  }

  Map<String, Object?> toJson() {
    return {'USERNAME': USERNAME, 'PASSWORD': PASSWORD};
  }

  static LoginPayload fromJson(Map<String, Object?> json) {
    return LoginPayload(
        USERNAME: json['USERNAME'] == null ? null : json['USERNAME'] as String,
        PASSWORD: json['PASSWORD'] == null ? null : json['PASSWORD'] as String);
  }
}
