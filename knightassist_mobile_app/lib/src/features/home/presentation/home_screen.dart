import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_scrollable_card.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/announcements/data/announcements_repository.dart';
import 'package:knightassist_mobile_app/src/features/announcements/domain/announcement.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/feedback_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/qr_scanner.dart';
import 'package:knightassist_mobile_app/src/features/images/data/images_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/update_screen.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:percent_indicator/percent_indicator.dart';

List<Event> events = [];
List<Announcement> announcements = [];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, required});

  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with TickerProviderStateMixin {
  int _selectedIndex = isOrg ? 2 : 1;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static final List<Widget> _widgetOptions = isOrg
      ? <Widget>[
          const EventsListScreen(),
          const UpdateScreenTab(),
          const HomeScreenTab(),
          const FeedbackListScreenTab(),
        ]
      : <Widget>[
          const EventsListScreen(),
          const HomeScreenTab(),
          QRCodeScanner(),
        ];

  late AnimationController _controller;
  bool _pressed = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  static const List<String> icons = ["Create Announcement", "Create Event"];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Consumer(
      builder: (context, ref, child) {
        final authRepository = ref.watch(authRepositoryProvider);
        final user = authRepository.currentUser;
        bool isOrg = user?.role == "organization";
        final organizationsRepository =
            ref.watch(organizationsRepositoryProvider);
        final studentRepository = ref.watch(studentsRepositoryProvider);
        final eventsRepository = ref.watch(eventsRepositoryProvider);
        final announcementsRepository = ref.watch(announcementsRepositoryProvider);
        organizationsRepository.fetchOrganizationsList();
        if (user?.role == 'student') {
          studentRepository.fetchStudent(user!.id);
        }
        if (isOrg) {
          eventsRepository
              .fetchEventsByOrg(user!.id)
              .then((value) => setState(() {
                    value.sort((a, b) => a.startTime.compareTo(b.startTime),);
                    events.add(value.elementAt(value.length-1));
                    events.add(value.elementAt(value.length-2));
                  }));
   
        } else {
          eventsRepository
              .fetchEventsByStudent(user!.id)
              .then((value) => setState(() {
                      value.sort((a, b) => a.startTime.compareTo(b.startTime),);
                    events.add(value.elementAt(value.length-1));
                    events.add(value.elementAt(value.length-2));
                  }));
        }

// TODO: load an org's announcements for org and fav org announcements for students (requires non null user to get org name)
         announcementsRepository.fetchOrgAnnouncements('My Organization!',
      '657e15abf893392ca98665d1').then((value) => setState(() {
        value.sort((a,b) => a.date.compareTo(b.date),);
        announcements.add(value.elementAt(value.length-1));
        announcements.add(value.elementAt(value.length-2));
      }));

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
                              context
                                  .pushNamed(AppRoute.createAnnouncement.name);
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
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          /*appBar: AppBar(
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
          body: _widgetOptions.elementAt(_selectedIndex),
          /*Container(
        height: h,
        child: Column(
          children: [
            _topSection(w, isOrg),
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
                          onPressed: () {
                            context.pushNamed(AppRoute.updates.name);
                          },
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
      ),*/
          bottomNavigationBar: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                border:
                    Border(top: BorderSide(color: Colors.black, width: 2.0))),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              items: [
                isOrg
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.edit_calendar_sharp), label: "Events")
                    : BottomNavigationBarItem(
                        icon: Icon(Icons.search), label: "Explore"),
                isOrg
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.campaign), label: "Updates")
                    : const BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: "Home"),
                isOrg
                    ? const BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: "Home")
                    : BottomNavigationBarItem(
                        icon: Icon(Icons.camera_alt_outlined),
                        label: "QR Scan"),
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
      },
    );
  }
}

_topSection(double width, bool isOrg, Organization? org, StudentUser? student) {
  return Builder(builder: (context) {
    return Stack(children: [
      Container(
          color: const Color.fromARGB(255, 0, 108, 81),
          width: width,
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            isOrg
                                ? "Welcome, ${org?.name}"
                                : "Welcome, ${student?.firstName} ${student?.lastName}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                fontSize: 25),
                          ),
                          Text(
                            DateFormat.y().format(DateTime.now()),
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
            //child: ListView(scrollDirection: Axis.horizontal, children: [
           //for (var event in events) EventCard(event: event)
            //]),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              //Directionality(
              //textDirection: TextDirection.rtl,
              /*child: TextButton.icon(
                onPressed: () {
                  context.pushNamed(AppRoute.events.name);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                  size: 15,
                ),
                label: const Text('View All', style: TextStyle(fontSize: 10)),
              ),*/
              //),
              TextButton(
                  onPressed: () {
                    context.pushNamed(AppRoute.calendar.name);
                  },
                  child: Row(
                    children: [
                      const Text('View All', style: TextStyle(fontSize: 10)),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ],
                  ))
            ],
          ),
        ],
      ),
    ]);
  });
}

class AnnouncementCard extends StatelessWidget {
  final Announcement announcement;
  const AnnouncementCard({super.key, required this.announcement});

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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Wrap(
                children: [
                  const Icon(
                    Icons.close,
                    color: Colors.grey,
                    size: 15,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    DateFormat.yMEd().format(announcement.date),
                    style: const TextStyle(fontSize: 16),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    announcement.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.justify,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(width: 20),
                  Text(
                    announcement.content,
                    style: const TextStyle(fontStyle: FontStyle.italic),
                    textAlign: TextAlign.justify,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Row(
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

class EventCard extends ConsumerWidget {
  final Event event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imagesRepository = ref.watch(imagesRepositoryProvider);

  Widget getImage(Event event) {
          return FutureBuilder(
              future: imagesRepository.retrieveImage('1', event.id),
              builder: (context, snapshot) {
                final String imageUrl = snapshot.data ?? 'No initial data';
                final String state = snapshot.connectionState.toString();
                return ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image(
                        image: NetworkImage(imageUrl), height: 50, width: 50, fit: BoxFit.cover,));
              });
        }

    return Center(
      child: InkWell(
        onTap: () => context.pushNamed("event", extra: event),
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
                  getImage(event),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            event.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 18),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                           DateFormat.yMMMMEEEEd().format(event.startTime),
                            style: const TextStyle(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            event.location,
                            style: const TextStyle(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          /*Text(
                            event.sponsoringOrganization,
                            style: const TextStyle(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.start,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreenTab extends ConsumerWidget {
  const HomeScreenTab({super.key});

  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    final authRepository = ref.watch(authRepositoryProvider);
    final organizationsRepository = ref.watch(organizationsRepositoryProvider);
    organizationsRepository.fetchOrganizationsList();
    final studentsRepository = ref.watch(studentsRepositoryProvider);
    final user = authRepository.currentUser;
    final imagesRepository = ref.watch(imagesRepositoryProvider);
    bool isOrg = user?.role == "organization";
    bool isStudent = user?.role == "student";
    Organization? org;
    StudentUser? student;

    if (isOrg) {
      org = organizationsRepository.getOrganization(user!.id);
    }

    if (isStudent) {
      studentsRepository.fetchStudent(user!.id);
      //print("isStudent");
      student = studentsRepository.getStudent();
    }

    Widget getAppbarProfileImage() {
      return FutureBuilder(
          future: isOrg
              ? imagesRepository.retrieveImage('2', user!.id)
              : imagesRepository.retrieveImage('3', user!.id),
          builder: (context, snapshot) {
            final String imageUrl = snapshot.data ?? 'No initial data';
            final String state = snapshot.connectionState.toString();
            return ClipRRect(
              borderRadius: BorderRadius.circular(25.0),
              child: Image(
                  semanticLabel: 'Profile picture',
                  image: NetworkImage(imageUrl),
                  height: 20),
            );
          });
    }

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
                if (isOrg) {
                  context.pushNamed("organization", extra: org);
                } else if (isStudent) {
                  context.pushNamed("profileScreen", extra: student);
                } else {
                  context.pushNamed(AppRoute.signIn.name);
                }
              },
              child: Tooltip(
                message: 'Go to your profile',
                child: getAppbarProfileImage(),
              ),
            ),
          )
        ],
      ),
      body: Container(
        height: h,
        child: Column(
          children: [
            _topSection(w, isOrg, org, student),
            Flexible(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isOrg
                        ? const SizedBox(
                            height: 0,
                          )
                        : const Text(
                            'Announcements',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                  ),
                  isOrg
                      ? Center(
                          child: OverflowBar(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: SizedBox(
                                    width: (w / 2) - 30,
                                    height: 100,
                                    child: InkWell(
                                      onTap: () => context.pushNamed(
                                          AppRoute.createAnnouncement.name),
                                      child: const Center(
                                        child: Column(children: [
                                          Icon(Icons.campaign),
                                          Text(
                                            "Create Announcement",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          )
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  child: SizedBox(
                                    width: (w / 2) - 30,
                                    height: 100,
                                    child: InkWell(
                                      onTap: () => context
                                          .pushNamed(AppRoute.createEvent.name),
                                      child: const Center(
                                        child: Column(children: [
                                          Icon(Icons.event),
                                          Text(
                                            "Create Event",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                            textAlign: TextAlign.center,
                                          )
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      : ListView(scrollDirection: Axis.vertical, children: [
           for (var announcement in announcements) AnnouncementCard(announcement: announcement)
            ]),
                  isOrg
                      ? const SizedBox(height: 0)
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            //Directionality(
                            //textDirection: TextDirection.rtl,
                            /*child:*/ TextButton(
                                onPressed: () {
                                  context.pushNamed(AppRoute.updates.name);
                                },
                                child: const Row(
                                  children: [
                                    Text('View All',
                                        style: TextStyle(fontSize: 10)),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                      size: 15,
                                    ),
                                  ],
                                ))
                            //),
                          ],
                        ),
                  OverflowBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            isOrg
                                ? Text(
                                    ((student!.totalVolunteerHours / student!.semesterVolunteerHourGoal) / 100).toString(),
                                    style: TextStyle(fontSize: 40),
                                  )
                                : CircularPercentIndicator(
                                    radius: 40.0,
                                    lineWidth: 5.0,
                                    percent: (student!.totalVolunteerHours / student!.semesterVolunteerHourGoal) > 100 ? 1.0 : (student!.totalVolunteerHours / student!.semesterVolunteerHourGoal) / 100,
                                    center: Text(
                                      student!.semesterVolunteerHourGoal.toString(),
                                      style: TextStyle(fontSize: 15),
                                    ),
                                    progressColor:
                                        const Color.fromARGB(255, 91, 78, 119),
                                  ),
                            Text(isOrg
                                ? 'Event Attendance Rate'
                                : 'Semester Goal'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              isOrg
                                  ? organizationsRepository
                                          .getOrganization(user!.id)
                                          ?.eventsArray
                                          .length
                                          .toString() ??
                                      '0'
                                  : '255',
                              style: TextStyle(fontSize: 40),
                            ),
                            Text(
                                isOrg ? 'Upcoming Shifts' : 'Cumulative Hours'),
                          ],
                        ),
                      ),
                      isOrg
                          ? SizedBox(
                              height: 0,
                            )
                          : Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(
                                   student!.totalVolunteerHours.toString(),
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
              title: const Text('Leaderboard'),
              onTap: () {
                context.pushNamed(AppRoute.leaderboard.name);
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
                final authRepository = ref.watch(authRepositoryProvider);
                authRepository.signOut();
                context.pushNamed(AppRoute.emailConfirm.name);
                //Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
