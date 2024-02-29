import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/feedback.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/qr_scanner.dart';
import 'package:knightassist_mobile_app/src/features/home/presentation/home_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/contact.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/socialMedia.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/update_screen.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:intl/intl.dart';

List<EventFeedback> feedbacklist = [
  EventFeedback(
      student: '1',
      event: '1',
      studentName: 'Johnson Doe',
      eventName: 'concert',
      rating: 1,
      feedbackText: 'it was bad',
      wasReadByUser: false,
      timeSubmitted: DateTime.fromMillisecondsSinceEpoch(1704948441000),
      updatedAt: DateTime.now()),
  EventFeedback(
      student: '2',
      event: '2',
      studentName: 'foo',
      eventName: 'study session',
      rating: 2,
      feedbackText:
          'Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum',
      wasReadByUser: true,
      timeSubmitted: DateTime.fromMillisecondsSinceEpoch(1704948441000),
      updatedAt: DateTime.now()),
  EventFeedback(
      student: '3',
      event: '2',
      studentName: 'Test User',
      eventName: 'movie night',
      rating: 3,
      feedbackText: 'idk',
      wasReadByUser: true,
      timeSubmitted: DateTime.fromMillisecondsSinceEpoch(1704948441000),
      updatedAt: DateTime.now()),
  EventFeedback(
      student: '4',
      event: '2',
      studentName: 'Student',
      eventName: 'concert',
      rating: 4,
      feedbackText: 'test',
      wasReadByUser: false,
      timeSubmitted: DateTime.fromMillisecondsSinceEpoch(1704948441000),
      updatedAt: DateTime.now()),
  EventFeedback(
      student: '5',
      event: '3',
      studentName: '',
      eventName: 'study session',
      rating: 5,
      feedbackText: 'epic',
      wasReadByUser: true,
      timeSubmitted: DateTime.fromMillisecondsSinceEpoch(1704948441000),
      updatedAt: DateTime.now())
];

class FeedbackListScreen extends StatefulWidget {
  const FeedbackListScreen({super.key});

  @override
  State<FeedbackListScreen> createState() => _FeedbackListScreenState();
}

class _FeedbackListScreenState extends State<FeedbackListScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  bool tapped = false;
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
      tapped = true; // can't return to update screen from navbar
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
      body: tapped
          ? _widgetOptions.elementAt(_selectedIndex)
          : FeedbackListScreenTab(),
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
                    hintText: 'Search Feedback',
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}

class FeedbackCard extends StatelessWidget {
  final EventFeedback feedback;

  const FeedbackCard({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

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
                onTap: () =>
                    context.pushNamed("feedbackdetail", extra: feedback),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(0.05),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: VisualDensity.standard,
                      leading: ClipRRect(
                          borderRadius: BorderRadius.circular(25.0),
                          child: const Image(
                              image: AssetImage(
                                  'assets/profile pictures/icon_paintbrush.png'),
                              height:
                                  75)), // will be profile picture of student who left the feedback
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feedback.eventName,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            feedback.studentName,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 16),
                            textAlign: TextAlign.start,
                          ),
                          RatingBar.builder(
                            initialRating: feedback.rating,
                            itemSize: 30.0,
                            ignoreGestures: true,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                              feedback.rating = rating;
                            },
                          )
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          feedback.feedbackText,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: const TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      trailing: Text(
                        DateFormat('yyyy-MM-dd').format(feedback.timeSubmitted),
                        style: const TextStyle(fontWeight: FontWeight.w400),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class FeedbackListScreenTab extends ConsumerWidget {
  const FeedbackListScreenTab({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Feedback',
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
            child: Column(children: [
              _topSection(w),
              Flexible(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: feedbacklist.length,
                      itemBuilder: (context, index) {
                        return FeedbackCard(
                          feedback: feedbacklist.elementAt(index),
                        );
                      }))
            ])));
  }
}
