import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_search_state_provider.g.dart';

final eventsSearchQueryStateProvider = StateProvider<String>((ref) {
  return '';
});

@riverpod
Future<List<Event>> eventsSearchResults(EventsSearchResultsRef ref) {
  final searchQuery = ref.watch(eventsSearchQueryStateProvider);
  return ref.watch(eventsListSearchProvider(searchQuery).future);
}
