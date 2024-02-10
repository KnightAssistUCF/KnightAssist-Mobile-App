import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:knightassist_mobile_app/src/common_widgets/async_value_widget.dart';
import 'package:knightassist_mobile_app/src/common_widgets/primary_button.dart';
import 'package:knightassist_mobile_app/src/common_widgets/responsive_center.dart';
import 'package:knightassist_mobile_app/src/constants/app_sizes.dart';
import 'package:knightassist_mobile_app/src/constants/breakpoints.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/reviews/application/reviews_service.dart';
import 'package:knightassist_mobile_app/src/features/reviews/domain/review.dart'
    as prefix;
import 'package:knightassist_mobile_app/src/features/reviews/presentation/event_reviews/event_rating_bar.dart';
import 'package:knightassist_mobile_app/src/features/reviews/presentation/leave_review_screen/leave_review_controller.dart';
import 'package:knightassist_mobile_app/src/utils/async_value_ui.dart';

class LeaveReviewScreen extends StatelessWidget {
  const LeaveReviewScreen({super.key, required this.eventID});
  final String eventID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("temp")),
      body: ResponsiveCenter(
        maxContentWidth: Breakpoint.tablet,
        padding: const EdgeInsets.all(Sizes.p16),
        child: Consumer(builder: (context, ref, child) {
          final reviewValue = ref.watch(userReviewFutureProvider(eventID));
          //return AsyncValueWidget<Review?>(
          //value: reviewValue,
          //data: (review) => LeaveReviewForm(eventID: eventID, review: review),
          //);
          return const SizedBox(
            height: 0,
          );
        }),
      ),
    );
  }
}

class LeaveReviewForm extends ConsumerStatefulWidget {
  const LeaveReviewForm({super.key, required this.eventID, this.review});
  final String eventID;
  final Review? review;

  // * Keys for testing using find.byKey()
  static const reviewCommentKey = Key('reviewComment');

  @override
  ConsumerState<LeaveReviewForm> createState() => _LeaveReviewFormState();
}

class _LeaveReviewFormState extends ConsumerState<LeaveReviewForm> {
  final _controller = TextEditingController();

  double _rating = 0;

  @override
  void initState() {
    super.initState();
    final review = widget.review;
    if (review != null) {
      _controller.text = review.feedbackText;
      _rating = review.rating;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      leaveReviewControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(leaveReviewControllerProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.review != null) ...[
          const Text(
            'You reviewed this event before. Submit again to edit.',
            textAlign: TextAlign.center,
          ),
          gapH24,
        ],
        Center(
          child: EventRatingBar(
            initialRating: _rating,
            onRatingUpdate: (rating) => setState(() => _rating = rating),
          ),
        ),
        gapH32,
        TextField(
          key: LeaveReviewForm.reviewCommentKey,
          controller: _controller,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 5,
          decoration: const InputDecoration(
            labelText: 'Your feedback (optional)',
            border: OutlineInputBorder(),
          ),
        ),
        gapH32,
        PrimaryButton(
          text: 'Submit',
          isLoading: state.isLoading,
          onPressed: state.isLoading || _rating == 0
              ? null
              : () =>
                  ref.read(leaveReviewControllerProvider.notifier).submitReview(
                        previousReview: widget.review,
                        eventID: widget.eventID,
                        rating: _rating,
                        comment: _controller.text,
                        onSuccess: context.pop,
                      ),
        )
      ],
    );
  }
}
