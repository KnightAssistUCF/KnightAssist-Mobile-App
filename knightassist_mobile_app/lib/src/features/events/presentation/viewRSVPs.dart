import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/feedback_list_screen.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/qr_scanner.dart';
import 'package:knightassist_mobile_app/src/features/home/presentation/home_screen.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/update_screen.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:intl/intl.dart';

List<StudentUser> rsvps = [];

class viewRSVPsScreen extends StatefulWidget {
  final Event event;

  const viewRSVPsScreen({
    super.key,
    required this.event,
  });

  @override
  State<viewRSVPsScreen> createState() => _viewRSVPsScreenState();
}

class _viewRSVPsScreenState extends State<viewRSVPsScreen> {
  late final Event event;

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Consumer(
      builder: (context, ref, child) {
        final eventsRepository = ref.watch(eventsRepositoryProvider);
        final studentsRepository = ref.watch(studentsRepositoryProvider);

        //print(event.id);
        // print(eventsRepository.getEvent(event.id)?.name);
        //print(studentsRepository.fetchEventAttendees(event.id));

        /*Future rsvpList = eventsRepository.getEventAttendees(event.id);

        rsvpList.then((data) {
          for (StudentUser s in data) {
            rsvps.add(s);
            print(s.firstName);
            print(s.id);
          }
        });*/

        studentsRepository
            .fetchEventAttendees(event.id)
            .then((value) => setState(() {
                  rsvps = value;
                }));

        //print('RSVPS:');
        //for (StudentUser s in rsvps) {
        //print(s.firstName);
        //print(s.lastName);
        //print(s.id);
        //}

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Event RSVPs',
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
              child: Column(children: [
                _topSection(w),
                Flexible(
                  child: /*rsvps.isEmpty
                      ? const Center(
                          child: Text(
                            "There are no volunteers who RSVPed for this event.",
                            style: optionStyle,
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: rsvps.length,
                          itemBuilder: (context, index) => VolunteerCard(
                            event: event,
                            volunteer: rsvps.elementAt(index),
                          ),
                        ),*/
                      RSVPS(event: event),
                ),
              ])),
        );
      },
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
                    hintText: 'Search Event RSVPs',
                  ),
                ),
              ),
            ],
          ),
        ],
      ));
}

class VolunteerCard extends StatelessWidget {
  final Event event;
  final StudentUser volunteer;

  const VolunteerCard(
      {super.key, required this.event, required this.volunteer});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const style = TextStyle(fontSize: 20, fontWeight: FontWeight.normal);

    final difference = event.endTime.difference(event.startTime).inHours;

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
                onTap: () => context.pushNamed("historydetail",
                    extra:
                        event), // TODO : determine if orgs can edit student hours
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image(
                            image: NetworkImage(volunteer.profilePicPath),
                            height: 75)),
                    title: Text(
                      '${volunteer.firstName}${volunteer.lastName}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${difference.toString()} hours",
                          style: const TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    trailing: Text(
                      "RSVPed: ${DateFormat('yyyy-MM-dd').format(event.startTime)}",
                      style: const TextStyle(fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class RSVPS extends StatefulWidget {
  final Event event;

  const RSVPS({
    super.key,
    required this.event,
  });

  @override
  _RSVPSState createState() => _RSVPSState();
}

class _RSVPSState extends State<RSVPS> {
  late final Event event;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    event = widget.event;
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<StudentUser> _getRSVPSForDay() {
    List<StudentUser> RSVPSForDay = [];
    for (StudentUser s in rsvps) {
      RSVPSForDay.add(s);
    }
    return RSVPSForDay;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final studentsRepository = ref.watch(studentsRepositoryProvider);
        return Scaffold(
          body: Container(
            child: FutureBuilder<List<StudentUser>>(
              future: studentsRepository.fetchEventAttendees(event.id),
              builder: (context, AsyncSnapshot<List<StudentUser>> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  //print(snapshot.data);
                  children = [
                    snapshot.data!.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "There are no volunteers who RSVPed for this event.",
                                style: optionStyle,
                              ),
                            ),
                          )
                        : Container(
                            height: 500,
                            child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 12.0,
                                      vertical: 4.0,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: VolunteerCard(
                                        event: event,
                                        volunteer:
                                            snapshot.data!.elementAt(index)));
                              },
                            ),
                          )
                  ];
                } else if (snapshot.hasError) {
                  print(snapshot
                      .error); // when the json response is empty it is read as a map
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 60,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        'There are no volunteers who RSVPed for this event.',
                        style: optionStyle,
                      ),
                    ),
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
                /*return value.length == 0
                    ? const Center(
                        child: Text(
                          "There are no volunteers who RSVPed for this event.",
                          style: optionStyle,
                        ),
                      )
                    : ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: VolunteerCard(
                                  event: event, volunteer: value[index]));
                        },
                      );*/
              },
            ),
          ),
        );
      },
    );
  }
}
