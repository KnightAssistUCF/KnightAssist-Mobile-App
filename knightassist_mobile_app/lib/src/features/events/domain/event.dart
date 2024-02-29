import 'dart:convert';

List<Event> eventFromJson(String str) =>
    List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
  String id;
  String name;
  String description;
  String location;
  String sponsoringOrganization;
  List<String> attendees;
  List<dynamic> registeredVolunteers;
  String profilePicPath;
  DateTime startTime;
  DateTime endTime;
  List<String> eventTags;
  Semester? semester;
  int maxAttendees;
  List<CheckedInStudent> checkedInStudents;
  List<Review> feedback;
  DateTime createdAt;
  DateTime updatedAt;
  EventLinks? eventLinks;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.sponsoringOrganization,
    required this.attendees,
    required this.registeredVolunteers,
    required this.profilePicPath,
    required this.startTime,
    required this.endTime,
    required this.eventTags,
    this.semester,
    required this.maxAttendees,
    required this.checkedInStudents,
    required this.feedback,
    required this.createdAt,
    required this.updatedAt,
    this.eventLinks,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        location: json["location"],
        sponsoringOrganization: json["sponsoringOrganization"],
        attendees: List<String>.from(json["attendees"]),
        registeredVolunteers:
            List<dynamic>.from(json["registeredVolunteers"].map((x) => x)),
        profilePicPath: json["profilePicPath"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        eventTags: List<String>.from(json["eventTags"].map((x) => x)),
        semester: semesterValues.map[json["semester"]]!,
        maxAttendees: json["maxAttendees"],
        checkedInStudents: List<CheckedInStudent>.from(
            json["checkedInStudents"].map((x) => CheckedInStudent.fromJson(x))),
        feedback:
            List<Review>.from(json["feedback"].map((x) => Review.fromJson(x))),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        eventLinks: json["eventLinks"] == null
            ? null
            : EventLinks.fromJson(json["eventLinks"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "location": location,
        "sponsoringOrganization": sponsoringOrganization,
        "attendees": List<dynamic>.from(attendees.map((x) => x)),
        "registeredVolunteers":
            List<dynamic>.from(registeredVolunteers.map((x) => x)),
        "profilePicPath": profilePicPath,
        "startTime": startTime.toIso8601String(),
        "endTime": endTime.toIso8601String(),
        "eventTags": List<dynamic>.from(eventTags.map((x) => x)),
        "semester": semesterValues.reverse[semester],
        "maxAttendees": maxAttendees,
        "checkedInStudents":
            List<dynamic>.from(checkedInStudents.map((x) => x.toJson())),
        "feedback": List<dynamic>.from(feedback.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "eventLinks": eventLinks?.toJson(),
      };
}

class CheckedInStudent {
  String studentId;
  DateTime checkInTime;
  DateTime checkOutTime;
  String id;

  CheckedInStudent({
    required this.studentId,
    required this.checkInTime,
    required this.checkOutTime,
    required this.id,
  });

  factory CheckedInStudent.fromJson(Map<String, dynamic> json) =>
      CheckedInStudent(
        studentId: json["studentId"]!,
        checkInTime: DateTime.parse(json["checkInTime"]),
        checkOutTime: DateTime.parse(json["checkOutTime"]),
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "checkInTime": checkInTime.toIso8601String(),
        "checkOutTime": checkOutTime.toIso8601String(),
        "_id": id,
      };
}

class EventLinks {
  String facebook;
  String twitter;
  String instagram;
  String website;

  EventLinks({
    required this.facebook,
    required this.twitter,
    required this.instagram,
    required this.website,
  });

  factory EventLinks.fromJson(Map<String, dynamic> json) => EventLinks(
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
        website: json["website"],
      );

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
        "website": website,
      };
}

class Review {
  String studentId;
  String eventId;
  String studentName;
  String eventName;
  double rating;
  String feedbackText;
  bool wasReadByUser;
  String id;
  DateTime timeFeedbackSubmitted;
  DateTime createdAt;
  DateTime updatedAt;

  Review({
    required this.studentId,
    required this.eventId,
    required this.studentName,
    required this.eventName,
    required this.rating,
    required this.feedbackText,
    required this.wasReadByUser,
    required this.id,
    required this.timeFeedbackSubmitted,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        studentId: json["studentId"]!,
        eventId: json["eventId"],
        studentName: json["studentName"],
        eventName: json["eventName"],
        rating: json["rating"],
        feedbackText: json["feedbackText"],
        wasReadByUser: json["wasReadByUser"],
        id: json["_id"],
        timeFeedbackSubmitted: DateTime.parse(json["timeFeedbackSubmitted"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "studentId": studentId,
        "eventId": eventId,
        "studentName": studentName,
        "eventName": eventName,
        "rating": rating,
        "feedbackText": feedbackText,
        "wasReadByUser": wasReadByUser,
        "_id": id,
        "timeFeedbackSubmitted": timeFeedbackSubmitted.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

enum Semester { FALL_2023, SPRING_2024 }

final semesterValues = EnumValues(
    {"Fall 2023": Semester.FALL_2023, "Spring 2024": Semester.SPRING_2024});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
