import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

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
                  EventCard(),
                  EventCard(),
                  EventCard(),
                ],
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
  const EventCard({super.key});

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
                          padding: EdgeInsets.all(15.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const Text(
                                'Event Title',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                                textAlign: TextAlign.justify,
                              ),
                              const Text(
                                'Time/Date',
                                style: TextStyle(fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                              const Text(
                                'Location',
                                style: TextStyle(fontWeight: FontWeight.w400),
                                textAlign: TextAlign.justify,
                              ),
                              OverflowBar(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: const Image(
                                          image:
                                              AssetImage('assets/example.png'),
                                          height: 20)),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Hosting Organization',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400),
                                      textAlign: TextAlign.justify,
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
                                    backgroundColor: MaterialStateProperty.all(
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
            )),
      ),
    );
  }
}
