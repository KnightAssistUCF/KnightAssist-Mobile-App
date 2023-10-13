import 'dart:convert';

import 'package:knightassist_mobile_app/src/features/authentication/domain/app_user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static Map<String, String> header = <String, String>{};

  Future<AppUser> signInWithEmailAndPassword(
      String email, String password) async {
    Map<String, String> parameters = {'email': email, 'password': password};
    var uri =
        Uri.parse('https://knightassist-43ab3aeaada9.herokuapp.com/api/Login');
    var response = await http.post(uri, body: parameters);

    if (response.statusCode == 201) {
      return AppUser.fromJson(response.body);
    }
    var body = jsonDecode(response.body);
    String err = body["error"];
    throw Exception(err);
  }

  Future<void> signOut() {
    // TODO: Implement signOut()
  }
}
