import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/sign_in_controller.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/auth_validators.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/sign_in/string_validators.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:knightassist_mobile_app/src/utils/async_value_ui.dart';
import 'package:knightassist_mobile_app/src/common_widgets/custom_text_button.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  static const emailKey = Key('email');
  static const passwordKey = Key('password');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: ListView(
        children: [
          const Image(
            image: AssetImage('assets/KnightAssistCoA3.png'),
            height: 60,
          ),
          Center(
            child: const Text('welcome to',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ),
          Center(
            child: const Text('KnightAssist',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text('easier volunteering is just a step away!',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
            ),
          ),
          SignInContents(
            onSignedIn: () {
              context.pushNamed(AppRoute.homeScreen.name);
            },
          ),
        ],
      ),
    );
  }
}

class SignInContents extends ConsumerStatefulWidget {
  const SignInContents({super.key, this.onSignedIn});
  final VoidCallback? onSignedIn;

  @override
  ConsumerState<SignInContents> createState() => _SignInContentsState();
}

class _SignInContentsState extends ConsumerState<SignInContents>
    with AuthValidators {
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;

  var _submitted = false;

  @override
  void dispose() {
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() {
      _submitted = true;
    });

    if (_formKey.currentState!.validate()) {
      final controller = ref.read(signInControllerProvider.notifier);
      final success = await controller.submit(email: email, password: password);
      if (success) {
        widget.onSignedIn?.call();
      }
    }
  }

  void _emailEditingComplete() {
    if (canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete() {
    if (!canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(signInControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(signInControllerProvider);
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
              key: SignInScreen.emailKey,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'user@example.com',
                enabled: !state.isLoading,
              ),
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
              key: SignInScreen.passwordKey,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                enabled: !state.isLoading,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) =>
                  !_submitted ? null : passwordSignInErrorText(password ?? ''),
              obscureText: true,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              keyboardAppearance: Brightness.light,
              onEditingComplete: () => _passwordEditingComplete(),
            ),
            gapH8,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PrimaryButton(
                text: 'Sign In',
                isLoading: state.isLoading,
                onPressed: state.isLoading ? null : () => _submit(),
              ),
            ),
            CustomTextButton(
              text: 'Forgout your password?',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              onPressed: () => state.isLoading
                  ? null
                  : context.pushNamed(AppRoute.registerStudent.name),
            ),
            gapH8,
            const Row(children: <Widget>[
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              )),
              Text(
                "OR",
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(),
              )),
            ]),
            CustomTextButton(
              text: 'Register as a Student',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              onPressed: () => state.isLoading
                  ? null
                  : context.pushNamed(AppRoute.registerStudent.name),
            ),
            gapH4,
            CustomTextButton(
              text: 'Register as an Organization',
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              onPressed: () => state.isLoading
                  ? null
                  : context.pushNamed(AppRoute.registerOrg.name),
            ),
          ],
        ),
      ),
    ));
  }
}
