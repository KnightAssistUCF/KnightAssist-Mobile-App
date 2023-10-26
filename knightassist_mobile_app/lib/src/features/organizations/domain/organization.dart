import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/student_user.dart';

class Organization extends AppUser {
  const Organization(
      {required super.id,
      required this.name,
      required super.email,
      this.description,
      required this.logo,
      required this.background,
      required this.events,
      required this.followers,
      this.location,
      this.phoneNumber,
      this.calendarLink,
      this.isActive,
      this.eventHappeningNow,
      this.contact,
      this.organizationSemesters});
  final String name;
  final String? description;
  final String logo;
  final String background;
  final List<String> events;
  final List<StudentUser> followers;
  final String? location;
  final String? phoneNumber;
  final String? calendarLink;
  final bool? isActive;
  final bool? eventHappeningNow;
  // Working hours per week
  final List<String>? contact;
  final List<OrganizationSemester>? organizationSemesters;
}

class OrganizationSemester {
  const OrganizationSemester(
      {required this.semester,
      required this.organization,
      required this.events,
      required this.startDate,
      required this.endDate});
  final String semester;
  final Organization organization;
  final List<Event> events;
  final DateTime startDate;
  final DateTime endDate;
}
