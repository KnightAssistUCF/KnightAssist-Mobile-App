import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/announcements/data/announcements_repository.dart';
import 'package:knightassist_mobile_app/src/features/announcements/domain/announcement.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcements_search_state_provider.g.dart';

final announcementsSearchQueryStateProvider = StateProvider<String>((ref) {
  return '';
});

@riverpod
Future<List<Announcement>> announcementsSearchResults(
    AnnouncementsSearchResultsRef ref) {
  final searchQuery = ref.watch(announcementsSearchQueryStateProvider);
  return ref.watch(announcementsListSearchProvider(searchQuery).future);
}
