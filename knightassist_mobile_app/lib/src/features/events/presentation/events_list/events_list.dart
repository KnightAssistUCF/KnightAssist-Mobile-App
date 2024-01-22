import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/event_card.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/events_search_state_provider.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class EventsList extends ConsumerWidget {
  const EventsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventsListValue = ref.watch(eventsSearchResultsProvider);
    return AsyncValueWidget<List<Event>>(
      value: eventsListValue,
      data: (events) => events.isEmpty
          ? Center(
              child: Text(
                'No events found',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: events.length,
              itemBuilder: (_, index) {
                final event = events[index];
                return EventCard(
                  event: event,
                  onPressed: () => context.goNamed(
                    AppRoute.event.name,
                    pathParameters: {'id': event.id},
                  ),
                );
              },
            ),
    );
  }
}