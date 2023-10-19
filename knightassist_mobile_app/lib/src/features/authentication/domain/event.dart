// This is moving to a different domain folder later

import 'package:flutter/material.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/student_user.dart';

class Event {
  const Event(
      {required this.organization,
      this.description,
      required this.date,
      required this.volunteers,
      required this.startTime,
      required this.endTime,
      required this.location,
      required this.maxVolunteers,
      required this.links,
      required this.tags,
      required this.semester});
  final Organization organization;
  final String? description;
  final DateTime date;
  final List<StudentUser> volunteers;
  // TimeOfDay may not be right type here
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String location;
  final int maxVolunteers;
  final List<String> links;
  final List<String> tags;
  // May need to be semester object
  final String semester;
}
