import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class CreateFeedback extends ConsumerWidget {
  final Event event;
  const CreateFeedback({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Leave Feedback',
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
        Padding(padding: const EdgeInsets.all(8.0), child: Text(event.name)),
        OverflowBar(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child:
                    Image(image: AssetImage('assets/example.png'), height: 25)),
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(event.sponsoringOrganization)),
        ]),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text((DateFormat.yMMMMEEEEd().format(event.startTime)))),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text((DateFormat.jmv().format(event.startTime)))),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                "You checked out on ${DateFormat.yMMMMEEEEd().format(event.endTime)} at ${DateFormat.jmv().format(event.endTime)}")),
        RatingBar.builder(
          initialRating: 0.0,
          minRating: 1,
          direction: Axis.horizontal,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            print(rating);
            // feedback.rating = rating;
          },
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: SizedBox(
              width: 240,
              height: 120,
              child: TextField(
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    filled: false,
                    hintText:
                        'Feedback Description - Please be as detailed as you can about what you liked and didn\'t like about this event. Organizations use feedback to make their events better.'),
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () {
                context.pushNamed(AppRoute.homeScreen.name);
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Leave Feedback',
                  style: TextStyle(fontSize: 20),
                ),
              )),
        ),
      ]),
    );
  }
}
