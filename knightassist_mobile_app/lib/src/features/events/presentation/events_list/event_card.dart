import 'package:flutter/foundation.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:flutter/material.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/data/rsvp_repository.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/presentation/rsvp_widget.dart';

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
    final user = authRepository.currentUser;
    print("Id:" + user!.id);
    print(event.sponsoringOrganization);
    if (user?.role == 'organization') {
      if (user != null) {
        //print(user.id);
        //final org = organizationsRepository.getOrganization(user.id);
        //final orgs = organizationsRepository.fetchOrganizationsList;
        //print(orgs);
        //print(org?.id);
        //print(org?.eventsArray);
        //print(org?.name);
        //print(event.sponsoringOrganization);

        if (event.sponsoringOrganization == user.id) {
          sponsorOrg = true;
        }
      }
    }

    return Card(
      child: InkWell(
        key: eventCardKey,
        onTap: onPressed,
        child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(event.profilePicPath),
                            fit: BoxFit.fill)),
                    width: 120,
                    height: 210,
                  ),
                ),
                const SizedBox(width: 10),
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          )
                        ],
                      ),
                      user?.role == "student"
                          ? RSVPWidget(event: event)
                          : _renderOrgEditState(
                              sponsorOrg) /*SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: FilledButton(
                                    onPressed: () {
                                      /*rsvpRepository.setRSVP(
                                user!.id, event.id, event.name);
                                                          showAboutDialog(context: context, children: [
                                                            Text('Rsvped for event: ${event.name}')
                                                          ]);*/
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 91, 78, 119))),
                                    child: const Text('Edit'),
                                  ),
                                )*/
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

Widget _renderOrgEditState(bool curOrg) {
  if (curOrg) {
    return FilledButton(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 91, 78, 119))),
      child: const Text('Edit'),
    );
  } else {
    return const SizedBox(height: 0);
  }
}
