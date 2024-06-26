import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/data/events_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/events_list.dart';
import 'package:knightassist_mobile_app/src/features/events/presentation/events_list/events_search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/images/data/images_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

/*
DATA NEEDED:
- the full list of all events
- the current user's profile image
*/

class EventsListScreen extends ConsumerStatefulWidget {
  const EventsListScreen({super.key, this.organizationID});
  final String? organizationID;

  @override
  ConsumerState<EventsListScreen> createState() => _EventsListScreenState();
}

class _EventsListScreenState extends ConsumerState<EventsListScreen> {
  // * Use a [ScrollController] to register a listener that dismisses the
  // * on-screen keyboard when the user scrolls.
  // * This is needed because this page has a search field that the user can
  // * type into.
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_dismissOnScreenKeyboard);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_dismissOnScreenKeyboard);
    super.dispose();
  }

  void _dismissOnScreenKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final authRepository = ref.watch(authRepositoryProvider);
        final organizationsRepository =
            ref.watch(organizationsRepositoryProvider);
        final imagesRepository = ref.watch(imagesRepositoryProvider);
        final eventsRepository = ref.watch(eventsRepositoryProvider);

        final studentsRepository = ref.watch(studentsRepositoryProvider);
        final user = authRepository.currentUser;
        bool isOrg = user?.role == "organization";
        bool isStudent = user?.role == "student";
        Organization? org;
        StudentUser? student;

        dynamic fetchData() async {
          await eventsRepository.fetchEventsList();
          if (isOrg) {
            org = organizationsRepository.getOrganization(user!.id);
          }

          if (isStudent) {
            await studentsRepository.fetchStudent(user!.id);
            student = studentsRepository.getStudent();
          }
          return 'Success';
        }

        Widget getAppbarProfileImage() {
          return FutureBuilder(
              future: isOrg
                  ? imagesRepository.retrieveImage('2', org!.id)
                  : imagesRepository.retrieveImage('3', user!.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  print('Appbar Profile Image FB done');
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error} occurred',
                        style: const TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final String imageUrl = snapshot.data!;
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image(
                          semanticLabel: 'Profile picture',
                          image: NetworkImage(imageUrl),
                          height: 20),
                    );
                  }
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              });
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Volunteer Shifts',
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
              FutureBuilder(
                future: fetchData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${snapshot.error} occurred',
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            if (isOrg) {
                              context.pushNamed("organization", extra: org);
                            } else if (isStudent) {
                              context.pushNamed("profileScreen",
                                  extra: student);
                            } else {
                              context.pushNamed(AppRoute.signIn.name);
                            }
                          },
                          child: Tooltip(
                            message: 'Go to your profile',
                            child: getAppbarProfileImage(),
                          ),
                        ),
                      );
                    }
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )
            ],
          ),
          body: CustomScrollView(
            controller: _scrollController,
            slivers: const [
              ResponsiveSliverCenter(
                padding: EdgeInsets.all(Sizes.p16),
                child: EventsSearchTextField(),
              ),
              ResponsiveSliverCenter(
                padding: EdgeInsets.all(Sizes.p16),
                child: EventsList(),
              ),
            ],
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
      },
    );
  }
}
