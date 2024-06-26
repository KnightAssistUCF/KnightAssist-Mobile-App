import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/alert_dialogs.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/data/rsvp_repository.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/presentation/rsvp_controller.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/utils/async_value_ui.dart';

/*
DATA NEEDED:
- the full event object of the event the student is changing their RSVP status for
- the full studentuser object of the current user and their ID
*/

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

        final studentRepository = ref.watch(studentsRepositoryProvider);
        final authRepository = ref.watch(authRepositoryProvider);
        final user = authRepository.currentUser;
        studentRepository.fetchEventAttendees(event.id);
        final student = studentRepository.getStudent();
        final rsvpRepository = ref.watch(rsvpRepositoryProvider);

        bool eventFull = event.registeredVolunteers.length >= event.maxAttendees
            ? true
            : false;

        bool alreadyRSVPd = student!.eventsRsvp.contains(event.id);

        //student.then(
        //(value) => alreadyRSVPd = value.eventsRsvp.contains(event.id));

        return PrimaryButton(
          isLoading: state.isLoading,
          onPressed: () {
            if (alreadyRSVPd) {
              // cancel RSVP
              /*ref
                  .read(rSVPControllerProvider.notifier)
                  .cancelrsvp(event.id, event.name)
                  .then((value) {
                setState(() {
                  bodyString = value;
                });
              });*/

              rsvpRepository
                  .cancelRSVP(student.id, event.id, event.name)
                  .then((value) => setState(() {
                        bodyString = value;

                        showAlertDialog(context: context, title: bodyString);
                      }));

              student.eventsRsvp.remove(event.id);
              if (event.attendees.contains(student.id)) {
                event.attendees.remove(student.id);
              }
            } else if (eventFull) {
              // do nothing
            } else {
              // RSVP for event
              /*ref
                  .read(rSVPControllerProvider.notifier)
                  .rsvp(event.id, event.name)
                  .then((value) {
                setState(() {
                  bodyString = value;
                });
              });*/

              rsvpRepository
                  .setRSVP(student.id, event.id, event.name)
                  .then((value) => setState(() {
                        bodyString = value;

                        showAlertDialog(context: context, title: bodyString);
                      }));

              student.eventsRsvp.add(event.id);
              if (!event.attendees.contains(student.id)) {
                event.attendees.add(student.id);
              }
            }
          },
          text: alreadyRSVPd
              ? 'Cancel RSVP'
              : eventFull
                  ? 'Event Full'
                  : 'RSVP',
        );
      },
    );
  }
}
