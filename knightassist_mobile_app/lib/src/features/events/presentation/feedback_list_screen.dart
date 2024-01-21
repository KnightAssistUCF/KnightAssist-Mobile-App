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

class _FeedbackListScreenState extends State<FeedbackListScreen> {
  int _selectedIndex = 0;
  bool tapped = false;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    EventListScreen(),
    HomeScreenTab(),
    QRCodeScanner(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      tapped = true; // can't return to update screen from navbar
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
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
            ListTile(
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
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined), label: "QR Scan"),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 91, 78, 119),
        onTap: _onItemTapped,
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
