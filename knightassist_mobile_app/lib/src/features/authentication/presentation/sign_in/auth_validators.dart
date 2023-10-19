import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/string_validators.dart';

mixin AuthValidators {
  final StringValidator emailSubmitValidator = EmailSubmitRegexValidator();
  final StringValidator passwordRegisterSubmitValidator =
      MinLengthStringValidator(8);
  final StringValidator passwordSignInSubmitValidator =
      NonEmptyStringValidator();
  final StringValidator nameRegisterSubmitValidator = NonEmptyStringValidator();

  bool canSubmitEmail(String email) {
    return emailSubmitValidator.isValid(email);
  }

  bool canSignInSubmitPassword(String password) {
    return passwordSignInSubmitValidator.isValid(password);
  }

  bool canRegisterSubmitPassword(String password) {
    return passwordRegisterSubmitValidator.isValid(password);
  }

  bool canSubmitRepeatedPassword(String password, String repeatedPassword) {
    return (password == repeatedPassword);
  }

  bool canSubmitName(String name) {
    return nameRegisterSubmitValidator.isValid(name);
  }

  String? emailErrorText(String email) {
    final bool showErrorText = !canSubmitEmail(email);
    final String errorText =
        email.isEmpty ? 'Email can\'t be empty' : 'Invalid email';
    return showErrorText ? errorText : null;
  }

  String? passwordSignInErrorText(String password) {
    final bool showErrorText = !canSignInSubmitPassword(password);
    final String errorText =
        password.isEmpty ? 'Password can\'t be empty' : 'Password is too short';
    return showErrorText ? errorText : null;
  }

  String? passwordRegisterErrorText(String password) {
    final bool showErrorText = !canRegisterSubmitPassword(password);
    final String errorText =
        password.isEmpty ? 'Password can\'t be empty' : 'Password is too short';
    return showErrorText ? errorText : null;
  }

  String? repeatedPasswordErrorText(String password, String repeatedPassword) {
    final bool showErrorText =
        !canSubmitRepeatedPassword(password, repeatedPassword);
    const String errorText = 'Passwords do not match';
    return showErrorText ? errorText : null;
  }

  String? nameErrorText(String name) {
    final bool showErrorText = !canSubmitName(name);
    const String errorText = 'Name can\'t be empty';
    return showErrorText ? errorText : null;
  }
}
