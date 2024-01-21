import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/reviews/application/reviews_service.dart';
import 'package:knightassist_mobile_app/src/features/reviews/domain/review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'leave_review_controller.g.dart';

@riverpod
class LeaveReviewController extends _$LeaveReviewController {
  bool mounted = true;

  @override
  FutureOr<void> build() {
    ref.onDispose(() => mounted = false);
  }

  Future<void> submitReview({
    Review? previousReview,
    required EventID eventID,
    required double rating,
    required String comment,
    required void Function() onSuccess,
  }) async {
    if (previousReview == null ||
        rating != previousReview.rating ||
        comment != previousReview.comment) {
      final reviewsService = ref.read(reviewsServiceProvider);
      final review = Review(
        rating: rating,
        comment: comment,
      );
      state = const AsyncLoading();
      final newState = await AsyncValue.guard(
          () => reviewsService.submitReview(eventID: eventID, review: review));
      if (mounted) {
        // * only set the state if the controller hasn't been disposed
        state = newState;
        if (state.hasError == false) {
          onSuccess();
        }
      }
    } else {
      onSuccess();
    }
  }
}
