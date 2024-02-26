import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/common_widgets/tags.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/images/data/images_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/rsvp/presentation/rsvp_widget.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class EventScreen extends ConsumerWidget {
  EventScreen({super.key, required this.event});
  //final String eventID;
  final Event event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    final organizationsRepository = ref.read(organizationsRepositoryProvider);
    organizationsRepository.fetchOrganizationsList();
    final org =
        organizationsRepository.getOrganization(event.sponsoringOrganization);
    final authRepository = ref.read(authRepositoryProvider);
    final imagesRepository = ref.watch(imagesRepositoryProvider);
    final user = authRepository.currentUser;
    final eventsRepository = ref.read(eventsRepositoryProvider);
    final studentsRepository = ref.read(studentsRepositoryProvider);
    bool isStudent = user?.role == "student";

    studentsRepository.fetchEventAttendees(event.id);

    bool curOrg = (user?.id == event.sponsoringOrganization);
    // true if the organization who made the event is viewing it (shows edit button)

    bool isOrg = (user?.role == 'organization');

    Organization? userOrg;
    StudentUser? student;

    if (isOrg) {
      userOrg = organizationsRepository.getOrganization(user!.id);
    }

    if (isStudent) {
      studentsRepository.fetchStudent(user!.id);
      student = studentsRepository.getStudent();
    }

    Widget getImage() {
      return FutureBuilder(
          future: imagesRepository.retrieveImage('2', org!.id),
          builder: (context, snapshot) {
            final String imageUrl = snapshot.data ?? 'No initial data';
            final String state = snapshot.connectionState.toString();
            return ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: Image(image: NetworkImage(imageUrl), height: 50));
          });
    }

      Widget getAppbarProfileImage() {
      return FutureBuilder(
          future: isOrg
              ? imagesRepository.retrieveImage('2', org!.id)
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
        title: const Text(
          'Events',
          //style: TextStyle(fontSize: 30),
        ),
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
                  context.pushNamed("organization", extra: userOrg);
                } else if (isStudent) {
                  context.pushNamed("profileScreen", extra: student);
                } else {
                  context.pushNamed(AppRoute.signIn.name);
                }
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
      body: SizedBox(
        height: h,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: [
            _title(w, event),
            Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () =>
                      context.pushNamed(AppRoute.organization.name, extra: org),
                  child: Wrap(
                    children: [
                      getImage(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          org?.name ?? '',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 25),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      isOrg
                          ? const SizedBox(
                              height: 0,
                            )
                          : const OrganizationFav(),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 250, child: TabBarEvent(event: event)),
            Center(
              child: SizedBox(
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: curOrg
                      ? Padding(
                          // shows edit button for sponsoring org
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: OverflowBar(
                              children: [
                                Center(
                                  child: ElevatedButton(
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Edit Event",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    onPressed: () => context
                                        .pushNamed("editevent", extra: event),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      child: const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "View RSVPs",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                      onPressed: () => context
                                          .pushNamed("viewrsvps", extra: event),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : isOrg
                          ? const SizedBox(
                              height: 0,
                            )
                          : RSVPWidget(event: event),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

_title(double width, Event e) {
  return Builder(builder: (context) {
    return Consumer(
      builder: (context, ref, child) {
        final imagesRepository = ref.watch(imagesRepositoryProvider);

        Widget getImage() {
          return FutureBuilder(
              future: imagesRepository.retrieveImage('1', e.id),
              builder: (context, snapshot) {
                final String imageUrl = snapshot.data ?? 'No initial data';
                final String state = snapshot.connectionState.toString();
                return Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(imageUrl),
                    ),
                  ),
                );
              });
        }

        return Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              getImage(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    e.name,
                    style: const TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ]);
      },
    );
  });
}

class OrganizationFav extends StatefulWidget {
  //final Organization organization;

  const OrganizationFav({super.key});

  @override
  _OrganizationFavState createState() => _OrganizationFavState();
}

class _OrganizationFavState extends State<OrganizationFav> {
  bool _isFavoriteOrg = false;
  //late final Organization organization;

  _OrganizationFavState();

  @override
  void initState() {
    super.initState();
    //organization = widget.organization;
  }

  @override
  Widget build(BuildContext context) {
    //final Organization organization = this.organization;

    return IconButton(
        iconSize: 30.0,
        padding: const EdgeInsets.only(left: 4, right: 4, top: 0),
        icon: _isFavoriteOrg == true
            ? const Icon(Icons.favorite)
            : const Icon(Icons.favorite_outline),
        color: Colors.pink,
        onPressed: () {
          setState(() {
            _isFavoriteOrg = !_isFavoriteOrg;
          });
        });
  }
}

class TabBarEvent extends StatefulWidget {
  final Event event;

  const TabBarEvent({super.key, required this.event});

  @override
  State<TabBarEvent> createState() => _TabBarEventState();
}

class _TabBarEventState extends State<TabBarEvent>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final Event event;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    event = widget.event;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final difference = event.endTime.difference(event.startTime).inHours;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Text("Details")),
                Tab(icon: Text("Description")),
                Tab(icon: Text("Tags")),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(children: [
                          const Icon(Icons.location_on),
                          Text(
                            event.location,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(children: [
                          const Icon(Icons.calendar_month),
                          Text(
                            DateFormat.yMMMMEEEEd().format(event.startTime),
                            style: const TextStyle(fontSize: 20),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: difference >= 24
                            ? Text(
                                //show event end date if the event is longer than a day
                                " ${DateFormat.jmv().format(event.startTime)} - ${DateFormat.jmv().format(event.endTime)} on ${DateFormat.yMMMMEEEEd().format(event.endTime)}",
                                style: const TextStyle(fontSize: 15),
                              )
                            : Text(
                                " ${DateFormat.jmv().format(event.startTime)} - ${DateFormat.jmv().format(event.endTime)}",
                                style: const TextStyle(fontSize: 15),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(children: [
                          const Icon(Icons.person),
                          Text(
                            "${event.attendees.length} / ${event.maxAttendees} spots reserved",
                            style: const TextStyle(fontSize: 20),
                          ),
                        ]),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          event.description,
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: event.eventTags.isEmpty? const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("This event has no tags.", style: TextStyle(fontSize: Sizes.p20),),
                        ) : Wrap(
                        children: [for (var tag in event.eventTags) Tags(tag: tag)]
                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}