import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event_history.dart';

class EventHistoryCard extends ConsumerWidget {
  const EventHistoryCard(
      {super.key, required this.eventHistory, this.onPressed});

  final EventHistory eventHistory;
  final VoidCallback? onPressed;

  static const eventHistoryCardKey = Key('event-history-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        key: eventHistoryCardKey,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          // TODO: Implement announcement card appearance
          child: Container(),
        ),
      ),
    );
  }
}
