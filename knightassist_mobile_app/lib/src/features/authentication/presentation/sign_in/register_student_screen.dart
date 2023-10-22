import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/auth_validators.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/register_student_controller.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/string_validators.dart';
import 'package:knightassist_mobile_app/src/utils/async_value_ui.dart';

class RegisterStudentScreen extends StatelessWidget {
  const RegisterStudentScreen({super.key});

  static const emailKey = Key('email');
  static const passwordKey = Key('password');
  static const repeatPasswordKey = Key('repeatPassword');
  static const firstNameKey = Key('firstName');
  static const lastNameKey = Key('lastName');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Student')),
      body: const RegisterStudentContents(),
    );
  }
}

class RegisterStudentContents extends ConsumerStatefulWidget {
  const RegisterStudentContents({super.key, this.onRegistered});
  final VoidCallback? onRegistered;

  @override
  ConsumerState<RegisterStudentContents> createState() =>
      _RegisterStudentContentsState();
}

class _RegisterStudentContentsState
    extends ConsumerState<RegisterStudentContents> with AuthValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;
  String get repeatPassword => _repeatPasswordController.text;
  String get firstName => _firstNameController.text;
  String get lastName => _lastNameController.text;

  var _submitted = false;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState!.validate()) {
      final controller = ref.read(registerStudentControllerProvider.notifier);
      final success = await controller.submit(
          email: email,
          password: password,
          firstName: firstName,
          lastName: lastName);
      if (success) {
        widget.onRegistered?.call();
      }
    }
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _firstNameEditingComplete() {
    if (canSubmitName(firstName)) {
      _node.nextFocus();
    }
  }

  void _lastNameEditingComplete() {
    if (canSubmitName(lastName)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!canRegisterSubmitPassword(password)) {
      _node.nextFocus();
    }
  }

  void _repeatPasswordEditingComplete() {
    if (!canSubmitEmail(email) ||
        !canSubmitName(firstName) ||
        !canSubmitName(lastName) ||
        !canRegisterSubmitPassword(password)) {
      _node.unfocus();
      return;
    }
    _submit();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(registerStudentControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(registerStudentControllerProvider);

    return ResponsiveScrollableCard(
        child: FocusScope(
      node: _node,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            gapH8,
            TextFormField(
              key: RegisterStudentScreen.emailKey,
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'test@test.com',
                  enabled: !state.isLoading),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  !_submitted ? null : emailErrorText(email ?? ''),
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.light,
              onEditingComplete: () => _emailEditingComplete(),
              inputFormatters: <TextInputFormatter>[
                ValidatorInputFormatter(
                    editingValidator: EmailEditingRegexValidator())
              ],
            ),
            gapH8,
            TextFormField(
                key: RegisterStudentScreen.firstNameKey,
                controller: _firstNameController,
                decoration: InputDecoration(
                    labelText: 'First Name', enabled: !state.isLoading),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (firstName) =>
                    !_submitted ? null : nameErrorText(firstName ?? ''),
                autocorrect: false,
                textInputAction: TextInputAction.next,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () => _firstNameEditingComplete()),
            gapH8,
            TextFormField(
                key: RegisterStudentScreen.lastNameKey,
                controller: _lastNameController,
                decoration: InputDecoration(
                    labelText: 'Last name', enabled: !state.isLoading),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (lastName) =>
                    !_submitted ? null : nameErrorText(lastName ?? ''),
                autocorrect: false,
                textInputAction: TextInputAction.next,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () => _lastNameEditingComplete()),
            gapH8,
            TextFormField(
              key: RegisterStudentScreen.passwordKey,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                enabled: !state.isLoading,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) => !_submitted
                  ? null
                  : passwordRegisterErrorText(password ?? ''),
              obscureText: true,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              keyboardAppearance: Brightness.light,
              onEditingComplete: () => _passwordEditingComplete(),
            ),
            gapH8,
            TextFormField(
              key: RegisterStudentScreen.repeatPasswordKey,
              controller: _repeatPasswordController,
              decoration: InputDecoration(
                  labelText: 'Repeat Password', enabled: !state.isLoading),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (repeatPassword) => !_submitted
                  ? null
                  : repeatedPasswordErrorText(password, repeatPassword ?? ''),
              obscureText: true,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              keyboardAppearance: Brightness.light,
              onEditingComplete: () => _repeatPasswordEditingComplete(),
            ),
            gapH8,
            PrimaryButton(
              text: 'Register Student',
              isLoading: state.isLoading,
              onPressed: state.isLoading ? null : () => _submit(),
            ),
          ],
        ),
      ),
    ));
  }
}
