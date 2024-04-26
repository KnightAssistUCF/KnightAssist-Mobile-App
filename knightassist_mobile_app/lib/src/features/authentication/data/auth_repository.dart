import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:knightassist_mobile_app/src/common_widgets/alert_dialogs.dart';
import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/announcements/domain/announcement.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:http/http.dart' as http;

part 'auth_repository.g.dart';

bool isOrg = false;

class AuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);
  final _token = InMemoryStore<String?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  Stream<String?> tokenChanges() => _token.stream;
  String? get currentToken => _token.value;

  Future<void> signIn(String email, String password) async {
    //Map<String, String> parameters = {
    //"email": email,
    //"password": password,
    //};
    //print(parameters);
    String str =
        jsonEncode(<String, String>{'email': email, 'password': password});
    //print(str);
    var uri =
        Uri.parse('https://knightassist-43ab3aeaada9.herokuapp.com/api/Login');
    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{'email': email, 'password': password}),
    );
    //print("Response:" + response.body);
    var body = jsonDecode(response.body);
    //print(body);
    switch (response.statusCode) {
      case 200:
        //var user = jsonDecode(body["user"]);
        if (response.body.contains('adminUser')) {
          throw AdminLogInException();
          break;
        }
        var user = body["user"];
        //print(user);
        _token.value = body["token"];
        // Successful Login
        if (user["role"] == "student") {
          isOrg = false;
          List<String> favOrgs = [];
          List<String> eventsRSVP = [];
          List<String> eventsHistory = [];
          List<String> categoryTags = [];

          for (dynamic s in user['favoritedOrganizations']) {
            favOrgs.add(s);
          }
          for (dynamic s in user['eventsRSVP']) {
            eventsRSVP.add(s);
          }
          for (dynamic s in user['eventsHistory']) {
            if (s != null) {
              eventsHistory.add(s);
            }
          }
          for (dynamic s in user['categoryTags']) {
            categoryTags.add(s);
          }

          StudentUser u = //StudentUser.fromMap(user)

              StudentUser(
                  id: user['_id'],
                  email: user['email'],
                  firstName: user['firstName'],
                  lastName: user['lastName'],
                  favoritedOrganizations: favOrgs,
                  eventsRsvp: eventsRSVP,
                  eventsHistory: eventsHistory,
                  totalVolunteerHours: user['totalVolunteerHours'],
                  semesterVolunteerHourGoal: user['semesterVolunteerHourGoal'],
                  categoryTags: categoryTags,
                  recoveryToken: user['recoveryToken'] ?? '',
                  confirmToken: user['confirmToken'] ?? '',
                  emailToken: user['EmailToken'] ?? '',
                  emailValidated: user['EmailValidated'],
                  password: user['password'],
                  createdAt: DateTime.parse(user['createdAt']),
                  updatedAt: DateTime.parse(user['updatedAt']),
                  profilePicPath: user['profilePicPath'],
                  role: user['role'],
                  firstTimeLogin: user['firstTimeLogin']);
          _authState.value = u;
        } else if (user["role"] == "organization") {
          isOrg = true;
          //Organization u = Organization.fromMap(user);
          //Organization u = Organization.fromJson(user);

          List<String> tags = [];
          List<String> followers = [];
          List<String> favorites = [];
          List<Announcement> updates = [];
          List<String> eventsArray = [];

          for (dynamic s in user['categoryTags']) {
            tags.add(s);
          }
          if (user['followers'] != null) {
            for (dynamic s in user['followers']) {
              followers.add(s);
            }
          }
          for (dynamic s in user['favorites']) {
            favorites.add(s);
          }
          for (dynamic s in user['updates']) {
            Announcement a = Announcement(
                title: s['title'] == null ? '' : s['title'] ?? '',
                content: s['content'] ?? '',
                date: DateTime.parse(s['date'] ?? ''),
                id: (s['_id'] ?? ''));

            updates.add(a);
          }
          for (dynamic s in user['eventsArray']) {
            eventsArray.add(s);
          }

          Organization u = Organization(
              contact: user['contact'] == null
                  ? Contact()
                  : Contact(
                      socialMedia: user['socialMedia'] == null
                          ? SocialMedia()
                          : SocialMedia(
                              facebook: user['contact']['socialMedia']
                                      ['facebook'] ??
                                  '',
                              twitter: user['contact']['socialMedia']
                                      ['twitter'] ??
                                  '',
                              instagram: user['contact']['socialMedia']
                                      ['instagram'] ??
                                  '',
                              linkedin: user['contact']['socialMedia']
                                      ['linkedin'] ??
                                  ''),
                      email: user['contact']['email'] ?? '',
                      phone: user['contact']['phone'] ?? '',
                      website: user['contact']['website'] ?? ''),
              id: user['_id'],
              organizationId: user['organizationId'],
              name: user['name'],
              password: user['password'],
              email: user['email'],
              description: user['description'] ?? '',
              logoUrl: user['profilePicPath'],
              categoryTags: tags,
              followers: followers,
              favorites: favorites,
              announcements: updates,
              calendarLink: user['calendarLink'] ?? '',
              isActive: user['isActive'],
              eventHappeningNow: user['eventHappeningNow'],
              backgroundUrl: user['backgroundUrl'] ?? '',
              eventsArray: eventsArray,
              location: user['location'] ?? '',
              workingHoursPerWeek: user['workingHoursPerWeek'] == null
                  ? WorkingHoursPerWeek()
                  : WorkingHoursPerWeek(
                      monday: user['workingHoursPerWeek']['monday'] == null
                          ? WeekDay()
                          : WeekDay(
                              start: user['workingHoursPerWeek']['monday']
                                          ['start'] ==
                                      null
                                  ? null
                                  : DateTime.parse(
                                  user['workingHoursPerWeek']['monday']
                                      ['start']),
                              end: user['workingHoursPerWeek']['monday']
                                          ['end'] ==
                                      null
                                  ? null
                                  :  DateTime.parse(user['workingHoursPerWeek']
                                  ['monday']['end'])),
                      tuesday: user['workingHoursPerWeek']['tuesday'] == null
                          ? WeekDay()
                          : WeekDay(
                              start: user['workingHoursPerWeek']['tuesday']
                                          ['start'] ==
                                      null
                                  ? null
                                  : DateTime.parse(
                                      user['workingHoursPerWeek']['tuesday']
                                          ['start']),
                              end: user['workingHoursPerWeek']['tuesday']
                                          ['end'] ==
                                      null
                                  ? null
                                  : DateTime.parse(
                                      user['workingHoursPerWeek']['tuesday']
                                          ['end'])),
                      wednesday: user['workingHoursPerWeek']['wednesday'] ==
                              null
                          ? WeekDay()
                          : WeekDay(
                              start: user['workingHoursPerWeek']['wednesday']
                                          ['start'] ==
                                      null
                                  ? null
                                  : DateTime.parse(
                                  user['workingHoursPerWeek']['wednesday']
                                      ['start']),
                              end: user['workingHoursPerWeek']['wednesday']
                                          ['end'] ==
                                      null
                                  ? null
                                  : DateTime.parse(user['workingHoursPerWeek']
                                  ['wednesday']['end'])),
                      thursday: user['workingHoursPerWeek']['thursday'] ==
                              null
                          ? WeekDay()
                          : WeekDay(
                              start: user['workingHoursPerWeek']['thursday']
                                          ['start'] ==
                                      null
                                  ? null
                                  : DateTime.parse(
                                  user['workingHoursPerWeek']['thursday']
                                      ['start']),
                              end: user['workingHoursPerWeek']['thursday']
                                          ['end'] ==
                                      null
                                  ? null
                                  : DateTime.parse(user['workingHoursPerWeek']
                                  ['thursday']['end'])),
                      friday: user['workingHoursPerWeek']['friday'] == null
                          ? WeekDay()
                          : WeekDay(
                              start: user['workingHoursPerWeek']['friday']
                                          ['start'] ==
                                      null
                                  ? null
                                  :DateTime.parse(
                                  user['workingHoursPerWeek']['friday']
                                      ['start']),
                              end: user['workingHoursPerWeek']['friday']
                                          ['end'] ==
                                      null
                                  ? null
                                  :DateTime.parse(user['workingHoursPerWeek']
                                  ['friday']['end'])),
                      saturday: user['workingHoursPerWeek']['saturday'] ==
                              null
                          ? WeekDay()
                          : WeekDay(
                              start: user['workingHoursPerWeek']['saturday']
                                          ['start'] ==
                                      null
                                  ? null
                                  :DateTime.parse(
                                  user['workingHoursPerWeek']['saturday']
                                      ['start']),
                              end: user['workingHoursPerWeek']['saturday']
                                          ['end'] ==
                                      null
                                  ? null
                                  :DateTime.parse(user['workingHoursPerWeek']
                                  ['saturday']['end'])),
                      sunday: user['workingHoursPerWeek']['sunday'] == null
                          ? WeekDay()
                          : WeekDay(
                              start: user['workingHoursPerWeek']['sunday']
                                          ['start'] ==
                                      null
                                  ? null
                                  :DateTime.parse(
                                  user['workingHoursPerWeek']['sunday']
                                      ['start']),
                              end: user['workingHoursPerWeek']['sunday']
                                          ['end'] ==
                                      null
                                  ? null
                                  :DateTime.parse(user['workingHoursPerWeek']
                                  ['sunday']['end'])),
                    ),
              recoveryTokenForOrg: user['recoveryTokenForORG'],
              confirmTokenForOrg: user['confirmTokenForORG'],
              emailTokenForOrg: user['EmailTokenForORG'],
              emailValidated: user['EmailValidated'],
              v: user['__v'],
              createdAt: DateTime.parse(user['createdAt']),
              updatedAt: DateTime.parse(user['updatedAt']),
              profilePicPath: user['profilePicPath'],
              role: user['role'],
              firstTimeLogin: user['firstTimeLogin']);

          _authState.value = u;
        } else if (user["role"] == "admin") {
          throw AdminLogInException();
        }
        break;
      case 400:
        throw WrongPasswordException();
      case 404:
        throw UserNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<void> createStudentUser(
      String email, String password, String firstName, String lastName) async {
    Map<String, String> parameters = {
      "email": email,
      "password": password,
      "firstName": firstName,
      "lastName": lastName
    };
    var uri = Uri.parse(
        'https://knightassist-43ab3aeaada9.herokuapp.com/api/userSignUp');
    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'firstName': 'firstName',
        'lastName': lastName
      }),
    );
    debugPrint(response.body);
    switch (response.statusCode) {
      case 200:
        // Student user created
        // Direct user to confirm email address
        break;
      case 409:
        // Send StudentUserAlreadyExists exception
        throw Exception("User already exists with this email address.");
      default:
        var body = jsonDecode(response.body);
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<void> createOrganization(
      String email, String password, String name) async {
    Map<String, String> parameters = {
      "email": email,
      "password": password,
      "name": name
    };
    var uri = Uri.parse(
        'https://knightassist-43ab3aeaada9.herokuapp.com/api/organizationSignUp');
    var response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
          'name': 'name',
        }));
    debugPrint(response.body);
    switch (response.statusCode) {
      case 200:
        // Organization created
        // Direct user to confirm email address
        break;
      case 409:
        // Send OrganizationAlreadyExists exception
        throw Exception("Organization already exists with this email address.");
      default:
        var body = jsonDecode(response.body);
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<void> resetPassword(String email) async {
    var uri = Uri.parse(
        'https://knightassist-43ab3aeaada9.herokuapp.com/api/forgotPassword');
    var response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email}));
    debugPrint(response.body);
    switch (response.statusCode) {
      case 200:
        // Email with temporary password sent successfully, and encrypted password stored in the DB
        break;
      case 400:
        // Please provide email so we can send a new password to the user
        throw Exception(
            'Please provide email so we can send a new password to the user');
        break;
      case 404:
        // Email not found -> User or Org not registered with KnightAssist
        throw Exception(
            'Email not found -> User or Org not registered with KnightAssist');
        break;
      case 500:
        // "Error - Error Printed To The Console"
        throw Exception('Error - $response.body');
        break;
      default:
        var body = jsonDecode(response.body);
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<void> signOut() async {
    _authState.value = null;
    // isOrg = false;
  }

  void dispose() => _authState.close();
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(AuthRepositoryRef ref) {
  final auth = AuthRepository();
  ref.onDispose(() => auth.dispose());
  return auth;
}

@Riverpod(keepAlive: true)
Stream<AppUser?> authStateChanges(AuthStateChangesRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges();
}
