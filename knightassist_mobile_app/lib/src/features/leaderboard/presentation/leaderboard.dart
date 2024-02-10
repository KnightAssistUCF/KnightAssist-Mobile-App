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
import 'package:knightassist_mobile_app/src/features/leaderboard/data/leaderboard_repository.dart';
import 'package:knightassist_mobile_app/src/features/leaderboard/domain/leaderboard_entry.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/update_screen.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:intl/intl.dart';

List<LeaderboardEntry> leaders = [];

class leaderboard extends StatefulWidget {
  const leaderboard({
    super.key,
  });

  @override
  State<leaderboard> createState() => _leaderboardState();
}

class _leaderboardState extends State<leaderboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Consumer(
      builder: (context, ref, child) {
        final leaderboardRepository = ref.watch(leaderboardRepositoryProvider);
        leaderboardRepository.fetchLeaderboard().then((value) => setState(() {
              leaders = value;
            }));
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Volunteer Leaderboard',
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
                const Flexible(
                  child: Board(),
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
  );
}

class VolunteerCard extends StatelessWidget {
  final LeaderboardEntry volunteer;
  final int number;

  const VolunteerCard(
      {super.key, required this.volunteer, required this.number});

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
              color: Colors.white,
              elevation: 5,
              child: InkWell(
                onTap: () {},
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
                      '${volunteer.firstName} ${volunteer.lastName}',
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
                          "${volunteer.totalVolunteerHours} hours",
                          style: const TextStyle(fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    trailing: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60.0),
                          color: Colors.white,
                          border: Border.all()),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          number.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                      ),
                    ), // space to include org name
                  ),
                ),
              ),
            )),
      ),
    );
  }
}

class Board extends StatefulWidget {
  const Board({
    super.key,
  });

  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<LeaderboardEntry> _getLeaderBoard() {
    List<LeaderboardEntry> leaderlist = [];
    for (LeaderboardEntry s in leaders) {
      leaderlist.add(s);
    }
    return leaderlist;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final leaderboardRepository = ref.watch(leaderboardRepositoryProvider);
        return Scaffold(
          body: Container(
            child: FutureBuilder<List<LeaderboardEntry>>(
              future: leaderboardRepository.fetchLeaderboard(),
              builder:
                  (context, AsyncSnapshot<List<LeaderboardEntry>> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  //print(snapshot.data);
                  children = [
                    snapshot.data!.isEmpty
                        ? const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "There are no volunteers to display on the leaderboard.",
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
                                      volunteer:
                                          snapshot.data!.elementAt(index),
                                      number: index + 1,
                                    ));
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
                        'There are no volunteers to display on the leaderboard.',
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
              },
            ),
          ),
        );
      },
    );
  }
}
