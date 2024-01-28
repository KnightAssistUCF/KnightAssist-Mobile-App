// To parse this JSON data, do
//
//     final studentUser = studentUserFromJson(jsonString);

import 'dart:convert';

import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';

StudentUser studentUserFromJson(String str) =>
    StudentUser.fromJson(json.decode(str));

String studentUserToJson(StudentUser data) => json.encode(data.toJson());

class StudentUser extends AppUser {
  String id;
  String studentId;
  String firstName;
  String lastName;
  String email;
  String password;
  String profilePicture;
  List<String> favoritedOrganizations;
  List<String> eventsRsvp;
  List<dynamic> eventsHistory;
  int totalVolunteerHours;
  int semesterVolunteerHourGoal;
  List<dynamic> userStudentSemesters;
  List<String> categoryTags;
  dynamic recoveryToken;
  String confirmToken;
  String emailToken;
  bool emailValidated;
  DateTime createdAt;
  DateTime updatedAt;
  String profilePicPath;
  String role;
  bool firstTimeLogin;

  StudentUser({
    required this.id,
    required this.studentId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.profilePicture,
    required this.favoritedOrganizations,
    required this.eventsRsvp,
    required this.eventsHistory,
    required this.totalVolunteerHours,
    required this.semesterVolunteerHourGoal,
    required this.userStudentSemesters,
    required this.categoryTags,
    required this.recoveryToken,
    required this.confirmToken,
    required this.emailToken,
    required this.emailValidated,
    required this.createdAt,
    required this.updatedAt,
    required this.profilePicPath,
    required this.role,
    required this.firstTimeLogin,
  }) : super(id: '', email: '', role: '');

  factory StudentUser.fromJson(Map<String, dynamic> json) => StudentUser(
        id: json["_id"],
        studentId: json["studentID"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        profilePicture: json["profilePicture"],
        favoritedOrganizations:
            List<String>.from(json["favoritedOrganizations"].map((x) => x)),
        eventsRsvp: List<String>.from(json["eventsRSVP"].map((x) => x)),
        eventsHistory: List<dynamic>.from(json["eventsHistory"].map((x) => x)),
        totalVolunteerHours: json["totalVolunteerHours"],
        semesterVolunteerHourGoal: json["semesterVolunteerHourGoal"],
        userStudentSemesters:
            List<dynamic>.from(json["userStudentSemesters"].map((x) => x)),
        categoryTags: List<String>.from(json["categoryTags"].map((x) => x)),
        recoveryToken: json["recoveryToken"],
        confirmToken: json["confirmToken"],
        emailToken: json["EmailToken"],
        emailValidated: json["EmailValidated"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        profilePicPath: json["profilePicPath"],
        role: json["role"],
        firstTimeLogin: json["firstTimeLogin"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "studentID": studentId,
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "profilePicture": profilePicture,
        "favoritedOrganizations":
            List<dynamic>.from(favoritedOrganizations.map((x) => x)),
        "eventsRSVP": List<dynamic>.from(eventsRsvp.map((x) => x)),
        "eventsHistory": List<dynamic>.from(eventsHistory.map((x) => x)),
        "totalVolunteerHours": totalVolunteerHours,
        "semesterVolunteerHourGoal": semesterVolunteerHourGoal,
        "userStudentSemesters":
            List<dynamic>.from(userStudentSemesters.map((x) => x)),
        "categoryTags": List<dynamic>.from(categoryTags.map((x) => x)),
        "recoveryToken": recoveryToken,
        "confirmToken": confirmToken,
        "EmailToken": emailToken,
        "EmailValidated": emailValidated,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "profilePicPath": profilePicPath,
        "role": role,
        "firstTimeLogin": firstTimeLogin,
      };
}
