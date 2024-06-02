class Users {
  late String username;
  String? password;
  String? profilePicture; // Ruta de la imagen de perfil
  String? twitterUsername;
  String? tiktokUsername;
  String? instagramUsername;

  Users({
    required this.username,
    this.password,
    this.profilePicture,
    this.twitterUsername,
    this.tiktokUsername,
    this.instagramUsername,
  });

  @override
  String toString() {
    return "$username; $password; $profilePicture; $twitterUsername; $tiktokUsername; $instagramUsername;";
  }
}
