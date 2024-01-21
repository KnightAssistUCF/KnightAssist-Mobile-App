import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:knightassist_mobile_app/src/features/authentication/data/auth_repository.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/reviews/data/reviews_repository.dart';
import 'package:knightassist_mobile_app/src/features/reviews/domain/review.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reviews_service.g.dart';

class ReviewsService {
  ReviewsService(this.ref);
  final Ref ref;

  Future<void> submitReview({
    required EventID eventID,
    required Review review,
  }) async {
    final user = ref.read(authRepositoryProvider).currentUser;

    assert(user != null);
    if (user == null) {
      throw AssertionError('Can\'t submit a review if user is not signed in');
    }
    await ref.read(reviewsRepositoryProvider).setReview(
          eventID: eventID,
          uid: user.id,
          review: review,
        );
  }

  double _avgReviewScore(List<Review> reviews) {
    if (reviews.isNotEmpty) {
      var total = 0.0;
      for (var review in reviews) {
        total += review.rating;
      }
      return total / reviews.length;
    } else {
      return 0.0;
    }
  }
}

@Riverpod(keepAlive: true)
ReviewsService reviewsService(ReviewsServiceRef ref) {
  return ReviewsService(ref);
}

/// Check if a product was previously reviewed by the user
@riverpod
Future<Review?> userReviewFuture(UserReviewFutureRef ref, EventID id) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(reviewsRepositoryProvider).fetchUserReview(id, user.id);
  } else {
    return Future.value(null);
  }
}

@riverpod
Stream<Review?> userReviewStream(UserReviewStreamRef ref, EventID id) {
  final user = ref.watch(authStateChangesProvider).value;
  if (user != null) {
    return ref.watch(reviewsRepositoryProvider).watchUserReview(id, user.id);
  } else {
    return Stream.value(null);
  }
}
