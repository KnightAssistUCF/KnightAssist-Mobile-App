import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';

class ConfirmScreen extends ConsumerWidget {
  const ConfirmScreen({super.key, required this.eventID});
  final EventID eventID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Confirmed'),
      ),
      body: const Column(
        children: [
          Image(
            image: AssetImage('assets/KnightAssistCoA3.png'),
            height: 60,
          ),
          Text('Thanks for confirming your email! Please proceed to log in.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
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
