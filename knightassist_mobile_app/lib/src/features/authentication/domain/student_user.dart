import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';

class StudentUser extends AppUser {
  const StudentUser(
      {required super.id,
      required super.email,
      super.role = "student",
      required this.firstName,
      required this.lastName,
      required this.profilePicture,
      required this.favoritedOrganizations,
      required this.eventsRSVP,
      required this.eventsHistory,
      required this.totalVolunteerHours,
      required this.semesterVolunteerHourGoal,
      required this.userStudentSemesters,
      required this.categoryTags,
      required this.recoveryToken,
      required this.confirmToken,
      required this.emailToken,
      required this.emailValidated});

  final String firstName;
  final String lastName;
  final String? profilePicture;
  final List<String> favoritedOrganizations;
  final List<EventID> eventsRSVP;
  final List<EventID> eventsHistory;
  final int totalVolunteerHours;
  final int semesterVolunteerHourGoal;
  final List<String> userStudentSemesters;
  final List<String> categoryTags;
  final String? recoveryToken;
  final String confirmToken;
  final String emailToken;
  final bool emailValidated;

  factory StudentUser.fromMap(Map<String, dynamic> map) {
    return StudentUser(
        id: map['_id'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        email: map['email'],
        role: map['role'],
        profilePicture: map['profilePicture'] as String?,
        favoritedOrganizations:
            List<String>.from(map['favoritedOrganizations']),
        eventsRSVP: List<String>.from(map['eventsRSVP']),
        eventsHistory: List<String>.from(map['eventsHistory']),
        totalVolunteerHours: map['totalVolunteerHours'].toInt() ?? 0,
        semesterVolunteerHourGoal:
            map['semesterVolunteerHourGoal'].toInt() ?? 0,
        userStudentSemesters: List<String>.from(map['userStudentSemesters']),
        categoryTags: List<String>.from(map['categoryTags']),
        recoveryToken: map['recoveryToken'],
        confirmToken: map['confirmToken'],
        emailToken: map['emailToken'],
        emailValidated: map['emailValidated']);
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'role': role,
        'profilePicture': profilePicture,
        'favoritedOrganizations': favoritedOrganizations,
        'eventsRSVP': eventsRSVP,
        'eventsHistory': eventsHistory,
        'totalVolunteerHours': totalVolunteerHours,
        'semesterVolunteerHourGoal': semesterVolunteerHourGoal,
        'userStudentSemesters': userStudentSemesters,
        'categoryTags': categoryTags,
        'recoveryToken': recoveryToken,
        'confirmToken': confirmToken,
        'emailToken': emailToken,
        'emailValidated': emailValidated
      };
}

class StudentSemester {
  StudentSemester(
      {required this.id,
      required this.semester,
      required this.events,
      required this.startDate,
      required this.endDate});

  final String id;
  final String? semester;
  final List<String>? events;
  final DateTime startDate;
  final DateTime endDate;

  factory StudentSemester.fromMap(Map<String, dynamic> map) {
    return StudentSemester(
        id: map['_id'],
        semester: map['semester'],
        events: List<String>.from(map['events']),
        startDate: DateTime.parse(map['startDate']),
        endDate: DateTime.parse(map['endDate']));
  }

  Map<String, dynamic> toMap() => {
        '_id': id,
        'semester': semester,
        'events': events,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String()
      };
}
