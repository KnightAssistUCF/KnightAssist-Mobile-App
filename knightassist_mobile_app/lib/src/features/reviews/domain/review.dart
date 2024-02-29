import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';

typedef ReviewID = String;

class Review {
  Review({
    this.id,
    this.eventID,
    this.studentID,
    required this.rating,
    required this.comment,
  });

  final String? id;
  final String? eventID;
  final String? studentID;
  final double rating;
  final String comment;

  factory Review.fromMap(Map<String, dynamic> map) {
    return Review(
        id: map['id'] as ReviewID,
        eventID: map['eventID'] as String,
        studentID: map['studentID'] as String,
        rating: map['rating'] as double,
        comment: map['feedbackText'] as String);
  }

  Map<String, dynamic> toMap() => {'rating': rating, 'feedbackText': comment};
}
