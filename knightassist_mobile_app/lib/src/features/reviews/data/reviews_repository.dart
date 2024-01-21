import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/reviews/domain/review.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reviews_repository.g.dart';

class ReviewsRepository {
  /// Reviews Store
  /// key: [EventID]
  /// value: map of [Review] values for each user ID
  final _reviews = InMemoryStore<Map<EventID, Map<String, Review>>>({});

  /// Single Review for a given event given by a specific user
  /// Emits non-null values if the user has reviewed the event
  Stream<Review?> watchUserReview(EventID id, String uid) {
    return _reviews.stream.map((reviewsData) {
      return reviewsData[id]?[uid];
    });
  }

  Future<Review?> fetchUserReview(EventID id, String uid) async {}

  Stream<List<Review>> watchReviews(EventID id) {
    return _reviews.stream.map((reviewsData) {
      final reviews = reviewsData[id];
      if (reviews == null) {
        return [];
      } else {
        return reviews.values.toList();
      }
    });
  }

  Future<List<Review>?> fetchReviews(EventID id) async {}

  Future<void> setReview(
      {required EventID eventID,
      required String uid,
      required Review review}) async {}
}

@Riverpod(keepAlive: true)
ReviewsRepository reviewsRepository(ReviewsRepositoryRef ref) {
  return ReviewsRepository();
}

@riverpod
Stream<List<Review>> eventReviews(EventReviewsRef ref, EventID id) {
  return ref.watch(reviewsRepositoryProvider).watchReviews(id);
}
