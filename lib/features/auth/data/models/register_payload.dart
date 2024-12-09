class RegisterPayload {
  final String? userName;
  final String? name;
  final String? email;
  final String? address;
  final String? password;
  final String? hash;

  const RegisterPayload(
      {this.userName,
      this.name,
      this.email,
      this.address,
      this.password,
      this.hash});

  RegisterPayload copyWith(
      {String? userName,
      String? name,
      String? email,
      String? address,
      String? password,
      String? hash}) {
    return RegisterPayload(
        userName: userName ?? this.userName,
        name: name ?? this.name,
        email: email ?? this.email,
        address: address ?? this.address,
        password: password ?? this.password,
        hash: hash ?? this.hash);
  }

  Map<String, Object?> toJson() {
    return {
      'userName': userName,
      'name': name,
      'email': email,
      'address': address,
      'password': password,
      'hash': hash
    };
  }

  static RegisterPayload fromJson(Map<String, Object?> json) {
    return RegisterPayload(
      userName: json['userName'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      address: json['address'] as String?,
      password: json['password'] as String?,
      hash: json['hash'] as String?,
    );
  }
}
