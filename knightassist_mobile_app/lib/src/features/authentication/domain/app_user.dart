class AppUser {
  AppUser(
      {required this.id,
      required this.email,
      required this.role,
      required this.firstTimeLogin});

  final String id;
  final String email;
  final String role;
  bool firstTimeLogin;
}
