import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/reviews/domain/review.dart';
import 'package:knightassist_mobile_app/src/features/reviews/presentation/event_reviews/event_rating_bar.dart';

class EventReviewCard extends ConsumerWidget {
  const EventReviewCard(this.review, {super.key});
  final Review review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EventRatingBar(
                  initialRating: review.rating,
                  ignoreGestures: true,
                  itemSize: 20,
                  onRatingUpdate: (value) {},
                ),
              ],
            ),
            if (review.comment.isNotEmpty) ...[
              gapH16,
              Text(
                review.comment,
                style: Theme.of(context).textTheme.bodySmall,
              )
            ]
          ],
        ),
      ),
    );
  }
}
