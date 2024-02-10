import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event_history.dart';

class EventHistoryService {
  EventHistoryService(this.ref);
  final Ref ref;

  Future<List<EventHistory>> _fetchEventHistory() {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) {
      throw AssertionError(
          'Can\'t view event history if user is not signed in');
    }
    return ref.read(eventsRepositoryProvider).fetchEventHistoryList(user.id);
  }
}
