import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/data/rsvp_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rsvp_service.g.dart';

class RSVPService {
  RSVPService(this.ref);
  final Ref ref;

  Future<List<String>> _fetchRSVPEvents() {
    final user = ref.read(authRepositoryProvider).currentUser;
    assert(user != null);
    if (user == null) {
      throw AssertionError('Can\'t RSVP to an event if user is not signed in');
    }
    return ref.read(rsvpRepositoryProvider).fetchRSVPs(user.id);
  }

  Future<void> setRSVP(String eventID, String eventName) async {
    final user = ref.read(authRepositoryProvider).currentUser;
    assert(user != null);
    if (user == null) {
      throw AssertionError('Can\'t add RSVPs if user is not signed in');
    }
    await ref.read(rsvpRepositoryProvider).setRSVP(user.id, eventID, eventName);
  }
}

@Riverpod(keepAlive: true)
RSVPService rsvpService(RsvpServiceRef ref) {
  return RSVPService(ref);
}

@Riverpod(keepAlive: true)
Stream<List<String>> rsvps(RsvpsRef ref) {
  final user = ref.watch(authStateChangesProvider).value;
  assert(user != null);
  if (user == null) {
    throw AssertionError('Can\'t RSVP to an event if user is not signed in');
  }
  return ref.watch(rsvpRepositoryProvider).watchRSVPs(user.id);
}
