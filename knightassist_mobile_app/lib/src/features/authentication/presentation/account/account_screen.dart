import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/action_text_button.dart';
import 'package:knightassist_mobile_app/src/common_widgets/alert_dialogs.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:knightassist_mobile_app/src/utils/async_value_ui.dart';

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
      body: /*const ResponsiveCenter(
        padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: UserDataTable(),*/
        Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 200,
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
                    top: 170,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(children: [
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
                    top: 85,
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
    return DataTable(columns: [
      DataColumn(label: Text('Field', style: style)),
      DataColumn(label: Text('Value', style: style))
    ], rows: [
      _makeDataRow('email', user?.email ?? '', style)
      // Can add more rows later
    ]);
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
