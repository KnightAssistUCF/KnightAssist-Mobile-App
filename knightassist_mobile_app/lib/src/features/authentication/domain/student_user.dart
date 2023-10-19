import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/event.dart';

class StudentUser extends AppUser {
  const StudentUser(
      {required super.id,
      required this.firstName,
      required this.lastName,
      required super.email,
      required this.profilePicture,
      required this.favoritedOrganizations,
      required this.eventsRSVP,
      this.eventsHistory,
      required this.totalVolunteerHours,
      required this.semesterVolunteerHours,
      this.volunteerHourGoal,
      this.semesters});
  final String firstName;
  final String lastName;
  final String profilePicture;
  final List<String> favoritedOrganizations;
  final List<Event> eventsRSVP;
  final List<Event>? eventsHistory;
  final double totalVolunteerHours;
  final double semesterVolunteerHours;
  final double? volunteerHourGoal;
  final List<StudentSemester>? semesters;
}

class StudentSemester {
  const StudentSemester(
      {required this.semester,
      required this.student,
      required this.events,
      required this.startDate,
      required this.endDate});
  final String semester;
  final StudentUser student;
  final List<Event> events;
  final DateTime startDate;
  final DateTime endDate;
}
