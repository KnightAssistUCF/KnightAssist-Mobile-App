import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:intl/intl.dart';

List<Event> events = [
  Event(
      id: '1',
      name: 'concert',
      description: 'really cool music, need someone to serve food',
      location: 'addition financial arena',
      date: DateTime.fromMillisecondsSinceEpoch(1699875173000),
      sponsoringOrganization: 'Organization X',
      attendees: [],
      registeredVolunteers: [],
      picLink: 'assets/profile pictures/icon_leaf.png',
      startTime: DateTime.fromMillisecondsSinceEpoch(1699875173000),
      endTime: DateTime.fromMillisecondsSinceEpoch(1699875173099),
      eventTags: ['music', 'food'],
      semester: 'Fall 2023',
      maxAttendees: 1000,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1700968029),
      updatedAt: DateTime.now()),
  Event(
      id: '2',
      name: 'study session',
      description: 'cs1, need someone to bring water',
      location: 'ucf library',
      date: DateTime.fromMillisecondsSinceEpoch(1698433137000),
      sponsoringOrganization: 'Organization Y',
      attendees: [],
      registeredVolunteers: [],
      picLink: 'assets/profile pictures/icon_leaf.png',
      startTime: DateTime.fromMillisecondsSinceEpoch(1698433137000),
      endTime: DateTime.fromMillisecondsSinceEpoch(1698433137099),
      eventTags: ['education', 'technology'],
      semester: 'Fall 2023',
      maxAttendees: 30,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1700968029),
      updatedAt: DateTime.now()),
  Event(
      id: '3',
      name: 'movie night',
      description: 'need someone to collect tickets',
      location: 'pegasus ballroom',
      date: DateTime.fromMillisecondsSinceEpoch(1695774773000),
      sponsoringOrganization: 'Organization Z',
      attendees: [],
      registeredVolunteers: [],
      picLink: 'assets/profile pictures/icon_leaf.png',
      startTime: DateTime.fromMillisecondsSinceEpoch(1695774773000),
      endTime: DateTime.fromMillisecondsSinceEpoch(1695774773099),
      eventTags: ['movie', 'education', 'food'],
      semester: 'Fall 2023',
      maxAttendees: 400,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1700968029),
      updatedAt: DateTime.now()),
      Event(
      id: '4',
      name: 'movie night but its date isn\'t previous',
      description: 'need someone to collect tickets',
      location: 'pegasus ballroom',
      date: DateTime.fromMillisecondsSinceEpoch(1734218796000),
      sponsoringOrganization: 'Organization Z',
      attendees: [],
      registeredVolunteers: [],
      picLink: 'assets/profile pictures/icon_leaf.png',
      startTime: DateTime.fromMillisecondsSinceEpoch(1734218796000),
      endTime: DateTime.fromMillisecondsSinceEpoch(1734219036000),
      eventTags: ['movie', 'education', 'food'],
      semester: 'Fall 2023',
      maxAttendees: 400,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1702596396),
      updatedAt: DateTime.now())
];

class EventsListScreen extends ConsumerWidget {
  const EventsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Volunteer Shifts',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
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
      body: Container(
        height: h,
        child: Column(
          children: [
            _topSection(w),
            Flexible(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: events.length,
                itemBuilder: (context, index) =>
                    EventCard(event: events.elementAt(index)),
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          //padding: EdgeInsets.zero,
          children: [
            //const DrawerHeader(
            //decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/KnightAssistCoA3.png"),),),
            //child: Text('KnightAssist')),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                context.pushNamed(AppRoute.homeScreen.name);
              },
            ),
            ListTile(
              title: const Text('Organizations'),
              onTap: () {
                context.pushNamed(AppRoute.organizations.name);
              },
            ),
            ListTile(
              title: const Text('Events'),
              onTap: () {
                context.pushNamed(AppRoute.events.name);
              },
            ),
            ListTile(
              title: const Text('History'),
              onTap: () {
                context.pushNamed(AppRoute.eventHistory.name);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                context.pushNamed(AppRoute.account.name);
              },
            ),
            ListTile(
              title: const Text('Sign Out'),
              onTap: () {
                context.pushNamed(AppRoute.emailConfirm.name);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

_topSection(double width) {
  return Container(
      //height: 200,
      width: width,
      color: const Color.fromARGB(255, 0, 108, 81),
      child: const Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: SearchBar(
                    hintText: 'Search Events',
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    return SingleChildScrollView(
      child: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                onTap: () => context.pushNamed("event", extra: event),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Wrap(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: const Image(
                                  image: AssetImage('assets/example.png'),
                                  height: 100)),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  event.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  DateFormat('yyyy-MM-dd – kk:mm')
                                      .format(event.date),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  event.location,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.start,
                                ),
                                OverflowBar(
                                  children: [
                                    ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        child: const Image(
                                            image: AssetImage(
                                                'assets/example.png'),
                                            height: 20)),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        event.sponsoringOrganization,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w400),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          OverflowBar(
                            spacing: 8,
                            overflowAlignment: OverflowBarAlignment.end,
                            children: [
                              Align(
                                alignment: const Alignment(1, 0.6),
                                child: FilledButton(
                                  onPressed: () {},
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color.fromARGB(
                                                  255, 91, 78, 119))),
                                  child: const Text('RSVP'),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
