import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/custom_image.dart';
import 'package:knightassist_mobile_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/event_screen/leave_review_action.dart';
import 'package:knightassist_mobile_app/src/features/reviews/presentation/event_reviews/event_reviews_list.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/presentation/rsvp_widget.dart';

/*
DATA NEEDED:
- the event's name, image, start time, end time, location, and number of rsvpd volunteers
- the current user's profile picture
- the name and profile picture of the organization who sponsored the event
*/

class EventScreen extends StatelessWidget {
  const EventScreen({super.key, required this.eventID});
  final String eventID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("temp")),
      body: Consumer(
        builder: (context, ref, _) {
          final eventValue = ref.watch(eventProvider(eventID));
          return AsyncValueWidget<Event?>(
            value: eventValue,
            data: (event) => event == null
                ? const EmptyPlaceholderWidget(
                    message: 'Event not found',
                  )
                : CustomScrollView(
                    slivers: [
                      ResponsiveSliverCenter(
                        padding: const EdgeInsets.all(Sizes.p16),
                        child: EventDetails(event: event),
                      ),
                      EventReviewsList(eventID: eventID),
                    ],
                  ),
          );
        },
      ),
    );
  }
}

class EventDetails extends ConsumerWidget {
  const EventDetails({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: CustomImage(imageUrl: event.profilePicPath),
          ),
        ),
        const SizedBox(height: Sizes.p16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(event.name, style: Theme.of(context).textTheme.titleLarge),
                gapH8,
                Text(event.description),
                gapH8,
                LeaveReviewAction(eventID: event.id),
                gapH8,
                RSVPWidget(event: event),
              ],
            ),
          ),
        )
      ],
    );
  }
}
