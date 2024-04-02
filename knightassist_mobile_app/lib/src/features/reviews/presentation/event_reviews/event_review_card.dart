import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
//import 'package:knightassist_mobile_app/src/features/reviews/domain/review.dart';
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
            if (review.feedbackText.isNotEmpty) ...[
              gapH16,
              Text(
                review.feedbackText,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
            if (review.eventName.isNotEmpty) ...[
              gapH16,
              Text(
                review.eventName,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
            if (review.studentName.isNotEmpty) ...[
              gapH16,
              Text(
                review.studentName,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
            if (review.timeFeedbackSubmitted != null) ...[
              gapH16,
              Text(
                DateFormat.yMEd().format(review.timeFeedbackSubmitted),
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ]
          ],
        ),
      ),
    );
  }
}
