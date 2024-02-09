import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event_history.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/event_history/event_history_card.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/event_history/event_history_search_state_provider.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class EventHistoryList extends ConsumerWidget {
  const EventHistoryList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventHistoryListValue = ref.watch(eventHistorySearchResultsProvider);
    return AsyncValueWidget<List<EventHistory>>(
      value: eventHistoryListValue,
      data: (histories) => histories.isEmpty
          ? Center(
              child: Text(
                'No event history found',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: histories.length,
              itemBuilder: (_, index) {
                final history = histories[index];
                return EventHistoryCard(
                  eventHistory: history,
                  onPressed: () => context.goNamed(
                    AppRoute.eventHistory.name,
                    pathParameters: {'id': history.id},
                  ),
                );
              },
            ),
    );
  }
}
