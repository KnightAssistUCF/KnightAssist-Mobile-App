import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          // TODO: Implement announcement card appearance
          child: Container(),
        ),
      ),
    );
  }
}
