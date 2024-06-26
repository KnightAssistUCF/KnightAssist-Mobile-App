import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/announcements/domain/announcement.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/update.dart'
    as prefix;
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

/*
DATA NEEDED:
- the full object of the update that is viewed
- the current user's profile image and ID
*/

class EditAnnouncement extends ConsumerWidget {
  EditAnnouncement({super.key, required this.announcement});

  Announcement announcement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Announcement',
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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            initialValue: announcement.title,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Announcement Title',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
              width: 240,
              height: 120,
              child: TextFormField(
                maxLines: null,
                expands: true,
                keyboardType: TextInputType.multiline,
                initialValue: announcement.content,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    filled: false,
                    hintText: 'Announcement Description'),
              )),
        ),
        Center(
          child: OverflowBar(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Update',
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Delete',
                        style: TextStyle(fontSize: 20),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
