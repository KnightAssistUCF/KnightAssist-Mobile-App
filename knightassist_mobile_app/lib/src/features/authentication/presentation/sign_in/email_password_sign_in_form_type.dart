enum EmailPasswordSignInFormType { signIn, register }

extension EmailPasswordSignInFormTypeX on EmailPasswordSignInFormType {
  String get passwordLabelText {
    if (this == EmailPasswordSignInFormType.register) {
      return 'Password (8+ characters)';
    } else {
      return 'Password';
    }
  }

  String get primaryButtonText {
    if (this == EmailPasswordSignInFormType.register) {
      return 'Create an account';
    } else {
      return 'Sign in';
    }
  }

  String get secondaryButtonText {
    if (this == EmailPasswordSignInFormType.register) {
      return 'Have an account? Sign in';
    } else {
      return 'Need an account? Register';
    }
  }

  EmailPasswordSignInFormType get secondaryActionFormType {
    if (this == EmailPasswordSignInFormType.register) {
      return EmailPasswordSignInFormType.signIn;
    } else {
      return EmailPasswordSignInFormType.register;
    }
  }

  String get errorAlertTitle {
    if (this == EmailPasswordSignInFormType.register) {
      return 'Registration failed';
    } else {
      return 'Sign in failed';
    }
  }

  String get title {
    if (this == EmailPasswordSignInFormType.register) {
      return 'Register';
    } else {
      return 'Sign In';
    }
  }
}
