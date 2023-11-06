import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';

class StudentUser extends AppUser {
  String? firstName;
  String? lastName;
  String? profilePicture;
  String? createdAt;
  String? updatedAt;
  String? confirmToken;
  List<Event>? eventsHistory;
  List<String>? eventsRSVP;
  List<String>? favoritedOrganizations;
  int? semesterVolunteerHourGoal;
  int? totalVolunteerHours;
  List<Semester>? userStudentSemesters;
  bool? valid;
  String? emailToken;
  bool? emailValidated;

  StudentUser(
      {required super.id,
      required super.recoveryToken,
      this.firstName,
      this.lastName,
      required super.email,
      this.profilePicture,
      this.createdAt,
      this.updatedAt,
      this.confirmToken,
      this.eventsHistory,
      this.eventsRSVP,
      this.favoritedOrganizations,
      this.semesterVolunteerHourGoal,
      this.totalVolunteerHours,
      this.userStudentSemesters,
      this.valid,
      this.emailToken,
      this.emailValidated});

  StudentUser.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    recoveryToken = json['recoveryToken'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    profilePicture = json['profilePicture'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    confirmToken = json['confirmToken'];
    if (json['eventsHistory'] != null) {
      eventsHistory = <Event>[];
      json['eventsHistory'].forEach((v) {
        eventsHistory!.add(Event.fromJson(v));
      });
    }
    eventsRSVP = json['eventsRSVP'].cast<String>();
    favoritedOrganizations = json['favoritedOrganizations'].cast<String>();
    semesterVolunteerHourGoal = json['semesterVolunteerHourGoal'];
    totalVolunteerHours = json['totalVolunteerHours'];

    if (json['userStudentSemesters'] != null) {
      userStudentSemesters = <Semester>[];
      json['userStudentSemesters'].forEach((v) {
        userStudentSemesters!.add(Semester.fromJson(v));
      });
    }
    valid = json['valid'];
    emailToken = json['EmailToken'];
    emailValidated = json['EmailValidated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['recoveryToken'] = recoveryToken;
    data['_id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['profilePicture'] = profilePicture;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['confirmToken'] = confirmToken;
    if (eventsHistory != null) {
      data['eventsHistory'] = eventsHistory!.map((v) => v.toJson()).toList();
    }
    data['eventsRSVP'] = eventsRSVP;
    data['favoritedOrganizations'] = favoritedOrganizations;
    data['semesterVolunteerHourGoal'] = semesterVolunteerHourGoal;
    data['totalVolunteerHours'] = totalVolunteerHours;
    if (userStudentSemesters != null) {
      data['userStudentSemesters'] =
          userStudentSemesters!.map((v) => v.toJson()).toList();
    }
    data['valid'] = valid;
    data['EmailToken'] = emailToken;
    data['EmailValidated'] = emailValidated;
    return data;
  }
}

class Semester {
  Semester({this.semester, this.events, this.startDate, this.endDate});
  String? semester;

  List<Event>? events;
  DateTime? startDate;
  DateTime? endDate;

  Semester.fromJson(Map<String, dynamic> json) {
    semester = json['semester'];
    if (json['events'] != null) {
      events = <Event>[];
      json['events'].forEach((v) {
        events!.add(Event.fromJson(v));
      });
    }
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['semester'] = semester;
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
