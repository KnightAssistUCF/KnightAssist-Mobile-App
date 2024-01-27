import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/bottombar.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/feedback_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/qr_scanner.dart';
import 'package:knightassist_mobile_app/src/features/home/presentation/home_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/contact.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/socialMedia.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/update_screen.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

import '../domain/organization.dart';

bool isOrg = true;

List<Organization> organizations = [
  Organization(
      id: '1',
      name:
          'Test Org long name long name long name long name long name long name long name long name long name long name long name long name',
      email: '',
      description:
          'qwgejnqg qwgepoijqrglpk qgroiqrglpiqgr qgoqrglp qrgipoqrgpijgq qwegihqweifgopqwei joaJOFab;n joaJOFab;n joaJOFab;n',
      contact: const Contact(
          email: 'organization@email.com',
          phone: '(904) 555-5555',
          website: 'https://org.com',
          socialMedia: SocialMedia(
              facebook: 'https://facebook.com',
              twitter: 'https://x.com',
              instagram: 'https://instagram.com',
              linkedIn: 'https://linkedin.com')),
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
      location: '4000 Central Florida Blvd Orlando, FL',
      semesters: [],
      recoveryToken: '',
      confirmToken: '',
      emailToken: '',
      emailValidated: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
      updatedAt: DateTime.now()),
  Organization(
      id: '2',
      name: 'Random Organization X',
      email: '',
      description: 'environment',
      contact: const Contact(
          email: '',
          phone: '',
          website: '',
          socialMedia: SocialMedia(
              facebook: '',
              twitter: '',
              instagram: '',
              linkedIn: 'linkedin.com')),
      logoUrl: 'assets/profile pictures/icon_leaf.png',
      category: [],
      followers: [],
      favorites: [],
      updates: [],
      calendarLink: '',
      isActive: false,
      eventHappeningNow: false,
      backgroundUrl: 'assets/profile pictures/icon_cookie.png',
      events: [],
      location: '',
      semesters: [],
      recoveryToken: '',
      confirmToken: '',
      emailToken: '',
      emailValidated: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
      updatedAt: DateTime.now()),
  Organization(
      id: '3',
      name: 'Test test test test test',
      email: 'testorg@example.com',
      description: 'vidya gaming',
      contact: const Contact(
          email: '',
          phone: '',
          website: '',
          socialMedia: SocialMedia(
              facebook: '', twitter: '', instagram: '', linkedIn: '')),
      logoUrl: 'assets/profile pictures/icon_controller.png',
      category: [],
      followers: [],
      favorites: [],
      updates: [],
      calendarLink: '',
      isActive: false,
      eventHappeningNow: false,
      backgroundUrl: 'assets/profile pictures/icon_controller.png',
      events: [],
      location: '',
      semesters: [],
      recoveryToken: '',
      confirmToken: '',
      emailToken: '',
      emailValidated: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
      updatedAt: DateTime.now()),
  Organization(
      id: '4',
      name: 'Example test',
      email: '',
      description: 'weightlifting jim',
      contact: const Contact(
          email: '',
          phone: '',
          website: '',
          socialMedia: SocialMedia(
              facebook: '', twitter: '', instagram: '', linkedIn: '')),
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
      location: '',
      semesters: [],
      recoveryToken: '',
      confirmToken: '',
      emailToken: '',
      emailValidated: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
      updatedAt: DateTime.now()),
  Organization(
      id: '5',
      name: 'Test Org',
      email: '',
      description:
          'qwgejnqg qwgepoijqrglpk qgroiqrglpiqgr qgoqrglp qrgipoqrgpijgq qwegihqweifgopqwei joaJOFab;n joaJOFab;n joaJOFab;n',
      contact: const Contact(
          email: 'organization@email.com',
          phone: '(904) 555-5555',
          website: 'https://org.com',
          socialMedia: SocialMedia(
              facebook: 'https://facebook.com',
              twitter: 'https://x.com',
              instagram: 'https://instagram.com',
              linkedIn: 'https://linkedin.com')),
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
      location: '4000 Central Florida Blvd Orlando, FL',
      semesters: [],
      recoveryToken: '',
      confirmToken: '',
      emailToken: '',
      emailValidated: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
      updatedAt: DateTime.now()),
];

class OrganizationsListScreen extends StatefulWidget {
  const OrganizationsListScreen({super.key});

  @override
  State<OrganizationsListScreen> createState() =>
      _OrganizationsListScreenState();
}

class _OrganizationsListScreenState extends State<OrganizationsListScreen>
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

  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      tapped = true; // can't return to org list screen from navbar
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
                          context.pushNamed(AppRoute.createUpdate.name);
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
      ),*/
      body: tapped
          ? _widgetOptions.elementAt(_selectedIndex)
          : OrganizationsListScreenTab(),
      /*Container(
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
      ),*/
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
  _OrganizationCardState createState() => _OrganizationCardState();
}

class _OrganizationCardState extends State<OrganizationCard> {
  bool _isFavoriteOrg = false;
  late final Organization organization;

  _OrganizationCardState();

  @override
  void initState() {
    super.initState();
    organization = widget.organization;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    bool isOrg = true;

    final Organization organization = this.organization;
    return SingleChildScrollView(
      child: ResponsiveCenter(
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
              child: InkWell(
                onTap: () =>
                    context.pushNamed("organization", extra: organization),
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Stack(children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 100,
                              child: ClipRRect(
                                borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(20.0),
                                    right: Radius.circular(20.0)),
                                child: Image(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                      organization.backgroundUrl == ''
                                          ? 'assets/orgdefaultbackground.png'
                                          : organization.backgroundUrl),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 25,
                              child: Container(
                                height: 75,
                                width: 75,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 5, color: Colors.white),
                                  borderRadius: BorderRadius.circular(16.0),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image(
                                    image: AssetImage(organization.logoUrl),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                          ListTile(
                            /*leading: ClipRRect(
                                borderRadius: BorderRadius.circular(12.0),
                                child: Image(
                                    image: AssetImage(organization.logoUrl),
                                    height: 300)),*/
                            title: Text(
                              organization.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                              textAlign: TextAlign.start,
                            ),
                            subtitle: Text(
                              organization.description,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                            ),
                            trailing: isOrg
                                ? SizedBox(
                                    height: 0,
                                  )
                                : IconButton(
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
                                    }),
                          ),
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

class OrganizationsListScreenTab extends ConsumerWidget {
  const OrganizationsListScreenTab({super.key});

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
        ));
  }
}
