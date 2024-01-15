typedef EventID = String;

class Event {
  const Event({
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
    required this.createdAt,
    required this.updatedAt,
  });

  final EventID id;
  final String name;
  final String description;
  final String location;
  final String sponsoringOrganization;
  final List<String> attendees;
  final List<String> registeredVolunteers;
  final String picLink;
  final DateTime startTime;
  final DateTime endTime;
  final List<String> eventTags;
  final String semester;
  final int maxAttendees;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
        id: map['_id'] as String,
        name: map['name'],
        description: map['description'] ?? '',
        location: map['location'] ?? '',
        sponsoringOrganization: map['sponsoringOrganization'],
        attendees: List<String>.from(map['attendees']),
        registeredVolunteers: List<String>.from(map['registeredVolunteers']),
        picLink: map['profilePicPath'] as String,
        startTime: DateTime.parse(map['startTime']),
        endTime: DateTime.parse(map['endTime']),
        eventTags: List<String>.from(map['eventTags']),
        semester: map['semester'],
        maxAttendees: map['maxAttendees']?.toInt() ?? -1,
        createdAt: DateTime.parse(map['createdAt']),
        updatedAt: DateTime.parse(map['updatedAt']));
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
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
