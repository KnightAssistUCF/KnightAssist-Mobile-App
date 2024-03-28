class AppUser {
  const AppUser(
      {required this.id,
      required this.email,
      required this.role,
      required this.firstTimeLogIn});

  final String id;
  final String email;
  final String role;
  final bool firstTimeLogIn;
}
