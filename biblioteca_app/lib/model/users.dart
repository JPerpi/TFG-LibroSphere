class Users {
  late String username;
  String? password;
  int? tema;

  Users({
    required this.username,
    this.password,
    this.tema,
  });

  @override
  String toString() =>
      "$username; $password; $tema;";
}
