import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/feedback.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class PostScan extends ConsumerWidget {
  const PostScan({super.key, required this.event});
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    bool checkIn = false; // false if a voluntter has checked out
    // this is to show the correct details

    final difference = event.endTime.difference(event.startTime).inHours;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'QR Code Scanned',
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                children: [
                  const Text(
                    'Scanned Successfully!', // TODO : add error handling
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    event.name,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    checkIn ? 'Check-In' : 'Check-Out',
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  checkIn
                      ? const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 150,
                        )
                      : Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 50,
                              ),
                              Text("${difference.toString()} Hours",
                                  style: TextStyle(
                                      color: Colors.green,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900)),
                              Text(
                                'Completed!',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                  const Text(
                    'Student Name',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    DateFormat.MMMMEEEEd().format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    DateFormat.jmv().format(DateTime.now()),
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.w600),
                  ),
                  checkIn
                      ? SizedBox(
                          height: 0,
                        )
                      : Padding(
                          // shows leave feedback button for volunteer checking out of event
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  "Help this organization make their events better by leaving feedback (optional).",
                                  style: TextStyle(fontSize: 25),
                                ),
                                ElevatedButton(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Leave Feedback",
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ),
                                  onPressed: () => context.pushNamed(
                                      "createfeedback",
                                      extra: event),
                                ),
                              ],
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
