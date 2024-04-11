import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/reviews/data/reviews_repository.dart';
//import 'package:knightassist_mobile_app/src/features/reviews/domain/review.dart'
//as prefix;
import 'package:knightassist_mobile_app/src/features/reviews/presentation/event_reviews/event_review_card.dart';

class EventReviewsList extends ConsumerWidget {
  const EventReviewsList({super.key, required this.eventID});
  final String eventID;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewsValue = ref.watch(eventReviewsProvider(eventID));
    return AsyncValueSliverWidget<List<Review>>(
      value: reviewsValue,
      data: (reviews) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) => ResponsiveCenter(
            maxContentWidth: Breakpoint.tablet,
            padding: const EdgeInsets.symmetric(
                horizontal: Sizes.p16, vertical: Sizes.p8),
            child: EventReviewCard(reviews[index] as Review),
          ),
          childCount: reviews.length,
        ),
      ),
    );
  }
}
