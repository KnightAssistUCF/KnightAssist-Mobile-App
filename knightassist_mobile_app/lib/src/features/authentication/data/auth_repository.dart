import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
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
    Map<String, String> parameters = {
      "email": email,
      "password": password,
    };
    var uri =
        Uri.parse('https://knightassist-43ab3aeaada9.herokuapp.com/api/Login');
    var response = await http.post(uri, body: parameters);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        var user = jsonDecode(body["user"]);
        _token.value = body["token"];
        // Successful Login
        if (user["role"] == "student") {
          StudentUser u = StudentUser.fromMap(user);
          _authState.value = u;
        } else {
          Organization u = Organization.fromMap(user);
          _authState.value = u;
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
