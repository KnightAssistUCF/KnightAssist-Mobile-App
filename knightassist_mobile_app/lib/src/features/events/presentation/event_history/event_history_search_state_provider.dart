import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event_history.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'event_history_search_state_provider.g.dart';

final eventHistorySearchQueryStateProvider = StateProvider<String>((ref) {
  return '';
});

@riverpod
Future<List<EventHistory>> eventHistorySearchResults(
    EventHistorySearchResultsRef ref) {
  final user = ref.read(authRepositoryProvider).currentUser;
  if (user == null) {
    throw AssertionError('Can\'t view event history if user is not signed in');
  }
  final searchQuery = ref.watch(eventHistorySearchQueryStateProvider);
  return ref.watch(eventHistoryListSearchProvider(user.id, searchQuery).future);
}
