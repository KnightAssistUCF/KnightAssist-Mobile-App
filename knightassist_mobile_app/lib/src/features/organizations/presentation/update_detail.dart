import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart'
    as prefix;
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class UpdateDetailScreen extends ConsumerWidget {
  const UpdateDetailScreen({super.key, required this.update});
  final Update update;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    bool curOrg =
        true; // true if the organization who made the update is viewing it (shows edit button)

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Announcements',
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
      body: ListView(scrollDirection: Axis.vertical, children: <Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              update.title,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            //child: TextButton(
            //onPressed: () => context.pushNamed(AppRoute.organization.name,
            //extra: update.sponsor),
            /*child: Wrap(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image(
                          image: AssetImage(update.sponsor.logoUrl),
                          height: 50)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      update.sponsor.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 20),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              ),*/
            //),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat('yyyy-MM-dd').format(update.date),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat.jmv().format(update.date),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              update.content,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          curOrg
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ElevatedButton(
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Edit",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      onPressed: () =>
                          context.pushNamed("editupdate", extra: update),
                    ),
                  ),
                )
              : SizedBox(
                  height: 0,
                )
        ]),
      ]),
    );
  }
}
