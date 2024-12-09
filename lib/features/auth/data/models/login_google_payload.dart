class LoginGooglePayload {
  final String? FullName;
  final String? Email;
  final String? Photo;
  final String? Id;
  const LoginGooglePayload({this.FullName, this.Email, this.Photo, this.Id});
  LoginGooglePayload copyWith(
      {String? FullName, String? Email, String? Photo, String? Id}) {
    return LoginGooglePayload(
        FullName: FullName ?? this.FullName,
        Email: Email ?? this.Email,
        Photo: Photo ?? this.Photo,
        Id: Id ?? this.Id);
  }

  Map<String, Object?> toJson() {
    return {'FullName': FullName, 'Email': Email, 'Photo': Photo, 'Id': Id};
  }

  static LoginGooglePayload fromJson(Map<String, Object?> json) {
    return LoginGooglePayload(
        FullName: json['FullName'] == null ? null : json['FullName'] as String,
        Email: json['Email'] == null ? null : json['Email'] as String,
        Photo: json['Photo'] == null ? null : json['Photo'] as String,
        Id: json['Id'] == null ? null : json['Id'] as String);
  }
}
