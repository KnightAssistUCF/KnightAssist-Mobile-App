import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:flutter/material.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventCard extends ConsumerWidget {
  const EventCard({super.key, required this.event, this.onPressed});

  final Event event;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const eventCardKey = Key('event-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        key: eventCardKey,
        onTap: onPressed,
        child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Container(
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(event.picLink),
                              fit: BoxFit.fill)),
                      width: 120,
                      height: 210,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          event.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          event.location,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: const TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                        OverflowBar(
                          children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: const Image(
                                    image: AssetImage('assets/example.png'),
                                    height: 20)),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                event.sponsoringOrganization,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            )
                          ],
                        ),
                        FilledButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color.fromARGB(255, 91, 78, 119))),
                          child: const Text('RSVP'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
