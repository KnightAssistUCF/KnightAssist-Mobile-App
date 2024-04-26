import 'dart:convert';

import 'package:knightassist_mobile_app/src/features/leaderboard/domain/leaderboard_entry.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'leaderboard_repository.g.dart';

class LeaderboardRepository {
  final _leaderboard = InMemoryStore<List<LeaderboardEntry>>([]);

  Future<List<LeaderboardEntry>> fetchLeaderboard() async {
    var uri = Uri.https(
        'knightassist-43ab3aeaada9.herokuapp.com', '/api/allStudentsRanking');
    var response = await http.get(uri);
    Map<String, dynamic> map = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<dynamic> leaderboardJson = map['data'];
        List<LeaderboardEntry> list = [];

        for (dynamic d in leaderboardJson) {
          Map<String, String?> params = {"userID": d['_id']};
          var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
              '/api/userSearch', params);
          var response = await http.get(uri);
          final dynamic studentData = jsonDecode(response.body);

          List<String> favoritedOrganizations = [];
          List<String> eventsRSVP = [];
          List<String> eventsHistory = [];
          List<String> userStudentSemesters = [];
          List<String> tags = [];

          for (dynamic s in studentData['favoritedOrganizations']) {
            favoritedOrganizations.add(s);
          }
          for (dynamic s in studentData['eventsRSVP']) {
            eventsRSVP.add(s);
          }
          for (dynamic s in studentData['eventsHistory']) {
            if (s != null) {
              eventsHistory.add(s);
            }
          }
          if (studentData['userStudentSemesters'] != null) {
            for (dynamic s in studentData['userStudentSemesters']) {
              userStudentSemesters.add(s);
            }
          }

          if (studentData['categoryTags'] != null) {
            for (dynamic s in studentData['categoryTags']) {
              tags.add(s);
            }
          }

          LeaderboardEntry s = LeaderboardEntry(
              id: studentData['_id'] ?? '',
              firstName: studentData['firstName'] ?? '',
              lastName: studentData['lastName'] ?? '',
              eventHistory: eventsHistory,
              totalVolunteerHours:
                  studentData['totalVolunteerHours'].toString(),
              profilePicPath: studentData['profilePicPath'] ?? '');

          list.add(s);
          _leaderboard.value.add(s);
        }
        // _leaderboard.value = (json.decode(leaderboardJson) as List)
        //   .map((i) => LeaderboardEntry.fromMap(i))
        //  .toList();
        //print(_leaderboard.value);

        return list;

      default:
        throw Exception();
    }
  }

  Future<List<LeaderboardEntry>> fetchOrgLeaderboard(String orgID) async {
    Map<String, dynamic> params = {"orgId": orgID};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/perOrgLeaderboard', params);
    var response = await http.get(uri);
    Map<String, dynamic> map = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        String leaderboardJson = map['data'];
        _leaderboard.value = (json.decode(leaderboardJson) as List)
            .map((i) => LeaderboardEntry.fromMap(i))
            .toList();
        return _leaderboard.value;
      default:
        throw Exception();
    }
  }
}

@riverpod
LeaderboardRepository leaderboardRepository(LeaderboardRepositoryRef ref) {
  return LeaderboardRepository();
}
