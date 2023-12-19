import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:intl/intl.dart';

List<Organization> organizations = [
  Organization(
      id: '1',
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
      id: '2',
      name: 'Random Organization X',
      email: '',
      description: 'environment',
      logoUrl: 'assets/profile pictures/icon_leaf.png',
      category: [],
      followers: [],
      favorites: [],
      updates: [
        Update(id: '1', title: 'This is an announcement', content: 'Announcement description will be here! Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem Announcement description will be here! Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem Announcement description will be here! Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor s Lorem ipsum dolor Lorem ipsum dolor Lorem ipsum dolor Lorem', date: DateTime.fromMillisecondsSinceEpoch(1702941527000), sponsor: Organization(
      id: '1',
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
      updatedAt: DateTime.now()), createdAt: DateTime.fromMillisecondsSinceEpoch(1702941527000), updatedAt: DateTime.now()),
      Update(id: '1', title: 'Announcement test', content: 'm dolor Lorem', date: DateTime.fromMillisecondsSinceEpoch(1702941527000), sponsor: Organization(
      id: '1',
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
      updatedAt: DateTime.now()), createdAt: DateTime.fromMillisecondsSinceEpoch(1702941527000), updatedAt: DateTime.now())
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
      updatedAt: DateTime.now()),
  Organization(
      id: '3',
      name: 'Test test test test test',
      email: 'testorg@example.com',
      description: 'vidya gaming',
      logoUrl: 'assets/profile pictures/icon_controller.png',
      category: [],
      followers: [],
      favorites: [],
      updates: [Update(id: '3', title: 'test', content: 'testing announcements', date: DateTime.fromMillisecondsSinceEpoch(1702941527000), sponsor: Organization(
      id: '1',
      name: 'Organization XYZ',
      email: '',
      description:
          'qwgejnqg qwgepoijqrglpk qgroiqrglpiqgr qgoqrglp qrgipoqrgpijgq',
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
      semesters: [],
      recoveryToken: '',
      confirmToken: '',
      emailToken: '',
      emailValidated: false,
      createdAt: DateTime.fromMillisecondsSinceEpoch(1701030257000),
      updatedAt: DateTime.now()), createdAt: DateTime.fromMillisecondsSinceEpoch(1702941527000), updatedAt: DateTime.now())],
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
      id: '4',
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

class UpdateScreen extends ConsumerWidget {
  const UpdateScreen({super.key});

  @override
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
              title: const Text('Announcements'),
              onTap: () {
                context.pushNamed(AppRoute.updates.name);
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
                    hintText: 'Search Event History',
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
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              update.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              sponsor.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              DateFormat('yyyy-MM-dd')
                                  .format(update.date),
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400),
                              textAlign: TextAlign.end,
                            ),
                          Text(
                            update.content,
                            style: const TextStyle(
                            fontWeight: FontWeight.w400),
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
