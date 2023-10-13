import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';

/// Fake user class used to simulate a user account on the backend
class FakeAppUser extends AppUser {
  FakeAppUser(
      {required super.email,
      required super.firstName,
      required super.lastName,
      required this.password});
  final String password;
}
