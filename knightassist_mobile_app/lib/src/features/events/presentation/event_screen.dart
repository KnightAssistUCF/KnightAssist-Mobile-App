import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class EventScreen extends ConsumerWidget {
  const EventScreen({super.key, required this.event});
  //final String eventID;
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event',
          //style: TextStyle(fontSize: 30),
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
      body: ListView(
          scrollDirection: Axis.vertical,
          //height: h,
          children: <Widget>[
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsets.all(0.0), child: _title(w, event)),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.circular(25.0),
                        child: const Image(
                            image: AssetImage('assets/example.png'),
                            height: 50)),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        event.sponsoringOrganization,
                        style: const TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 25),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    const OrganizationFav(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Description: ${event.description}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Location: ${event.location}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Date: ${DateFormat.yMMMMEEEEd().format(event.date)}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Time: ${DateFormat.jmv().format(event.startTime)}",
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Capacity: ${event.maxAttendees}",
                  style: const TextStyle(fontSize: 15, color: Colors.grey),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        //context.pushNamed(AppRoute.events.name);
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromARGB(255, 91, 78, 119))),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Wrap(
                          children: [
                            Text(
                              'RSVP',
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

_title(double width, Event e) {
  return Builder(builder: (context) {
    return Stack(children: [
      Container(
          color: const Color.fromARGB(255, 0, 108, 81),
          width: width,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  FittedBox(
              fit: BoxFit.fill,
              child: Image(
                  image: AssetImage(e.picLink),
                  width: width,
                  height:200),
            ),
                  Text(
                    e.name,
                    style: const TextStyle(fontSize: 30, color: Colors.white),
                  ),
                ],
              ),
            ),
          )),
    ]);
  });
}

class OrganizationFav extends StatefulWidget {
  //final Organization organization;

  const OrganizationFav({super.key});

  @override
  _OrganizationFavState createState() => _OrganizationFavState();
}

class _OrganizationFavState extends State<OrganizationFav> {
  bool _isFavoriteOrg = false;
  //late final Organization organization;

  _OrganizationFavState();

  @override
  void initState() {
    super.initState();
    //organization = widget.organization;
  }

  @override
  Widget build(BuildContext context) {
    //final Organization organization = this.organization;

    return IconButton(
        iconSize: 30.0,
        padding: const EdgeInsets.only(left: 4, right: 4, top: 0),
        icon: _isFavoriteOrg == true
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_outline),
        color: Colors.pink,
        onPressed: () {
          setState(() {
            _isFavoriteOrg = !_isFavoriteOrg;
          });
        });
  }
}
