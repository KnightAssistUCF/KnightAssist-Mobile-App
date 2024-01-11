typedef StudentID = String;
typedef EventID = String;

class EventFeedback {
  EventFeedback({
    required this.student,
    required this.event,
    required this.studentName,
    required this.eventName,
    required this.rating,
    required this.feedbackText,
    required this.wasReadByUser,
    required this.timeSubmitted,
    required this.updatedAt,
  });

  final StudentID student;
  final EventID event;
  final String studentName;
  final String eventName;
  double rating;
  final String feedbackText;
  final bool wasReadByUser;
  final DateTime timeSubmitted;
  final DateTime updatedAt;

  factory EventFeedback.fromMap(Map<String, dynamic> map) {
    return EventFeedback(
        student: map['student'] as String,
        event: map['event'] as String,
        studentName: map['studentName'],
        eventName: map['eventName'],
        rating: map['rating'] as double,
        feedbackText: map['feedbackText'],
        wasReadByUser: map['wasReadByUser'] as bool,
        timeSubmitted: DateTime.parse(map['timeSubmitted']),
        updatedAt: DateTime.parse(map['updatedAt']));
  }

  Map<String, dynamic> toMap() => {
        'student': student,
        'event': event,
        'studentName': studentName,
        'eventName': eventName,
        'rating': rating,
        'feedbackText': feedbackText,
        'wasReadByUser': wasReadByUser,
        'timeSubmitted': timeSubmitted.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
