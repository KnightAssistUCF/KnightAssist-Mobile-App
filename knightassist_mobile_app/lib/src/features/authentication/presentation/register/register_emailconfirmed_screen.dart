import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';

class ConfirmScreen extends ConsumerWidget {
  const ConfirmScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Confirmed'),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image(
            image: AssetImage('assets/KnightAssistCoA3.png'),
            height: 60,
            alignment: Alignment.center,
          ),
          Text(
            'Thanks for confirming your email! Please proceed to log in.',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            textAlign: TextAlign.center,
          ),
          Divider(
            height: 40,
            indent: 40,
            endIndent: 40,
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: PrimaryButton(
              text: 'Log In',
            ),
          ),
        ],
      ),
    );
  }
}
