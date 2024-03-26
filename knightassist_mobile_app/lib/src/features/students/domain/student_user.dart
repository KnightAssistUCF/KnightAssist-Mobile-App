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
  String firstName;
  String lastName;
  String role;
  String email;
  String password;
  String profilePicPath;
  List<String> favoritedOrganizations;
  List<String> eventsRsvp;
  List<String> eventsHistory;
  int totalVolunteerHours;
  int semesterVolunteerHourGoal;
  List<String> categoryTags;
  String recoveryToken;
  String confirmToken;
  String emailToken;
  bool emailValidated;
  DateTime createdAt;
  DateTime updatedAt;

  bool firstTimeLogin;

  StudentUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    required this.email,
    required this.password,
    required this.profilePicPath,
    required this.favoritedOrganizations,
    required this.eventsRsvp,
    required this.eventsHistory,
    required this.totalVolunteerHours,
    required this.semesterVolunteerHourGoal,
    required this.categoryTags,
    required this.recoveryToken,
    required this.confirmToken,
    required this.emailToken,
    required this.emailValidated,
    required this.firstTimeLogin,
    required this.createdAt,
    required this.updatedAt,
  }) : super(id: '', email: '', role: '');

  factory StudentUser.fromJson(Map<String, dynamic> json) => StudentUser(
        id: json["_id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        email: json["email"],
        password: json["password"],
        favoritedOrganizations:
            List<String>.from(json["favoritedOrganizations"].map((x) => x)),
        eventsRsvp: List<String>.from(json["eventsRSVP"].map((x) => x)),
        eventsHistory: List<String>.from(json["eventsHistory"].map((x) => x)),
        totalVolunteerHours: json["totalVolunteerHours"],
        semesterVolunteerHourGoal: json["semesterVolunteerHourGoal"],
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
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "password": password,
        "favoritedOrganizations":
            List<dynamic>.from(favoritedOrganizations.map((x) => x)),
        "eventsRSVP": List<dynamic>.from(eventsRsvp.map((x) => x)),
        "eventsHistory": List<dynamic>.from(eventsHistory.map((x) => x)),
        "totalVolunteerHours": totalVolunteerHours,
        "semesterVolunteerHourGoal": semesterVolunteerHourGoal,
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
