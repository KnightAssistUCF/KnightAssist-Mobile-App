import 'package:knightassist_mobile_app/src/features/authentication/domain/student_user.dart';

class Event {
  String? id;
  String? name;
  String? description;
  String? location;
  String? date;
  String? sponsoringOrganizationID;
  List<String>? attendees;
  List<StudentUser>? registeredVolunteers;
  String? startTime;
  String? endTime;
  List<String>? eventTags;
  String? semester;
  String? createdAt;
  String? updatedAt;
  int? maxAttendees;

  Event(
      {this.id,
      this.name,
      this.description,
      this.location,
      this.date,
      this.sponsoringOrganizationID,
      this.attendees,
      this.registeredVolunteers,
      this.startTime,
      this.endTime,
      this.eventTags,
      this.semester,
      this.createdAt,
      this.updatedAt,
      this.maxAttendees});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    description = json['description'];
    location = json['location'];
    date = json['date'];
    sponsoringOrganizationID = json['sponsoringOrganization'];
    attendees = json['attendees'].cast<String>();

    if (json['registeredVolunteers'] != null) {
      registeredVolunteers = <StudentUser>[];
      json['registeredVolunteers'].forEach((v) {
        registeredVolunteers!.add(StudentUser.fromJson(v));
      });
    }
    startTime = json['startTime'];
    endTime = json['endTime'];
    eventTags = json['eventTags'].cast<String>();
    semester = json['semester'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    maxAttendees = json['maxAttendees'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['location'] = location;
    data['date'] = date;
    data['sponsoringOrganization'] = sponsoringOrganizationID;
    data['attendees'] = attendees;
    if (registeredVolunteers != null) {
      data['registeredVolunteers'] =
          registeredVolunteers!.map((v) => v.toJson()).toList();
    }
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['eventTags'] = eventTags;
    data['semester'] = semester;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['maxAttendees'] = maxAttendees;
    return data;
  }
}
