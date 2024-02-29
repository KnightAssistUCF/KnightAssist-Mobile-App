import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'organizations_search_state_provider.g.dart';

final organizationsSearchQueryStateProvider = StateProvider<String>((ref) {
  return '';
});

@riverpod
Future<List<Organization>> organizationsSearchResults(
    OrganizationsSearchResultsRef ref) {
  final searchQuery = ref.watch(organizationsSearchQueryStateProvider);
  return ref.watch(organizationsListSearchProvider(searchQuery).future);
}
