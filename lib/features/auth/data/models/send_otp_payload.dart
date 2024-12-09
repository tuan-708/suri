class SendOTPPayload {
  final String? Email;
  final String? newPassword;
  final String? hash;
  const SendOTPPayload({this.Email, this.newPassword, this.hash});
  SendOTPPayload copyWith({String? Email, String? newPassword, String? hash}) {
    return SendOTPPayload(
        Email: Email ?? this.Email,
        newPassword: newPassword ?? this.newPassword,
        hash: hash ?? this.hash);
  }

  Map<String, Object?> toJson() {
    return {'Email': Email, 'newPassword': newPassword, 'hash': hash};
  }

  static SendOTPPayload fromJson(Map<String, Object?> json) {
    return SendOTPPayload(
        Email: json['Email'] == null ? null : json['Email'] as String,
        newPassword:
            json['newPassword'] == null ? null : json['newPassword'] as String,
        hash: json['hash'] == null ? null : json['hash'] as String);
  }
}
