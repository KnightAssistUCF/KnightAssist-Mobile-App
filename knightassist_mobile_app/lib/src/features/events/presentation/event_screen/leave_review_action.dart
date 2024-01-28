import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class LeaveReviewAction extends ConsumerWidget {
  const LeaveReviewAction({super.key, required this.eventID});
  final String eventID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        onPressed: () {
          context.pushNamed(AppRoute.createFeedback.name);
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Leave Feedback',
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}
