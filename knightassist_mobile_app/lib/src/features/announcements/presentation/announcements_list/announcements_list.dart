import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:knightassist_mobile_app/src/features/announcements/domain/announcement.dart';
import 'package:knightassist_mobile_app/src/features/announcements/presentation/announcements_list/announcement_card.dart';
import 'package:knightassist_mobile_app/src/features/announcements/presentation/announcements_list/announcements_search_state_provider.dart';

import 'package:knightassist_mobile_app/src/routing/app_router.dart';

class AnnouncementsList extends ConsumerWidget {
  const AnnouncementsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final announcementsListValue =
        ref.watch(announcementsSearchResultsProvider);
    return AsyncValueWidget<List<Announcement>>(
      value: announcementsListValue,
      data: (announcements) => announcements.isEmpty
          ? Center(
              child: Text(
                'No announcements found',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: announcements.length,
              itemBuilder: (_, index) {
                final announcement = announcements[index];
                return AnnouncementCard(announcement: announcement
                    //onPressed: () => context.goNamed(
                    //AppRoute.announcements.name,
                    //pathParameters: {'title': announcement.title})
                    );
              },
            ),
    );
  }
}
