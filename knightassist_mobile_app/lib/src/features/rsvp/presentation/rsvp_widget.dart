import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/presentation/rsvp_controller.dart';
import 'package:knightassist_mobile_app/src/utils/async_value_ui.dart';

class RSVPWidget extends ConsumerWidget {
  const RSVPWidget({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<int>>(
      rsvpControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(rsvpControllerProvider);
    return PrimaryButton(
      isLoading: state.isLoading,
      onPressed: () => ref.read(rsvpControllerProvider.notifier).rsvp(event.id),
      text: 'RSVP',
    );
  }
}
