import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/organizations_list/organizations_card.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/organizations_list/organizations_list.dart';
import 'package:knightassist_mobile_app/src/features/organizations/presentation/organizations_list/organizations_search_text_field.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class FavoriteOrganizationsListScreen extends ConsumerStatefulWidget {
  const FavoriteOrganizationsListScreen({super.key});

  @override
  ConsumerState<FavoriteOrganizationsListScreen> createState() =>
      _OrganizationsListScreenState();
}

class _OrganizationsListScreenState
    extends ConsumerState<FavoriteOrganizationsListScreen> {
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
        final studentsRepository = ref.watch(studentsRepositoryProvider);
        final user = authRepository.currentUser;
        bool isOrg = user?.role == "organization";
        Organization? org = null;
        StudentUser? student = null;
        organizationsRepository.fetchOrganizationsList();
        if (isOrg) {
          org = organizationsRepository.getOrganization(user!.id);
        }
        if (user?.role == 'student') {
          student = studentsRepository.getStudent();
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Favorite Organizations',
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
                    } else {
                      context.pushNamed(AppRoute.profileScreen.name);
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
          body: CustomScrollView(
            controller: _scrollController,
            slivers: [
              const ResponsiveSliverCenter(
                padding: EdgeInsets.all(Sizes.p16),
                child: OrganizationsSearchTextField(),
              ),
              ResponsiveSliverCenter(
                padding: EdgeInsets.all(Sizes.p16),
                child: student!.favoritedOrganizations.isEmpty
                    ? const Center(
                        child: Text(
                          "You have not favorited any organizations.",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: student!.favoritedOrganizations.length,
                        itemBuilder: (context, index) => OrganizationCard(
                          organization: organizationsRepository.getOrganization(
                            student!.favoritedOrganizations.elementAt(index),
                          ),
                          onPressed: () {},
                          isOrg: false,
                        ),
                      ),
              ),
            ],
          ),
          /*drawer: Drawer(
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
          ),*/
        );
      },
    );
  }
}
