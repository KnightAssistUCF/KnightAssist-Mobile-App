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
import 'package:knightassist_mobile_app/src/features/organizations/domain/contact.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/socialMedia.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart'
    as prefix;
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:intl/intl.dart';

/*List<Organization> organizations = [
  Organization(
      id: '1',
      name: 'Test Org',
      email: '',
      description:
          'qwgejnqg qwgepoijqrglpk qgroiqrglpiqgr qgoqrglp qrgipoqrgpijgq',
      logoUrl: 'assets/example.png',
      contact: const Contact(
          email: '',
          phone: '',
          website: '',
          socialMedia: SocialMedia(
              facebook: '', twitter: '', instagram: '', linkedIn: '')),
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
      id: '2',
      name: 'Random Organization X',
      email: '',
      description: 'environment',
      contact: const Contact(
          email: '',
          phone: '',
          website: '',
          socialMedia: SocialMedia(
              facebook: '', twitter: '', instagram: '', linkedIn: '')),
      logoUrl: 'assets/profile pictures/icon_leaf.png',
      category: [],
      followers: [],
      favorites: [],
      updates: [
        Update(
            id: '1',
            title: 'This is an announcement',
            content:
                'Announcement description will be here! Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem Announcement description will be here! Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem Announcement description will be here! Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem',
            date: DateTime.fromMillisecondsSinceEpoch(1702941527000),
            sponsor: Organization(
                id: '1',
                name:
                    'Test Org long name long name long name long name long name long name long name long name long name long name long name long name long name long nameeeeeeeee',
                email: '',
                description:
                    'qwgejnqg qwgepoijqrglpk qgroiqrglpiqgr qgoqrglp qrgipoqrgpijgq',
                contact: const Contact(
                    email: '',
                    phone: '',
                    website: '',
                    socialMedia: SocialMedia(
                        facebook: '',
                        twitter: '',
                        instagram: '',
                        linkedIn: '')),
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
                location: '',
                semesters: [],
                recoveryToken: '',
                confirmToken: '',
                emailToken: '',
                emailValidated: false,
                createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
                updatedAt: DateTime.now()),
            createdAt: DateTime.fromMillisecondsSinceEpoch(1702941527000),
            updatedAt: DateTime.now()),
        Update(
            id: '1',
            title: 'Announcement test',
            content: 'm dolor Lorem',
            date: DateTime.fromMillisecondsSinceEpoch(1702941527000),
            sponsor: Organization(
                id: '1',
                name: 'Test Org',
                email: '',
                description:
                    'qwgejnqg qwgepoijqrglpk qgroiqrglpiqgr qgoqrglp qrgipoqrgpijgq',
                contact: const Contact(
                    email: '',
                    phone: '',
                    website: '',
                    socialMedia: SocialMedia(
                        facebook: '',
                        twitter: '',
                        instagram: '',
                        linkedIn: '')),
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
                location: '',
                semesters: [],
                recoveryToken: '',
                confirmToken: '',
                emailToken: '',
                emailValidated: false,
                createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
                updatedAt: DateTime.now()),
            createdAt: DateTime.fromMillisecondsSinceEpoch(1702941527000),
            updatedAt: DateTime.now())
      ],
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
      updatedAt: DateTime.now(),
      location: ''),
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
      updates: [
        Update(
            id: '3',
            title: 'test',
            content: 'testing announcements',
            date: DateTime.fromMillisecondsSinceEpoch(1702941527000),
            sponsor: Organization(
                id: '1',
                name: 'Organization XYZ',
                email: '',
                description:
                    'qwgejnqg qwgepoijqrglpk qgroiqrglpiqgr qgoqrglp qrgipoqrgpijgq',
                contact: const Contact(
                    email: '',
                    phone: '',
                    website: '',
                    socialMedia: SocialMedia(
                        facebook: '',
                        twitter: '',
                        instagram: '',
                        linkedIn: '')),
                logoUrl: 'assets/profile pictures/icon_soccer.png',
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
            createdAt: DateTime.fromMillisecondsSinceEpoch(1702941527000),
            updatedAt: DateTime.now())
      ],
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
      updatedAt: DateTime.now())
];*/

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen>
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
    _controller = new AnimationController(
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
      /*appBar: AppBar(
        title: const Text(
          'Announcements',
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
      body:
          tapped ? _widgetOptions.elementAt(_selectedIndex) : UpdateScreenTab(),
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
                itemBuilder: (context, index) {
                  int i = index;
                  if (organizations.elementAt(index).updates.isEmpty) {
                      return const SizedBox(height: 0,);
                  } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: organizations[i].updates.length,
                        itemBuilder: (context, index) {
                        return UpdateCard(update: organizations[i].updates.elementAt(index), sponsor: organizations[i].updates.elementAt(index).sponsor);
                      });
                  }
                }
              ),
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
                    hintText: 'Search Announcements',
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}

class UpdateCard extends StatelessWidget {
  final Update update;
  final Organization sponsor;

  const UpdateCard({super.key, required this.update, required this.sponsor});

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
                onTap: () => context.pushNamed("updatedetail", extra: update),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              dense: true,
                              visualDensity: VisualDensity.standard,
                              title: Text(
                                update.title,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                                textAlign: TextAlign.start,
                              ),
                              /*subtitle: Wrap(children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: Image(
                                        image:
                                            AssetImage(update.sponsor.logoUrl),
                                        height: 25)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    sponsor.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ]),*/
                              trailing: Text(
                                DateFormat('yyyy-MM-dd').format(update.date),
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Text(
                              update.content,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              style:
                                  const TextStyle(fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
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

class UpdateScreenTab extends ConsumerWidget {
  const UpdateScreenTab({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Announcements',
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
            //Flexible(
            /*child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: organizations.length,
                  itemBuilder: (context, index) {
                    int i = index;
                    if (organizations.elementAt(index).updates.isEmpty) {
                      return const SizedBox(
                        height: 0,
                      );
                    } else {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: organizations[i].updates.length,
                          itemBuilder: (context, index) {
                            return UpdateCard(
                                update:
                                    organizations[i].updates.elementAt(index),
                                sponsor: organizations[i]
                                    .updates
                                    .elementAt(index)
                                    .sponsor);
                          });
                    }
                  }),*/
            //)
          ],
        ),
      ),
    );
  }
}
