import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';

class EventScreen extends ConsumerWidget {
  const EventScreen({super.key, required this.eventID});
  final EventID eventID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email Confirmed'),
      ),
      body: const Center(
          child: Text("Thanks for confirming your email! Proceed to log in.")),
    );
  }
}
