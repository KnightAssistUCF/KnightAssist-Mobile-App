import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/announcements/domain/announcement.dart';

class AnnouncementCard extends ConsumerWidget {
  const AnnouncementCard(
      {super.key, required this.announcement, this.onPressed});

  final Announcement announcement;
  final VoidCallback? onPressed;

  static const announcementCardKey = Key('announcement-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: InkWell(
        key: announcementCardKey,
        onTap: onPressed,
        child: Padding(
            padding: const EdgeInsets.all(Sizes.p16),
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Colors.black26,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Colors.white,
                  elevation: 5,
                  //child: InkWell(
                  //onTap: () => context.pushNamed("updatedetail", extra: update),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(0.05),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: true,
                                visualDensity: VisualDensity.standard,
                                title: Text(
                                  announcement.title,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18),
                                  textAlign: TextAlign.start,
                                ),
                                /*subtitle: Wrap(children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(25.0),
                                    child: Image(
                                        image:
                                            AssetImage(update.sponsor.logoUrl),
                                        height: 25)),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    sponsor.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 3,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w400),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ]),*/
                                trailing: Text(
                                  DateFormat('yyyy-MM-dd')
                                      .format(announcement.date),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Text(
                                announcement.content,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //),
                ))),
      ),
    );
  }
}
