import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/images/data/images_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/organizations_list/organizations_list.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/organizations_list/organizations_search_text_field.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

/*
DATA NEEDED:
- the list of all organizations
- the current user's profile image
*/

class OrganizationsListScreen extends ConsumerStatefulWidget {
  const OrganizationsListScreen({super.key});

  @override
  ConsumerState<OrganizationsListScreen> createState() =>
      _OrganizationsListScreenState();
}

class _OrganizationsListScreenState
    extends ConsumerState<OrganizationsListScreen> {
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
        final imagesRepository = ref.watch(imagesRepositoryProvider);
        final authRepository = ref.watch(authRepositoryProvider);
        final organizationsRepository =
            ref.watch(organizationsRepositoryProvider);
        final studentsRepository = ref.watch(studentsRepositoryProvider);
        final user = authRepository.currentUser;
        bool isOrg = user?.role == "organization";
        bool isStudent = user?.role == "student";
        Organization? org;
        StudentUser? student;

        if (isOrg) {
          org = organizationsRepository.getOrganization(user!.id);
        }

        if (isStudent) {
          studentsRepository.fetchStudent(user!.id);
          student = studentsRepository.getStudent();
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
          body: CustomScrollView(
            controller: _scrollController,
            slivers: const [
              ResponsiveSliverCenter(
                padding: EdgeInsets.all(Sizes.p16),
                child: OrganizationsSearchTextField(),
              ),
              ResponsiveSliverCenter(
                padding: EdgeInsets.all(Sizes.p16),
                child: OrganizationsList(),
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
