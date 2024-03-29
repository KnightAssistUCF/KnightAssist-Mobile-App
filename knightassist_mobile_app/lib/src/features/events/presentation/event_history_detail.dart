import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event_history.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class HistoryDetailScreen extends ConsumerWidget {
  const HistoryDetailScreen({super.key, required this.event});
  final EventHistory event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    final difference = event.checkOut.difference(event.checkIn).inHours;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event History',
        ),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () {},
              tooltip: 'View notifications',
              icon: const Icon(
                Icons.notifications_outlined,
                color: Colors.white,
                semanticLabel: 'Notifications',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                context.pushNamed(AppRoute.profileScreen.name);
              },
              child: Tooltip(
                message: 'Go to your profile',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: const Image(
                      semanticLabel: 'Profile picture',
                      image: AssetImage(
                          'assets/profile pictures/icon_paintbrush.png'),
                      height: 20),
                ),
              ),
            ),
          )
        ],
      ),
      body: ListView(scrollDirection: Axis.vertical, children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(padding: const EdgeInsets.all(0.0), child: _title(w, event)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              //onPressed: () => context.pushNamed(AppRoute.organization.name,
              //extra: event.sponsoringOrganization),
              onPressed: () {},
              child: Wrap(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: const Image(
                          image: AssetImage('assets/example.png'), height: 50)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      //event.sponsoringOrganization,
                      event.org,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 25),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Check in time: ${event.checkIn}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Check out time: ${event.checkOut}",
              style: const TextStyle(fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Duration: ${difference.toString()} hours",
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Points received: x",
              style: TextStyle(fontSize: 20),
            ),
          ),
          Center(
            child: SizedBox(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed("event", extra: event);
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          const Color.fromARGB(255, 91, 78, 119))),
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Wrap(
                      children: [
                        Text(
                          'View Event Page',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ]),
      ]),
    );
  }
}

_title(double width, EventHistory e) {
  return Builder(builder: (context) {
    return Stack(children: [
      Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(''),
                ),
              ),
            ),
            Text(
              e.name,
              style: const TextStyle(fontSize: 30, color: Colors.black),
            ),
          ],
        ),
      ),
    ]);
  });
}
