class ProfileEntity {
  final String? accessToken;
  final Profile? profile;

  const ProfileEntity({
    this.accessToken,
    this.profile,
  });

  ProfileEntity copyWith({String? accessToken, Profile? profile}) {
    return ProfileEntity(
      accessToken: accessToken ?? this.accessToken,
      profile: profile ?? this.profile,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'accessToken': accessToken,
      'profile': profile?.toJson(),
    };
  }
}

class Profile {
  int? id;
  String? name;
  String? photo;
  String? username;
  String? phone;
  String? email;
  String? addressDetail;
  String? rankName;

  Profile(
      {this.id,
      this.name,
      this.photo,
      this.username,
      this.phone,
      this.email,
      this.addressDetail,
      this.rankName});

  Profile copyWith(
      {int? id,
      String? name,
      String? photo,
      String? username,
      String? phone,
      String? email,
      String? addressDetail,
      String? rankName}) {
    return Profile(
        id: id ?? this.id,
        name: name ?? this.name,
        photo: photo ?? this.photo,
        username: username ?? this.username,
        phone: phone ?? this.phone,
        email: email ?? this.email,
        addressDetail: addressDetail ?? this.addressDetail,
        rankName: rankName ?? this.rankName);
  }

/*  */
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        photo: json['photo'] ?? "",
        username: json['username'] ?? "",
        phone: json['phone'] ?? "",
        email: json['email'] ?? "",
        addressDetail: json['addressDetail'] ?? "",
        rankName: json['rankName'] ?? "Hạng thường");
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'username': username,
      'phone': phone,
      'email': email,
      'addressDetail': addressDetail,
      'rankName': rankName ?? "Hạng thường"
    };
  }
}
