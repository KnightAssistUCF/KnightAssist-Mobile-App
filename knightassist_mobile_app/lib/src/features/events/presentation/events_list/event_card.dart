import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:flutter/material.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/images/data/images_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/data/rsvp_repository.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/presentation/rsvp_widget.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

/*
DATA NEEDED:
- the event's name, image, start time, end time, location, and number of rsvpd volunteers
- the name and profile picture of the organization who sponsored the event
*/

class EventCard extends ConsumerWidget {
  const EventCard({super.key, required this.event, this.onPressed});

  final Event event;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const eventCardKey = Key('event-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool sponsorOrg =
        false; // show edit event button if the org sponsoring the event is viewing it
    final rsvpRepository = ref.watch(rsvpRepositoryProvider);
    final authRepository = ref.watch(authRepositoryProvider);
    final organizationsRepository = ref.watch(organizationsRepositoryProvider);
    final imagesRepository = ref.watch(imagesRepositoryProvider);
    final user = authRepository.currentUser;
    print("Id:" + user!.id);
    //print(event.sponsoringOrganization);
    if (user.role == 'organization') {
      //print(user.id);
      //final org = organizationsRepository.getOrganization(user.id);
      //final orgs = organizationsRepository.fetchOrganizationsList;
      //print(orgs);
      //print(org?.id);
      //print(org?.eventsArray);
      //print(org?.name);

      if (event.sponsoringOrganization == user.id) {
        sponsorOrg = true;
      }
    }

    final sponsor =
        organizationsRepository.getOrganization(event.sponsoringOrganization);

    Widget getImage() {
      return FutureBuilder(
          future: imagesRepository.retrieveImage('1', event.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                final String imageUrl = snapshot.data!;
                return Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(imageUrl), fit: BoxFit.cover)),
                  width: MediaQuery.sizeOf(context).width,
                  height: 100,
                );
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    }

    Widget getOrgImage() {
      return FutureBuilder(
          future: imagesRepository.retrieveImage('2', sponsor!.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    '${snapshot.error} occurred',
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              } else if (snapshot.hasData) {
                final String imageUrl = snapshot.data!;
                return ClipRRect(
                    borderRadius: BorderRadius.circular(25.0),
                    child: Image(image: NetworkImage(imageUrl), height: 20));
              }
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          });
    }

    return Card(
      child: InkWell(
        key: eventCardKey,
        onTap: onPressed,
        child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Column(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: /*Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(event.profilePicPath),
                            fit: BoxFit.fill)),
                    width: 120,
                    height: 210,
                  ),*/
                        getImage()),
                const SizedBox(width: 10),
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
                    getOrgImage(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        sponsor?.name ?? '',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
                user.role == 'student'
                    ? RSVPWidget(event: event)
                    : _renderOrgEditState(sponsorOrg, context, event),
              ],
            )),
      ),
    );
  }
}

Widget _renderOrgEditState(bool curOrg, BuildContext context, Event event) {
  if (curOrg) {
    return FilledButton(
      onPressed: () => context.pushNamed("editevent", extra: event),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 91, 78, 119))),
      child: const Text('Edit'),
    );
  } else {
    return const SizedBox(height: 0);
  }
}
