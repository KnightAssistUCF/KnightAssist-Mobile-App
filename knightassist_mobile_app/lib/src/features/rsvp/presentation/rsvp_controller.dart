import 'package:flutter/material.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/application/rsvp_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rsvp_controller.g.dart';

@riverpod
class RSVPController extends _$RSVPController {
  @override
  FutureOr<int> build() {
    return 1;
  }

  Future<String> rsvp(String eventID, String eventName) async {
    final rsvpService = ref.read(rsvpServiceProvider);
    state = const AsyncLoading<int>().copyWithPrevious(state);
    final value =
        await AsyncValue.guard(() => rsvpService.setRSVP(eventID, eventName));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(1);
      return rsvpService.setRSVP(eventID, eventName).toString();
    }
    return '';
  }

  Future<String> cancelrsvp(String eventID, String eventName) async {
    final rsvpService = ref.read(rsvpServiceProvider);
    state = const AsyncLoading<int>().copyWithPrevious(state);
    final value = await AsyncValue.guard(
        () => rsvpService.cancelRSVP(eventID, eventName));
    if (value.hasError) {
      state = AsyncError(value.error!, StackTrace.current);
    } else {
      state = const AsyncData(1);
      return rsvpService.cancelRSVP(eventID, eventName).toString();
    }
    return '';
  }
}
