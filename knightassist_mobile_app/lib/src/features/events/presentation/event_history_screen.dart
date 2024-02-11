import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/feedback_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/qr_scanner.dart';
import 'package:knightassist_mobile_app/src/features/home/presentation/home_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/update_screen.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:intl/intl.dart';

bool isOrg = true;

List<Event> events = [
  Event(
    id: '1',
    name: 'concert',
    description: 'really cool music, need someone to serve food',
    location: 'addition financial arena',
    sponsoringOrganization: 'Organization X',
    attendees: [],
    registeredVolunteers: [],
    profilePicPath: 'assets/profile pictures/icon_musicnote.png',
    startTime: DateTime.fromMillisecondsSinceEpoch(1699875173000),
    endTime: DateTime.fromMillisecondsSinceEpoch(1699875173099),
    eventTags: ['music', 'food'],
    semester: Semester.FALL_2023,
    maxAttendees: 1000,
    feedback: [],
    checkedInStudents: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Event(
    id: '2',
    name: 'study session',
    description: 'cs1, need someone to bring water',
    location: 'ucf library',
    sponsoringOrganization: 'Organization Y',
    attendees: [],
    registeredVolunteers: [],
    profilePicPath: 'assets/profile pictures/icon_apple.png',
    startTime: DateTime.fromMillisecondsSinceEpoch(1698433137000),
    endTime: DateTime.fromMillisecondsSinceEpoch(1698433137099),
    eventTags: ['education', 'technology'],
    semester: Semester.FALL_2023,
    maxAttendees: 30,
    feedback: [],
    checkedInStudents: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Event(
    id: '3',
    name: 'movie night',
    description: 'need someone to collect tickets',
    location: 'pegasus ballroom',
    sponsoringOrganization:
        'Organization Z long name long name long name long name long name long name long name long name long name long name long name long name',
    attendees: [],
    registeredVolunteers: [],
    profilePicPath: 'assets/profile pictures/icon_controller.png',
    startTime: DateTime.fromMillisecondsSinceEpoch(1695774773000),
    endTime: DateTime.fromMillisecondsSinceEpoch(1695774773099),
    eventTags: ['movie', 'education', 'food'],
    semester: Semester.FALL_2023,
    maxAttendees: 400,
    feedback: [],
    checkedInStudents: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Event(
    id: '4',
    name: 'movie night but its date isn\'t previous',
    description: 'need someone to collect tickets',
    location: 'pegasus ballroom',
    sponsoringOrganization: 'Organization Z',
    attendees: [],
    registeredVolunteers: [],
    profilePicPath: 'assets/profile pictures/icon_cat.png',
    startTime: DateTime.fromMillisecondsSinceEpoch(1734218796000),
    endTime: DateTime.fromMillisecondsSinceEpoch(1734219036000),
    eventTags: ['movie', 'education', 'food'],
    semester: Semester.FALL_2023,
    maxAttendees: 400,
    feedback: [],
    checkedInStudents: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  Event(
    id: '5',
    name: 'movie night but it\'s very long',
    description: 'need someone to collect tickets',
    location: 'pegasus ballroom',
    sponsoringOrganization: 'Organization Z',
    attendees: [],
    registeredVolunteers: [],
    profilePicPath: 'assets/profile pictures/icon_cat.png',
    startTime: DateTime.fromMillisecondsSinceEpoch(1695774773000),
    endTime: DateTime.fromMillisecondsSinceEpoch(1702543765000),
    eventTags: ['movie', 'education', 'food'],
    semester: Semester.FALL_2023,
    maxAttendees: 400,
    feedback: [],
    checkedInStudents: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];

class EventHistoryScreen extends StatefulWidget {
  const EventHistoryScreen({super.key});

  @override
  State<EventHistoryScreen> createState() => _EventHistoryScreenState();
}

class _EventHistoryScreenState extends State<EventHistoryScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool tapped = false;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = isOrg
      ? <Widget>[
          const EventListScreen(),
          const UpdateScreenTab(),
          const HomeScreenTab(),
          const FeedbackListScreenTab(),
        ]
      : <Widget>[
          const EventListScreen(),
          const HomeScreenTab(),
          QRCodeScanner(),
        ];

  late AnimationController _controller;
  bool _pressed = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      tapped = true; // can't return to event history screen from navbar
      _selectedIndex = index;
    });
  }

  static const List<String> icons = ["Create Announcement", "Create Event"];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: isOrg
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(icons.length, (int index) {
                Widget child = Container(
                  height: 100.0,
                  width: 300.0,
                  alignment: FractionalOffset.topCenter,
                  child: ScaleTransition(
                    scale: CurvedAnimation(
                      parent: _controller,
                      curve: Interval(0.0, 1.0 - index / icons.length / 2.0,
                          curve: Curves.easeOut),
                    ),
                    child: ElevatedButton(
                      child: SizedBox(
                        height: 70,
                        width: 200,
                        child: Center(
                          child: Text(
                            icons[index],
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                          ),
                        ),
                      ),
                      //),
                      onPressed: () {
                        if (index == 0) {
                          context.pushNamed(AppRoute.createAnnouncement.name);
                        } else {
                          context.pushNamed(AppRoute.createEvent.name);
                        }
                      },
                    ),
                  ),
                );
                return child;
              }).toList()
                ..add(
                  FloatingActionButton(
                    onPressed: () {
                      setState(() {
                        _pressed = !_pressed;
                      });
                      if (_controller.isDismissed) {
                        _controller.forward();
                      } else {
                        _controller.reverse();
                      }
                    },
                    tooltip: 'Create an event or announcement',
                    shape: const CircleBorder(side: BorderSide(width: 1.0)),
                    elevation: 2.0,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 1),
                          colors: <Color>[
                            Color.fromARGB(255, 91, 78, 119),
                            Color.fromARGB(255, 211, 195, 232)
                          ],
                          tileMode: TileMode.mirror,
                        ),
                      ),
                      child: Icon(
                        _pressed == true
                            ? Icons.keyboard_arrow_up_sharp
                            : Icons.add,
                        color: Colors.white,
                        size: 54,
                      ),
                    ),
                  ),
                ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      /*appBar: AppBar(
        title: const Text(
          'Event History',
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
      ),*/
      body: tapped
          ? _widgetOptions.elementAt(_selectedIndex)
          : const EventHistoryScreenTab(),
      /*Container(
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
                    (events.elementAt(index).date.isBefore(DateTime.now())
                        ? EventCard(event: events.elementAt(index))
                        : const SizedBox(
                            height: 0,
                          )),
              ), // only show an event in the history page if its date has passed
            )
          ],
        ),
      ),*/
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
              title: const Text('Calendar'),
              onTap: () {
                context.pushNamed(AppRoute.calendar.name);
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
              title: const Text('Announcements'),
              onTap: () {
                context.pushNamed(AppRoute.updates.name);
              },
            ),
            isOrg
                ? ListTile(
                    title: const Text('Feedback'),
                    onTap: () {
                      context.pushNamed(AppRoute.feedbacklist.name);
                    },
                  )
                : ListTile(
                    title: const Text('QR Scan'),
                    onTap: () {
                      context.pushNamed(AppRoute.qrScanner.name);
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black, width: 2.0))),
        child: BottomNavigationBar(
          items: [
            isOrg
                ? const BottomNavigationBarItem(
                    icon: Icon(Icons.edit_calendar_sharp), label: "Events")
                : BottomNavigationBarItem(
                    icon: Icon(Icons.search), label: "Explore"),
            isOrg
                ? const BottomNavigationBarItem(
                    icon: Icon(Icons.campaign), label: "Announcements")
                : const BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home"),
            isOrg
                ? const BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined), label: "Home")
                : BottomNavigationBarItem(
                    icon: Icon(Icons.camera_alt_outlined), label: "QR Scan"),
            if (isOrg)
              const BottomNavigationBarItem(
                  icon: Icon(Icons.reviews), label: "Feedback"),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromARGB(255, 29, 16, 57),
          unselectedItemColor: Colors.black,
          selectedFontSize: 16.0,
          unselectedFontSize: 14.0,
          onTap: _onItemTapped,
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
                    hintText: 'Search Event History',
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

    final difference = event.endTime.difference(event.startTime).inHours;

    return SingleChildScrollView(
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
                onTap: () => context.pushNamed("historydetail", extra: event),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image(
                            image: AssetImage(event.profilePicPath),
                            height: 75)),
                    title: Text(
                      event.name,
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
                          event.sponsoringOrganization,
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
            )),
      ),
    );
  }
}

class EventHistoryScreenTab extends ConsumerWidget {
  const EventHistoryScreenTab({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Event History',
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
                    (events.elementAt(index).startTime.isBefore(DateTime.now())
                        ? EventCard(event: events.elementAt(index))
                        : const SizedBox(
                            height: 0,
                          )),
              ), // only show an event in the history page if its date has passed
            )
          ],
        ),
      ),
    );
  }
}
