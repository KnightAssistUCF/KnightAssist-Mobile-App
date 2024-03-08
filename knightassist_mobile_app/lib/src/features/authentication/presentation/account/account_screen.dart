import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/common_widgets/action_text_button.dart';
import 'package:knightassist_mobile_app/src/common_widgets/alert_dialogs.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:knightassist_mobile_app/src/features/images/data/images_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:knightassist_mobile_app/src/utils/async_value_ui.dart';
import 'package:rxdart/rxdart.dart';
import 'package:settings_ui/settings_ui.dart';

/*
DATA NEEDED:
- the current user's profile image and ID
- the full studentuser object or organization object of current user
*/

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(accountScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(accountScreenControllerProvider);

    StudentUser? student = null;

    final authRepository = ref.watch(authRepositoryProvider);
    final user = authRepository.currentUser;
    bool isOrg = user?.role == 'organization';
    final organizationsRepository = ref.watch(organizationsRepositoryProvider);

    organizationsRepository.fetchOrganizationsList();
    final org = organizationsRepository.getOrganization(user?.id ?? '');

    final studentRepository = ref.watch(studentsRepositoryProvider);
    if (user?.role == 'student') {
      studentRepository.fetchStudent(user!.id);
      student = studentRepository.getStudent();
    }

    final imagesRepository = ref.watch(imagesRepositoryProvider);

    Widget getOrgProfileImage() {
      return FutureBuilder(
          future: imagesRepository.retrieveImage('2', org!.id),
          builder: (context, snapshot) {
            final String imageUrl = snapshot.data ?? 'No initial data';
            final String state = snapshot.connectionState.toString();
            return ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(48),
                child: Image(
                    semanticLabel: 'User profile picture',
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover),
              ),
            );
          });
    }

    Widget getStudentProfileImage() {
      return FutureBuilder(
          future: imagesRepository.retrieveImage('3', student!.id),
          builder: (context, snapshot) {
            final String imageUrl = snapshot.data ?? 'No initial data';
            final String state = snapshot.connectionState.toString();
            return ClipOval(
              child: SizedBox.fromSize(
                size: const Size.fromRadius(48),
                child: Image(
                    semanticLabel: 'User profile picture',
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover),
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          title: state.isLoading
              ? const CircularProgressIndicator()
              : const Text('Account'),
          actions: [
            ActionTextButton(
              text: 'Logout',
              onPressed: state.isLoading
                  ? null
                  : () async {
                      final logout = await showAlertDialog(
                          context: context,
                          title: 'Are you sure?',
                          cancelActionText: 'Cancel',
                          defaultActionText: 'Logout');
                      if (logout == true) {
                        ref
                            .read(accountScreenControllerProvider.notifier)
                            .signOut();
                        context.pushNamed(AppRoute.signIn.name);
                      }
                    },
            )
          ],
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Column(children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: 150,
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 0, 108, 81)),
              ),
            ]),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(alignment: Alignment.center, children: [
                Positioned(
                  top: 65,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(height: 40),
                          Text(
                            isOrg
                                ? org?.name ?? ''
                                : user?.role == 'student'
                                    ? '${student!.firstName} ${student!.lastName}'
                                    : 'Not Logged In',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 25),
                          ),
                          Text(
                            isOrg
                                ? "Joined on ${DateFormat.yMMMEd().format(org!.createdAt)}"
                                : user?.role == 'student'
                                    ? 'Joined on ${DateFormat.yMMMEd().format(student!.createdAt)}'
                                    : 'Not Logged In',
                            style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                                fontSize: 20),
                          ),
                        ],
                      ),
                    )),
                  ),
                ),
                Positioned(
                  top: 15,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
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
                      child: isOrg
                          ? getOrgProfileImage()
                          : getStudentProfileImage(),
                    ),
                  ),
                ),
                //const Positioned(top: 215, child: UserDataTable()),
                Positioned(
                  top: 215,
                  child: SizedBox(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    child: SettingsList(
                      sections: [
                        SettingsSection(
                          tiles: <SettingsTile>[
                            SettingsTile.navigation(
                                leading: const Icon(Icons.person),
                                title: const Text('Profile'),
                                onPressed: (context) {
                                  isOrg
                                      ? context.pushNamed("organization",
                                          extra: org)
                                      : context.pushNamed("profileScreen",
                                          extra: student);
                                }),
                            isOrg
                                ? SettingsTile.navigation(
                                    leading:
                                        const Icon(Icons.notifications_none),
                                    title: const Text('Notifications'),
                                    onPressed: (context) {},
                                  )
                                : user?.role == 'student'
                                    ? SettingsTile.navigation(
                                        leading: const Icon(
                                            Icons.access_time_rounded),
                                        title: const Text('Semester Goal'),
                                        value: Text(
                                            '${student!.semesterVolunteerHourGoal}'),
                                        onPressed: (context) =>
                                            context.pushNamed(
                                                AppRoute.semesterGoal.name),
                                      )
                                    : SettingsTile.navigation(
                                        leading: const Icon(
                                            Icons.access_time_rounded),
                                        title: const Text('Semester Goal'),
                                        value: const Text("120"),
                                        onPressed: (context) =>
                                            context.pushNamed(
                                                AppRoute.semesterGoal.name),
                                      ),
                            isOrg
                                ? SettingsTile.navigation(
                                    leading: const Icon(Icons.favorite_border),
                                    title: const Text('Top Volunteers'),
                                    value:
                                        Text(org!.favorites.length.toString()),
                                    onPressed: (context) => context
                                        .pushNamed(AppRoute.leaderboard.name))
                                : SettingsTile.navigation(
                                    leading: const Icon(Icons.favorite_border),
                                    title: const Text('Favorite Organizations'),
                                    value: Text(user?.role == 'student'
                                        ? '${student!.favoritedOrganizations.length}'
                                        : '5'),
                                    onPressed: (context) => context
                                        .pushNamed(AppRoute.favoriteOrgs.name),
                                  ),
                            SettingsTile.navigation(
                              leading: const Icon(Icons.star_border_outlined),
                              title: Text(isOrg ? 'Tags' : 'Interests'),
                              value: Text(isOrg
                                  ? '${org!.categoryTags.length}'
                                  : user?.role == 'student'
                                      ? '${student!.categoryTags.length}'
                                      : '10'),
                              onPressed: (context) =>
                                  context.pushNamed(AppRoute.tagSelection.name),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ));
  }
}

class UserDataTable extends ConsumerWidget {
  const UserDataTable({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme.titleSmall!;
    final user = ref.watch(authStateChangesProvider).value;
    return Card(
      child: DataTable(columns: [
        DataColumn(label: Text('Field', style: style)),
        DataColumn(label: Text('Value', style: style))
      ], rows: [
        _makeDataRow('email', user?.email ?? '', style)
        // Can add more rows later
      ]),
    );
  }

  DataRow _makeDataRow(String name, String value, TextStyle style) {
    return DataRow(cells: [
      DataCell(Text(
        name,
        style: style,
      )),
      DataCell(Text(
        value,
        style: style,
        maxLines: 2,
      ))
    ]);
  }
}
