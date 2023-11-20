import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: <Widget>[
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              semanticLabel: 'Notifications',
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: const Image(
                  image:
                      AssetImage('assets/profile pictures/icon_paintbrush.png'),
                  height: 20),
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
                children: const <Widget>[
                  Text('Announcements'),
                  AnnouncementCard(),
                  AnnouncementCard(),
                  Row(
                    children: [
                      Text('View All'),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 15,
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text('Semester Goal'),
                      Text('Cumulative Hours'),
                      Text('Total Points'),
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
                context.pushNamed(AppRoute.homescreen.name);
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
                context.pushNamed(AppRoute.emailConfirmed.name);
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
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Fall 2023',
                        style: TextStyle(color: Colors.white),
                      ),
                      ResponsiveScrollableCard(
                        child: Column(
                          children: [
                            Text('Next Event'),
                            Divider(height: 15),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'View All',
                            style: TextStyle(color: Colors.white),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.grey,
                            size: 15,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
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
            child: const Padding(
              padding: EdgeInsets.all(20.0),
              child: Row(
                children: [
                  OverflowBar(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
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
                            Text(
                              'Announcement Title',
                              style: TextStyle(fontSize: 16),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(width: 20),
                            Text(
                              '"announcement text start..."',
                              style: TextStyle(fontStyle: FontStyle.italic),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                      OverflowBar(
                        spacing: 8,
                        overflowAlignment: OverflowBarAlignment.end,
                        children: [
                          Align(
                              alignment: Alignment(1, 0.6),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.grey,
                                size: 15,
                              ))
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
