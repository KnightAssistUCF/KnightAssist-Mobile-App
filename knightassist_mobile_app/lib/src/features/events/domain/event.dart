import 'package:knightassist_mobile_app/src/features/events/domain/feedback.dart';

typedef EventID = String;

class Event {
  const Event({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.date,
    required this.sponsoringOrganization,
    required this.attendees,
    required this.registeredVolunteers,
    required this.picLink,
    required this.startTime,
    required this.endTime,
    required this.eventTags,
    required this.semester,
    required this.maxAttendees,
    required this.feedback,
    required this.createdAt,
    required this.updatedAt,
  });

  final EventID id;
  final String name;
  final String description;
  final String location;
  final DateTime date;
  final String sponsoringOrganization;
  final List<String> attendees;
  final List<String> registeredVolunteers;
  final String picLink;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> eventTags;
  final String semester;
  final int maxAttendees;
  final List<EventFeedback> feedback;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
        id: map['id'] as String,
        name: map['name'],
        description: map['description'] ?? '',
        location: map['location'] ?? '',
        date: DateTime.parse(map['date']),
        sponsoringOrganization: map['sponsoringOrganization'],
        attendees: List<String>.from(map['attendees']),
        registeredVolunteers: List<String>.from(map['registeredVolunteers']),
        picLink: map['picLink'] as String,
        startTime: DateTime.parse(map['startTime']),
        endTime: DateTime.parse(map['endTime']),
        eventTags: List<String>.from(map['eventTags']),
        semester: map['semester'],
        maxAttendees: map['maxAttendees']?.toInt() ?? -1,
        feedback: List<EventFeedback>.from(map['feedback']),
        createdAt: DateTime.parse(map['createdAt']),
        updatedAt: DateTime.parse(map['updatedAt']));
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'location': location,
        'date': date.toIso8601String(),
        'sponsoringOrganization': sponsoringOrganization,
        'attendees': attendees,
        'registeredVolunteers': registeredVolunteers,
        'picLink': picLink,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
        'eventTags': eventTags,
        'semester': semester,
        'maxAttendees': maxAttendees,
        'feedback': feedback,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
