import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/action_text_button.dart';
import 'package:knightassist_mobile_app/src/common_widgets/alert_dialogs.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';
import 'package:knightassist_mobile_app/src/utils/async_value_ui.dart';
import 'package:rxdart/rxdart.dart';
import 'package:settings_ui/settings_ui.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(accountScreenControllerProvider,
        (_, state) => state.showAlertDialogOnError(context));
    final state = ref.watch(accountScreenControllerProvider);
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
                    }
                  },
          )
        ],
      ),
      body:
        Stack(
              alignment: Alignment.center,
              children: [
        Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 150,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 108, 81)
                ),
              ),
          ]
            ),
            const SizedBox(height: 50,),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 85,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(children: [
                          SizedBox(height: 20),
                          Text(
                            "Student User Name",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 25),
                          ),
                          Text(
                          "Joined October 20th, 2023",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              fontSize: 20),
                          ),
                        ],),
                      )),
                    ),
                  ),
                  Positioned(
                    top: 15,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle,   
                                  boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3), // changes position of shadow
                                  ),
                                 ],),
                                  child: ClipOval(
                                    child: SizedBox.fromSize(
                                        size: const Size.fromRadius(48),
                                        child: const Image(
                                          semanticLabel: 'User profile picture',
                                          image: AssetImage('assets/profile pictures/icon_paintbrush.png'),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
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
                                    leading: Icon(Icons.person),
                                    title: Text('Profile'),
                                    onPressed: (context) => context.pushNamed(AppRoute.profileScreen.name),
                                  ),
                                  SettingsTile.navigation(
                                    leading: Icon(Icons.access_time_rounded),
                                    title: Text('Semester Goal'),
                                    value: Text('120'),
                                    onPressed: (context) => context.pushNamed(AppRoute.profileScreen.name),
                                  ),
                                  SettingsTile.navigation(
                                    leading: Icon(Icons.favorite_border),
                                    title: Text('Favorite Organizations'),
                                    value: Text('5'),
                                    onPressed: (context) => context.pushNamed(AppRoute.organizations.name),
                                  ),
                                  SettingsTile.navigation(
                                    leading: Icon(Icons.star_border_outlined),
                                    title: Text('Interests'),
                                    value: Text('10'),
                                    onPressed: (context) => context.pushNamed(AppRoute.profileScreen.name),
                                  ),
                                ],
                              ),
                            ],
                          ),
                    ),
                  ),
                ]
              ), 
            ),
          ],
        )
  );
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
