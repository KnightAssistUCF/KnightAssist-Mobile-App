import 'dart:convert';

import 'package:knightassist_mobile_app/src/common_widgets/alert_dialogs.dart';
import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'rsvp_repository.g.dart';

class RSVPRepository {
  final _rsvps = InMemoryStore<List<String>>([]);

  Future<List<String>> fetchRSVPs(String uid) async {
    Map<String, String?> params = {"studentID": uid};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/searchUserRSVPedEvents', params);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<String> list = [];
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

  Stream<List<String>> watchRSVPs(String uid) {
    return _rsvps.stream;
  }

  Future<String> setRSVP(String uid, String eventID, String eventName) async {
    Map<String, dynamic> params = {
      "userID": uid,
      "eventID": eventID,
      "eventName": eventName
    };
    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/RSVPForEvent");
    var response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userID': uid,
        'eventID': eventID,
        'eventName': eventName
      }),
    );
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        // Handle API cases
        return "Registered for event!";
      case 201:
        return "Already RSVPd for event.";
      case 202:
        return "Event at max capacity.";
      case 400:
        throw Exception("Missing credentials to RSVP for event");
      case 404:
        throw EventNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<String> cancelRSVP(
      String uid, String eventID, String eventName) async {
    Map<String, dynamic> params = {
      "userID": uid,
      "eventID": eventID,
      "eventName": eventName
    };
    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/cancelRSVP");
    var response = await http.delete(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'userID': uid,
        'eventID': eventID,
        'eventName': eventName
      }),
    );
    //
    switch (response.statusCode) {
      case 200:
        // Handle API cases
        //print(response.body);
        return "Cancelled RSVP for event.";
      case 400:
        return "Incorrect credentials provided.";
      case 404:
        return "Event or user not found.";
      default:
        var body = jsonDecode(response.body);
        String err = body["error"];
        throw Exception(err);
    }
  }
}

@Riverpod(keepAlive: true)
RSVPRepository rsvpRepository(RsvpRepositoryRef ref) {
  return RSVPRepository();
}
