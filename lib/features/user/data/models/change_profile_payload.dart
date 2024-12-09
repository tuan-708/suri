class ChangeProfilePayload {
  final String? email;
  final String? phone;
  final String? addressDetail;
  final String? name;
  const ChangeProfilePayload(
      {this.email, this.phone, this.addressDetail, this.name});

  ChangeProfilePayload copyWith(
      {String? email, String? phone, String? addressDetail, String? name}) {
    return ChangeProfilePayload(
        email: email ?? this.email,
        phone: phone ?? this.phone,
        addressDetail: addressDetail ?? this.addressDetail,
        name: name ?? this.name);
  }

  Map<String, Object?> toJson() {
    return {
      'email': email,
      'phone': phone,
      'addressDetail': addressDetail,
      'name': name
    };
  }

  static ChangeProfilePayload fromJson(Map<String, Object?> json) {
    return ChangeProfilePayload(
        email: json['email'] == null ? null : json['email'] as String,
        phone: json['phone'] == null ? null : json['phone'] as String,
        name: json['name'] == null ? null : json['name'] as String,
        addressDetail: json['addressDetail'] == null
            ? null
            : json['addressDetail'] as String);
  }
}
