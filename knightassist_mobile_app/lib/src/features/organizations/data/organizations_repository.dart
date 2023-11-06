import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';

class OrganizationsRepository {
  Future<Organization> getOrganization(String email) async {
    Map<String, String> params = {"email": email};
    var uri = Uri.parse(
        'https://knightassist-43ab3aeaada9.herokuapp.com/api/searchOrganization');
    var response = await http.post(uri, body: params);
    switch (response.statusCode) {
      case 200:
        // Successful
        var json = jsonDecode(response.body);
        return Organization.fromJson(json);
      case 404:
        // Organization not found
        throw Exception();
      default:
        var body = jsonDecode(response.body);
        String err = body["error"];
        throw Exception(err);
    }
  }
}
