import 'package:knightassist_mobile_app/src/features/reviews/domain/review.dart';

typedef EventID = String;

class Event {
  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.sponsoringOrganization,
    required this.attendees,
    required this.registeredVolunteers,
    required this.picLink,
    required this.startTime,
    required this.endTime,
    required this.eventTags,
    required this.semester,
    required this.maxAttendees,
    required this.reviews,
  });

  final EventID id;
  final String name;
  final String description;
  final String location;
  final String sponsoringOrganization;
  List<String> attendees;
  List<String> registeredVolunteers;
  String picLink;
  DateTime startTime;
  DateTime endTime;
  List<String> eventTags;
  String semester;
  int maxAttendees;
  List<Review> reviews;

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      id: map['id'] as EventID,
      name: map['name'],
      description: map['description'] ?? '',
      location: map['location'] ?? '',
      sponsoringOrganization: map['sponsoringOrganization'],
      attendees: List<String>.from(map['attendees']),
      registeredVolunteers: List<String>.from(map['registeredVolunteers']),
      picLink: map['picLink'] as String,
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      eventTags: List<String>.from(map['eventTags']),
      semester: map['semester'],
      maxAttendees: map['maxAttendees']?.toInt() ?? -1,
      reviews: List<Review>.from(map['feedback']),
    );
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'description': description,
        'location': location,
        'sponsoringOrganization': sponsoringOrganization,
        'attendees': attendees,
        'registeredVolunteers': registeredVolunteers,
        'profilePicPath': picLink,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'eventTags': eventTags,
        'semester': semester,
        'maxAttendees': maxAttendees,
        'feedback': reviews,
      };
}
