import 'dart:async';
import 'dart:convert';
import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/organization.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:http/http.dart' as http;

part 'auth_repository.g.dart';

class AuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);

  Stream<AppUser?> authStateChanges() => _authState.stream;
  AppUser? get currentUser => _authState.value;

  Future<void> signIn(String email, String password) async {
    Map<String, String> parameters = {
      "email": email,
      "password": password,
    };
    var uri =
        Uri.parse('https://knightassist-43ab3aeaada9.herokuapp.com/api/Login');
    var response = await http.post(uri, body: parameters);
    if (response.statusCode == 200) {
      // TODO: Determine if response is student or org
    } else {
      // Handle error
      var body = jsonDecode(response.body);
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
    // TODO: Insert register student endpoint (may need to change http method)
    var uri = Uri.parse('temp');
    var response = await http.post(uri, body: parameters);
    if (response.statusCode == 201) {
      final user = StudentUser(
          id: jsonDecode(response.body)['studentID'],
          email: jsonDecode(response.body)['email'],
          firstName: jsonDecode(response.body)['firstName'],
          lastName: jsonDecode(response.body)['lastName'],
          profilePicture: jsonDecode(response.body)['profilePicture'],
          favoritedOrganizations:
              jsonDecode(response.body)['favoritedOrganizations'],
          eventsRSVP: jsonDecode(response.body)['eventsRSVP'],
          totalVolunteerHours: jsonDecode(response.body)['totalVolunteerHours'],
          semesterVolunteerHours:
              jsonDecode(response.body)['semesterVolunteerHours']);
      _authState.value = user;
    } else {
      // Handle error
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
    // TODO: Insert register org endpoint (may need to change http method)
    var uri = Uri.parse('temp');
    var response = await http.post(uri, body: parameters);
    if (response.statusCode == 201) {
      final user = Organization(
          id: jsonDecode(response.body)['id'],
          name: jsonDecode(response.body)['name'],
          email: jsonDecode(response.body)['email'],
          logo: jsonDecode(response.body)['logo'],
          background: jsonDecode(response.body)['background'],
          events: jsonDecode(response.body)['events'],
          followers: jsonDecode(response.body)['followers']);
      _authState.value = user;
    } else {
      // Handle error
      var body = jsonDecode(response.body);
      String err = body["error"];
      throw Exception(err);
    }
  }

  Future<void> signOut() async {
    // Send and await sign out request
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
