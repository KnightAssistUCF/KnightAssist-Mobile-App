import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/qr_scanner.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _widgetOptions = <Widget>[
    EventsListScreen(),
    HomeScreenTab(),
    QRCodeScanner(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
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
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Announcements',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ),
                  const AnnouncementCard(),
                  const AnnouncementCard(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.grey,
                            size: 15,
                          ),
                          label: const Text(
                            'View All',
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            CircularPercentIndicator(
                              radius: 40.0,
                              lineWidth: 5.0,
                              percent: 0.95,
                              center: const Text(
                                "19/20",
                                style: TextStyle(fontSize: 15),
                              ),
                              progressColor:
                                  const Color.fromARGB(255, 91, 78, 119),
                            ),
                            const Text('Semester Goal'),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              '255',
                              style: TextStyle(fontSize: 40),
                            ),
                            Text('Cumulative Hours'),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              '144',
                              style: TextStyle(fontSize: 40),
                            ),
                            Text('Total Points'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
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
  return Builder(builder: (context) {
    return Stack(children: [
      Container(
          color: const Color.fromARGB(255, 0, 108, 81),
          width: width,
          child: const Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            'Welcome, Student User',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 25),
                          ),
                          Text(
                            'Fall 2023',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20),
                          ),
                          SizedBox(
                            height: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )),
      Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          SizedBox(
            height: 175,
            child: ListView(scrollDirection: Axis.horizontal, children: const [
              EventCard(),
              EventCard(),
            ]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Directionality(
                textDirection: TextDirection.rtl,
                child: TextButton.icon(
                  onPressed: () {
                    context.pushNamed(AppRoute.events.name);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                    size: 15,
                  ),
                  label: const Text('View All', style: TextStyle(fontSize: 10)),
                ),
              ),
            ],
          ),
        ],
      ),
    ]);
  });
}

class AnnouncementCard extends StatelessWidget {
  const AnnouncementCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    return ResponsiveCenter(
      maxContentWidth: Breakpoint.tablet,
      child: Padding(
          padding: const EdgeInsets.all(10.0),
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
            child: const Padding(
              padding: EdgeInsets.all(15.0),
              child: Wrap(
                children: [
                  Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 15,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Date',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(width: 5),
                  Text(
                    'Announcement Title',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(width: 20),
                  Text(
                    '"text start..."',
                    style: TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.justify,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: SizedBox(
          height: 150,
          width: 300,
          child: Column(
            children: [
              const Text('Next Event'),
              const Divider(height: 15),
              Wrap(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: const Image(
                          image: AssetImage('assets/example.png'),
                          height: 100)),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Event Title',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'Time/Date',
                          style: TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'Location',
                          style: TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                        Text(
                          'Organization',
                          style: TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
