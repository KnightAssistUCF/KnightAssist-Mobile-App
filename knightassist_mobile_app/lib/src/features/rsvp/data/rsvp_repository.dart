import 'dart:convert';

import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rsvp_repository.g.dart';

class RSVPRepository {
  final _rsvps = InMemoryStore<List<EventID>>([]);

  Future<List<EventID>> fetchRSVPs(String uid) async {
    Map<String, String?> params = {"studentID": uid};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/searchUserRSVPedEvents', params);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<EventID> list = [];
        for (String json in List<String>.from(body)) {
          list.add(json);
        }
        _rsvps.value = list;
        return _rsvps.value;
      case 404:
        throw UserNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Stream<List<EventID>> watchRSVPs(String uid) {
    return _rsvps.stream;
  }

  Future<void> setRSVP(String uid, EventID eventID) async {
    Map<String, dynamic> params = {
      "userID": uid,
      "eventID": eventID,
    };
    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/RSVPForEvent");
    var response = await http.post(uri, body: params);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        // Handle API cases
        break;
      case 404:
        throw EventNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }
}

@Riverpod(keepAlive: true)
RSVPRepository rsvpRepository(RsvpRepositoryRef ref) {
  return RSVPRepository();
}
