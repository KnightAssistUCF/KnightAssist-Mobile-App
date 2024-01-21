import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';

class LeaveReviewAction extends ConsumerWidget {
  const LeaveReviewAction({super.key, required this.eventID});
  final EventID eventID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {}
}
