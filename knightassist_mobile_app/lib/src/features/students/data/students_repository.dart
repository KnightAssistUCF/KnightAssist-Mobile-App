import 'dart:convert';

import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:http/http.dart' as http;

class StudentsRepository {
  Future<List<StudentUser>> fetchStudentsInOrg(String orgID) async {
    Map<String, dynamic> params = {"organizationID": orgID};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/loadAllStudentsInORG', params);
    var response = await http.get(uri);
    Map<String, dynamic> map = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        String studentsJson = map['favorites'];
        List<StudentUser> students = (json.decode(studentsJson) as List)
            .map((i) => StudentUser.fromMap(i))
            .toList();
        return students;
      default:
        throw Exception();
    }
  }

  Future<List<StudentUser>> fetchEventAttendees(String eventID) async {
    Map<String, String?> params = {"eventID": eventID};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/loadAllEventAttendees', params);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<StudentUser> list = [];
        for (String json in List<String>.from(body)) {
          list.add(StudentUser.fromMap(jsonDecode(json)));
        }
        return list;
      case 404:
        throw EventNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }
}
