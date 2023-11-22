import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';

class StudentUser extends AppUser {
  const StudentUser(
      {required super.id,
      super.type = "student",
      required this.firstName,
      required this.lastName,
      required super.email,
      required this.profilePicture,
      required this.favoritedOrganizations,
      required this.eventsRSVP,
      required this.eventsHistory,
      required this.totalVolunteerHours,
      required this.semesterVolunteerHourGoal,
      required this.userStudentSemesters,
      required this.recoveryToken,
      required this.confirmToken,
      required this.emailToken,
      required this.emailValidated,
      required this.createdAt,
      required this.updatedAt});

  final String firstName;
  final String lastName;
  final String? profilePicture;
  final List<String> favoritedOrganizations;
  final List<EventID> eventsRSVP;
  final List<EventID> eventsHistory;
  final int totalVolunteerHours;
  final int semesterVolunteerHourGoal;
  final List<String> userStudentSemesters;
  final String? recoveryToken;
  final String confirmToken;
  final String emailToken;
  final bool emailValidated;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory StudentUser.fromMap(Map<String, dynamic> map) {
    return StudentUser(
        id: map['_id'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        email: map['email'],
        profilePicture: map['profilePicture'] as String?,
        favoritedOrganizations:
            List<String>.from(map['favoritedOrganizations']),
        eventsRSVP: List<String>.from(map['eventsRSVP']),
        eventsHistory: List<String>.from(map['eventsHistory']),
        totalVolunteerHours: map['totalVolunteerHours'].toInt() ?? 0,
        semesterVolunteerHourGoal:
            map['semesterVolunteerHourGoal'].toInt() ?? 0,
        userStudentSemesters: List<String>.from(map['userStudentSemesters']),
        recoveryToken: map['recoveryToken'],
        confirmToken: map['confirmToken'],
        emailToken: map['emailToken'],
        emailValidated: map['emailValidated'],
        createdAt: DateTime.parse(map['createdAt']),
        updatedAt: DateTime.parse(map['updatedAt']));
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'profilePicture': profilePicture,
        'favoritedOrganizations': favoritedOrganizations,
        'eventsRSVP': eventsRSVP,
        'eventsHistory': eventsHistory,
        'totalVolunteerHours': totalVolunteerHours,
        'semesterVolunteerHourGoal': semesterVolunteerHourGoal,
        'userStudentSemesters': userStudentSemesters,
        'recoveryToken': recoveryToken,
        'confirmToken': confirmToken,
        'emailToken': emailToken,
        'emailValidated': emailValidated,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
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
        events!.add(Event.fromMap(v));
      });
    }
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['semester'] = semester;
    if (events != null) {
      data['events'] = events!.map((v) => v.toMap()).toList();
    }
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}
