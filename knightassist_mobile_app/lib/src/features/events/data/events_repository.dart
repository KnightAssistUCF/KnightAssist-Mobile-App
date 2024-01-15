import 'dart:async';
import 'dart:convert';

import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';

import 'package:http/http.dart' as http;
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_repository.g.dart';

class EventsRepository {
  final _events = InMemoryStore<List<Event>>([]);

  List<Event> getEventsList() {
    return _events.value;
  }

  Event? getEvent(String id) {
    return _getEvent(_events.value, id);
  }

  Future<List<Event>> fetchEventsList() async {
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/loadAllEventsAcrossOrgs');
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<Event> list = [];
        for (Map<String, dynamic> json
            in List<Map<String, dynamic>>.from(body)) {
          list.add(Event.fromMap(json));
        }
        _events.value = list;
        return _events.value;
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Stream<List<Event>> watchEventsList() {
    return _events.stream;
  }

  Stream<Event?> watchEvent(String id) {
    return watchEventsList().map((events) => _getEvent(events, id));
  }

  Future<List<Event>> searchEvents(String query) async {
    assert(
      _events.value.length <= 100,
      'Client-side search should only be performed if the number of events is small. '
      'Consider doing server-side search for larger datasets.',
    );

    // TODO: Revamp event search logic
    final eventsList = await fetchEventsList();
    return eventsList
        .where(
            (event) => event.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static Event? _getEvent(List<Event> events, String id) {
    try {
      return events.firstWhere((event) => event.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<String> addEvent(
      String name,
      String description,
      String location,
      DateTime date,
      String sponsoringOrganization,
      DateTime startTime,
      DateTime endTime,
      String picLink,
      List<String> eventTags,
      String semester,
      int maxAttendees) async {
    Map<String, dynamic> params = {
      'name': name,
      'description': description,
      'location': location,
      'date': date.toIso8601String(),
      'sponsoringOrganization': sponsoringOrganization,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'eventTags': eventTags,
      'semester': semester,
      'maxAttendees': maxAttendees,
    };
    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/addEvent");
    var response = await http.post(uri, body: params);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return body["ID"];
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  // TODO: Streamline editing process so not all parameters need to be passed all the time
  // Please don't try to use this yet!
  Future<String> editEvent(
      String organizationID,
      String eventID,
      String name,
      String description,
      String location,
      DateTime date,
      DateTime startTime,
      DateTime endTime,
      String picLink,
      List<String> eventTags,
      String semester,
      int maxAttendees) async {
    Map<String, dynamic> params = {
      'eventID': eventID,
      'organizationID': organizationID,
      'name': name,
      'description': description,
      'location': location,
      'date': date.toIso8601String(),
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'eventTags': eventTags,
      'semester': semester,
      'maxAttendees': maxAttendees,
    };
    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/editEvent");
    var response = await http.post(uri, body: params);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return body["ID"];
      case 404:
        throw EventNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<void> deleteEvent(String organizationID, String eventID) async {
    Map<String, String?> params = {
      "organizationID": organizationID,
      "eventID": eventID
    };
    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/deleteSingleEvent");
    var response = await http.delete(uri, body: params);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        // TODO: Does frontend want a success message for deleting a single event?
        break;
      case 404:
        throw EventNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<void> rsvpForEvent(
      String eventID, String userID, String eventName, bool checked) async {
    Map<String, dynamic> params = {
      "eventID": eventID,
      "userID": userID,
      "eventName": eventName,
      "checked": checked
    };
    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/RSVPForEvent");
    var response = await http.post(uri, body: params);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        // TODO: Does frontend want a success message for rsvping for an event?
        break;
      case 404:
        throw EventNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<List<Event>> getEventsByOrg(String organizationID) async {
    Map<String, String?> params = {"organizationID": organizationID};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/searchEventsForOrg', params);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<Event> list = [];
        for (String json in List<String>.from(body)) {
          list.add(Event.fromMap(jsonDecode(json)));
        }
        return list;
      case 404:
        throw OrganizationNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<List<Event>> getRSVPedEvents(String studentID) async {
    Map<String, String?> params = {"studentID": studentID};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/searchUserRSVPedEvents', params);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<Event> list = [];
        for (String json in List<String>.from(body)) {
          list.add(Event.fromMap(jsonDecode(json)));
        }
        return list;
      case 404:
        throw UserNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<List<StudentUser>> getEventAttendees(String eventID) async {
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

@riverpod
EventsRepository eventsRepository(EventsRepositoryRef ref) {
  return EventsRepository();
}

@riverpod
Stream<List<Event>> eventsListStream(EventsListStreamRef ref) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.watchEventsList();
}

@riverpod
Future<List<Event>> eventsListFuture(EventsListFutureRef ref, EventID id) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.fetchEventsList();
}

@riverpod
Stream<Event?> event(EventRef ref, EventID id) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.watchEvent(id);
}

@riverpod
Future<List<Event>> eventsListSearch(
    EventsListSearchRef ref, String query) async {
  final link = ref.keepAlive();
  final timer = Timer(const Duration(seconds: 60), () {
    link.close();
  });
  ref.onDispose(() => timer.cancel());
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.searchEvents(query);
}
