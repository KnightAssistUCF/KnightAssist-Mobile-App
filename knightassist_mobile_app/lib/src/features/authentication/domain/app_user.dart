import 'dart:convert';

class AppUser {
  const AppUser(
      {required this.email, required this.firstName, required this.lastName});
  final String email;
  final String firstName;
  final String lastName;

  Map<String, dynamic> toMap() {
    return {'email': email, 'firstName': firstName, 'lastName': lastName};
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
        email: map['email'] ?? '',
        firstName: map['firstName'] ?? '',
        lastName: map['lastName'] ?? '');
  }

  String toJson() => jsonEncode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(jsonDecode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AppUser &&
        other.email == email &&
        other.firstName == firstName &&
        other.lastName == lastName;
  }

  @override
  int get hashCode => email.hashCode ^ firstName.hashCode ^ lastName.hashCode;

  @override
  String toString() =>
      'AppUser(email: $email, firstName: $firstName, lastName: $lastName)';
}
