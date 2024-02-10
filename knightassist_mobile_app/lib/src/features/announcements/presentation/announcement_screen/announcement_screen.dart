import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/empty_placeholder_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/announcements/data/announcements_repository.dart';
import 'package:knightassist_mobile_app/src/features/announcements/domain/announcement.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key, required this.announcement});
  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("temp")),
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
                    // TODO: Add widget for edit announcement button
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
    // TODO: Implement announcement details appearance
    return Column();
  }
}
