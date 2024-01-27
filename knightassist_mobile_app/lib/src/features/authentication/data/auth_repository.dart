import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:knightassist_mobile_app/src/common_widgets/alert_dialogs.dart';
import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:http/http.dart' as http;

part 'auth_repository.g.dart';

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
    print(str);
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
        var user = body["user"];
        print(user);
        _token.value = body["token"];
        // Successful Login
        if (user["role"] == "student") {
          List<String> favOrgs = [];
          List<String> eventsRSVP = [];
          List<String> eventsHistory = [];
          List<String> userStudentSemesters = [];
          List<String> categoryTags = [];

          for (dynamic s in user['favoritedOrganizations']) {
            favOrgs.add(s);
          }
          for (dynamic s in user['eventsRSVP']) {
            eventsRSVP.add(s);
          }
          for (dynamic s in user['eventsHistory']) {
            eventsHistory.add(s);
          }
          for (dynamic s in user['userStudentSemesters']) {
            userStudentSemesters.add(s);
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
                  profilePicture: user['profilePicture'],
                  favoritedOrganizations: favOrgs,
                  eventsRSVP: eventsRSVP,
                  eventsHistory: eventsHistory,
                  totalVolunteerHours: user['totalVolunteerHours'],
                  semesterVolunteerHourGoal: user['semesterVolunteerHourGoal'],
                  userStudentSemesters: userStudentSemesters,
                  categoryTags: categoryTags,
                  recoveryToken: user['recoveryToken'] ?? '',
                  confirmToken: user['confirmToken'] ?? '',
                  emailToken: user['EmailToken'] ?? '',
                  emailValidated: user['EmailValidated']);
          _authState.value = u;
        } else if (user["role"] == "organization") {
          //Organization u = Organization.fromMap(user);
          //Organization u = Organization.fromJson(user);

          List<String> tags = [];
          List<String> followers = [];
          List<String> favorites = [];
          List<Update> updates = [];
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
            Update u = Update(
                title: s['title'] == null ? '' : s['title'] ?? '',
                content: s['content'] ?? '',
                date: DateTime.parse(s['date'] ?? ''),
                id: (s['_id'] ?? ''));

            updates.add(u);
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
              updates: updates,
              calendarLink: user['calendarLink'] ?? '',
              isActive: user['isActive'],
              eventHappeningNow: user['eventHappeningNow'],
              backgroundUrl: user['backgroundUrl'] ?? '',
              eventsArray: eventsArray,
              location: user['location'] ?? '',
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
        'https://knightassist-43ab3aeaada9.herokuapp.com/api/userStudentSignUp');
    var response = await http.post(uri, body: parameters);
    debugPrint(response.body);
    switch (response.statusCode) {
      case 200:
        // Student user created
        // Direct user to confirm email address
        break;
      case 409:
        // Send StudentUserAlreadyExists exception
        break;
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
    var response = await http.post(uri, body: parameters);
    switch (response.statusCode) {
      case 200:
        // Organization created
        // Direct user to confirm email address
        break;
      case 409:
        // Send OrganizationAlreadyExists exception
        break;
      default:
        var body = jsonDecode(response.body);
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<void> signOut() async {
    _authState.value = null;
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
