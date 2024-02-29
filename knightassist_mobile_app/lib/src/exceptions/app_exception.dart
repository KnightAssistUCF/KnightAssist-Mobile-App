sealed class AppException implements Exception {
  AppException(this.code, this.message);
  final String code;
  final String message;

  @override
  String toString() => message;
}

// Auth
class EmailAlreadyInUseException extends AppException {
  EmailAlreadyInUseException()
      : super('email-already-in-use', 'Email already in use');
}

class WeakPasswordException extends AppException {
  WeakPasswordException() : super('weak-password', 'Password is too weak');
}

class WrongPasswordException extends AppException {
  WrongPasswordException() : super('wrong-password', 'Wrong password');
}

class UserNotFoundException extends AppException {
  UserNotFoundException() : super('user-not-found', 'User not found');
}

// Event
class EventNotFoundException extends AppException {
  EventNotFoundException() : super('event-not-found', 'Event not found');
}

// Organization
class OrganizationNotFoundException extends AppException {
  OrganizationNotFoundException()
      : super('org-not-found', 'Organization not found');
}

// Admins must use web app
class AdminLogInException extends AppException {
  AdminLogInException()
      : super('admin-log-in',
            'Admins must use the KnightAssist web application to access admin functionality.');
}
