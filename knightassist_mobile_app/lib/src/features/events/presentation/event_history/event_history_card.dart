import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event_history.dart';

class EventHistoryCard extends ConsumerWidget {
  const EventHistoryCard(
      {super.key, required this.eventHistory, this.onPressed});

  final EventHistory eventHistory;
  final VoidCallback? onPressed;

  static const eventHistoryCardKey = Key('event-history-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difference =
        eventHistory.checkOut.difference(eventHistory.checkIn).inHours;

    return Padding(
      padding: const EdgeInsets.all(Sizes.p16),
      child: SingleChildScrollView(
        child: ResponsiveCenter(
          maxContentWidth: Breakpoint.tablet,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black26,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              color: Colors.white,
              elevation: 5,
              child: InkWell(
                key: eventHistoryCardKey,
                onTap: onPressed,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    // Event history does not come with images
                    /*
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image(image: AssetImage(''), height: 75)),
                        */
                    title: Text(
                      eventHistory.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //event.sponsoringOrganization,
                          'sponsor org',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          "${difference.toString()} hours",
                          style: const TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
