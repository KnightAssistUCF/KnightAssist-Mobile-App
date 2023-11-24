import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
         title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: true,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              onPressed: () { }, tooltip: 'View notifications', icon: const Icon(Icons.notifications_outlined,
              color: Colors.white, semanticLabel: 'Notifications',),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap:  () {
                context.pushNamed(AppRoute.profileScreen.name);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: const Image(
                    image:
                        AssetImage('assets/profile pictures/icon_paintbrush.png'),
                    height: 20),
              ),
            ),
          )
        ],
      ),
      body: SizedBox(
        height: h,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: const Image(
                        image:
                            AssetImage('assets/profile pictures/icon_paintbrush.png'),
                        height: 100),
              ),
            ),
            const ResponsiveScrollableCard(child: Text('Name'))
          ],
        )
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