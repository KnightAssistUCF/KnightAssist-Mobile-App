import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

import '../domain/organization.dart';

List<Organization> organizations = [
  Organization(
      id: '',
      name: 'Test Org',
      email: '',
      description:
          'qwgejnqg qwgepoijqrglpk qgroiqrglpiqgr qgoqrglp qrgipoqrgpijgq',
      logoUrl: 'assets/example.png',
      category: [],
      followers: [],
      favorites: [],
      updates: [],
      calendarLink: '',
      isActive: false,
      eventHappeningNow: false,
      backgroundUrl: '',
      events: [],
      semesters: [],
      recoveryToken: '',
      confirmToken: '',
      emailToken: '',
      emailValidated: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
      updatedAt: DateTime.now()),
  Organization(
      id: '',
      name: 'Random Organization X',
      email: '',
      description: 'environment',
      logoUrl: 'assets/profile pictures/icon_leaf.png',
      category: [],
      followers: [],
      favorites: [],
      updates: [],
      calendarLink: '',
      isActive: false,
      eventHappeningNow: false,
      backgroundUrl: '',
      events: [],
      semesters: [],
      recoveryToken: '',
      confirmToken: '',
      emailToken: '',
      emailValidated: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
      updatedAt: DateTime.now()),
  Organization(
      id: '',
      name: 'Test test test test test',
      email: '',
      description: 'vidya gaming',
      logoUrl: 'assets/profile pictures/icon_controller.png',
      category: [],
      followers: [],
      favorites: [],
      updates: [],
      calendarLink: '',
      isActive: false,
      eventHappeningNow: false,
      backgroundUrl: '',
      events: [],
      semesters: [],
      recoveryToken: '',
      confirmToken: '',
      emailToken: '',
      emailValidated: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
      updatedAt: DateTime.now()),
  Organization(
      id: '',
      name: 'Example test',
      email: '',
      description: 'weightlifting jim',
      logoUrl: 'assets/profile pictures/icon_weight.png',
      category: [],
      followers: [],
      favorites: [],
      updates: [],
      calendarLink: '',
      isActive: false,
      eventHappeningNow: false,
      backgroundUrl: '',
      events: [],
      semesters: [],
      recoveryToken: '',
      confirmToken: '',
      emailToken: '',
      emailValidated: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
      updatedAt: DateTime.now())
];

class OrganizationsListScreen extends ConsumerWidget {
  const OrganizationsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Organizations List',
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
                itemCount: organizations.length,
                itemBuilder: (context, index) => OrganizationCard(
                    organization: organizations.elementAt(index)),
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
                  child: SearchBar(
                    hintText: 'Search Organizations',
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}

class OrganizationCard extends StatefulWidget {
  final Organization organization;

  const OrganizationCard({super.key, required this.organization});

  @override
  _OrganizationCardState createState() =>
      _OrganizationCardState(organization: organization);
}

class _OrganizationCardState extends State<OrganizationCard> {
  bool _isFavoriteOrg = false;
  final Organization organization;

  _OrganizationCardState({required this.organization});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    final Organization organization = this.organization;
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
                onTap: () => context.pushNamed("organization",
                    pathParameters: {'id': organization.id}),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Wrap(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image(
                                  image: AssetImage(organization.logoUrl),
                                  height: 100)),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  organization.name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                  textAlign: TextAlign.justify,
                                ),
                                Text(
                                  organization.description,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
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
                                  alignment: const Alignment(1, 0.6),
                                  child: IconButton(
                                      iconSize: 30.0,
                                      padding: const EdgeInsets.only(
                                          left: 4, right: 4, top: 0),
                                      icon: _isFavoriteOrg == true
                                          ? const Icon(Icons.favorite)
                                          : const Icon(Icons.favorite_outline),
                                      color: Colors.pink,
                                      onPressed: () {
                                        setState(() {
                                          _isFavoriteOrg = !_isFavoriteOrg;
                                        });
                                      }))
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
