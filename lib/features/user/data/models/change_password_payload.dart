class ChangePasswordPayload {
  final String? Password;
  final String? NewPassword;
  const ChangePasswordPayload({this.Password, this.NewPassword});

  ChangePasswordPayload copyWith({String? Password, String? NewPassword}) {
    return ChangePasswordPayload(
        Password: Password ?? this.Password,
        NewPassword: NewPassword ?? this.NewPassword);
  }

  Map<String, Object?> toJson() {
    return {'Password': Password, 'NewPassword': NewPassword};
  }

  static ChangePasswordPayload fromJson(Map<String, Object?> json) {
    return ChangePasswordPayload(
        Password: json['password'] == null ? null : json['password'] as String,
        NewPassword:
            json['newPassword'] == null ? null : json['newPassword'] as String);
  }
}
