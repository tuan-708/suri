class RegisterEntity {
  final int id;
  final String? firstName;
  final String? lastName;
  final String? middleName;
  final String? email;
  final String? username;
  final String? password;
  final String? phone;
  final String? name;
  final String? address;

  const RegisterEntity(
      {required this.id,
      this.firstName,
      this.lastName,
      this.middleName,
      required this.email,
      required this.username,
      required this.password,
      this.phone,
      this.name,
      this.address});
}
