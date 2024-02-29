import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/announcements/data/announcements_repository.dart';
import 'package:knightassist_mobile_app/src/features/announcements/domain/announcement.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/organizations/data/organizations_repository.dart';
import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key, required this.announcement});
  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
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
      body: Consumer(builder: (context, ref, _) {
        final announcementValue =
            ref.watch(announcementProvider(announcement.title));
        return AsyncValueWidget<Announcement?>(
          value: announcementValue,
          data: (announcement) => announcement == null
              ? const EmptyPlaceholderWidget(
                  message: 'Announcement not found',
                )
              : CustomScrollView(
                  slivers: [
                    ResponsiveSliverCenter(
                      padding: const EdgeInsets.all(Sizes.p16),
                      child: AnnouncementDetails(announcement: announcement),
                    ),
                  ],
                ),
        );
      }),
    );
  }
}

class AnnouncementDetails extends ConsumerWidget {
  const AnnouncementDetails({super.key, required this.announcement});
  final Announcement announcement;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool curOrg =
        false; // true if the organization who made the announcement is viewing it (shows edit button)
    final authRepository = ref.watch(authRepositoryProvider);
    final user = authRepository.currentUser;
    final organizationsRepository = ref.watch(organizationsRepositoryProvider);
    if (user?.role == 'organization') {
      final org = organizationsRepository.getOrganization(user!.id);
      if (org!.announcements.contains(announcement)) {
        curOrg = true;
      }
    }
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
              announcement.title,
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
              DateFormat('yyyy-MM-dd').format(announcement.date),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              DateFormat.jmv().format(announcement.date),
              style: const TextStyle(fontSize: 15),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              announcement.content,
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
                      onPressed: () => context.pushNamed("editannouncement",
                          extra: announcement),
                    ),
                  ),
                )
              : const SizedBox(
                  height: 0,
                )
        ]),
      ]),
    );
  }
}
