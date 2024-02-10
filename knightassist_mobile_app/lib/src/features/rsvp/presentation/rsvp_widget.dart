import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/alert_dialogs.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/data/rsvp_repository.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/presentation/rsvp_controller.dart';
import 'package:knightassist_mobile_app/src/utils/async_value_ui.dart';

String bodyString = '';

class RSVPWidget extends StatefulWidget {
  final Event event;

  const RSVPWidget({
    super.key,
    required this.event,
  });

  @override
  State<RSVPWidget> createState() => _RSVPWidgetState();
}

class _RSVPWidgetState extends State<RSVPWidget> {
  late final Event event;

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        ref.listen<AsyncValue<int>>(
          rSVPControllerProvider,
          (_, state) => state.showAlertDialogOnError(context),
        );
        final state = ref.watch(rSVPControllerProvider);

        return PrimaryButton(
          isLoading: state.isLoading,
          onPressed: () {
            ref
                .read(rSVPControllerProvider.notifier)
                .rsvp(event.id, event.name)
                .then((value) {
              setState(() {
                bodyString = value;
              });
            });

            showAlertDialog(context: context, title: bodyString);
          },
          text: 'RSVP',
        );
      },
    );
  }
}
