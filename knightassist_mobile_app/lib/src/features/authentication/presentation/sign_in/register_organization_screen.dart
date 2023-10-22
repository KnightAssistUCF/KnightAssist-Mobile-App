import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/auth_validators.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/register_organization_controller.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/string_validators.dart';
import 'package:knightassist_mobile_app/src/utils/async_value_ui.dart';

class RegisterOrganizationScreen extends StatelessWidget {
  const RegisterOrganizationScreen({super.key});

  static const emailKey = Key('email');
  static const passwordKey = Key('password');
  static const repeatPasswordKey = Key('repeatPassword');
  static const nameKey = Key('name');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register Organization')),
      body: const RegisterOrganizationContents(),
    );
  }
}

class RegisterOrganizationContents extends ConsumerStatefulWidget {
  const RegisterOrganizationContents({super.key, this.onRegistered});
  final VoidCallback? onRegistered;

  @override
  ConsumerState<RegisterOrganizationContents> createState() =>
      _RegisterOrganizationContentsState();
}

class _RegisterOrganizationContentsState
    extends ConsumerState<RegisterOrganizationContents> with AuthValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();
  final _nameController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;
  String get repeatPassword => _repeatPasswordController.text;
  String get name => _nameController.text;

  var _submitted = false;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitted = true;
    });
    if (_formKey.currentState!.validate()) {
      final controller =
          ref.read(registerOrganizationControllerProvider.notifier);
      final success =
          await controller.submit(email: email, password: password, name: name);
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

  void _nameEditingComplete() {
    if (canSubmitName(name)) {
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
        !canSubmitName(name) ||
        !canRegisterSubmitPassword(password)) {
      _node.unfocus();
      return;
    }
    _submit();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(registerOrganizationControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(registerOrganizationControllerProvider);

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
              key: RegisterOrganizationScreen.emailKey,
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
                key: RegisterOrganizationScreen.nameKey,
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: 'First Name', enabled: !state.isLoading),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (firstName) =>
                    !_submitted ? null : nameErrorText(firstName ?? ''),
                autocorrect: false,
                textInputAction: TextInputAction.next,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () => _nameEditingComplete()),
            gapH8,
            TextFormField(
              key: RegisterOrganizationScreen.passwordKey,
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
              key: RegisterOrganizationScreen.repeatPasswordKey,
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
              text: 'Register Organization',
              isLoading: state.isLoading,
              onPressed: state.isLoading ? null : () => _submit(),
            ),
          ],
        ),
      ),
    ));
  }
}
