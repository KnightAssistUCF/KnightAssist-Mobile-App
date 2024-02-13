import 'dart:async';
import 'dart:convert';

import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';

import 'package:http/http.dart' as http;
import 'package:knightassist_mobile_app/src/features/events/domain/event_history.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'events_repository.g.dart';

class EventsRepository {
  final _events = InMemoryStore<List<Event>>([]);
  final _history = InMemoryStore<List<EventHistory>>([]);

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
    //var body = jsonDecode(response.body);
    final List<dynamic> dataList = jsonDecode(response.body);
    var body = json.decode(response.body);

    switch (response.statusCode) {
      case 200:
        List<Event> list = [];

        for (dynamic d in dataList) {
          Map<String, String?> params = {"eventID": d['_id']};
          var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
              '/api/searchOneEvent', params);
          var response = await http.get(uri);
          //print(jsonDecode(response.body));
          //print(
          //"-------------------------------------------------------------------------------------------------");

          final dynamic eventData = jsonDecode(response.body);
          //print(eventData[0]['name'].toString());
          //print(eventData);

          List<String> attendees = [];
          List<dynamic> registeredVolunteers = [];
          List<String> tags = [];
          List<CheckedInStudent> checkins = [];
          List<Review> reviews = [];

          if (eventData[0]['attendees'] != null) {
            for (dynamic s in eventData[0]['attendees']) {
              attendees.add(s);
            }
          }
          for (dynamic s in eventData[0]['registeredVolunteers']) {
            registeredVolunteers.add(s);
          }
          if (eventData[0]['tags'] != null) {
            for (dynamic s in eventData[0]['tags']) {
              tags.add(s);
            }
          }
          for (dynamic s in eventData[0]['checkedInStudents']) {
            CheckedInStudent c = CheckedInStudent(
                studentId: s['studentId'],
                checkInTime: DateTime.parse(s['checkInTime']),
                checkOutTime: DateTime.parse(s['checkInTime']),
                id: s['_id']);

            checkins.add(c);
          }
          for (dynamic s in eventData[0]['feedback']) {
            Review r = Review(
                studentId: s['studentId'],
                eventId: s['eventId'],
                studentName: s['studentName'],
                eventName: s['eventName'],
                rating: s['rating'] + 0.00,
                feedbackText: s['feedbackText'],
                wasReadByUser: s['wasReadByUser'],
                id: s['_id'],
                timeFeedbackSubmitted:
                    DateTime.parse(s['timeFeedbackSubmitted']),
                createdAt: DateTime.parse(s['createdAt']),
                updatedAt: DateTime.parse(s['updatedAt']));
            reviews.add(r);
          }

          Event e = Event(
              id: eventData[0]['_id'],
              name: eventData[0]['name'],
              description: eventData[0]['description'],
              location: eventData[0]['location'],
              sponsoringOrganization: eventData[0]['sponsoringOrganization'],
              attendees: attendees,
              registeredVolunteers: registeredVolunteers,
              profilePicPath: eventData[0]['profilePicPath'],
              startTime: DateTime.parse(eventData[0]['startTime']),
              endTime: DateTime.parse(eventData[0]['endTime']),
              eventTags: tags,
              maxAttendees: eventData[0]['maxAttendees'],
              checkedInStudents: checkins,
              feedback: reviews,
              createdAt: DateTime.parse(eventData[0]['createdAt']),
              updatedAt: DateTime.parse(eventData[0]['updatedAt']));

          list.add(e);
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
    var response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'description': description,
          'location': location,
          'date': date.toIso8601String(),
          'sponsoringOrganization': sponsoringOrganization,
          'startTime': startTime.toIso8601String(),
          'endTime': endTime.toIso8601String(),
          'eventTags': eventTags,
          'semester': semester,
          'maxAttendees': maxAttendees.toString(),
        }));
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return body["ID"];
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<void> editEvent(
      String eventID,
      String organizationID,
      String? name,
      String? description,
      String? location,
      DateTime? startTime,
      DateTime? endTime,
      String? picLink,
      List<String>? eventTags,
      String? semester,
      int? maxAttendees) async {
    Map<String, dynamic> params = {'eventID': eventID};
    if (name != null) params['name'] = name;
    if (description != null) params['description'] = description;
    if (location != null) params['location'] = location;
    if (startTime != null) params['startTime'] = startTime.toIso8601String();
    if (endTime != null) params['endTime'] = endTime.toIso8601String();
    if (eventTags != null) params['eventTags'] = eventTags;
    if (semester != null) params['semester'] = semester;
    if (maxAttendees != null) params['maxAttendees'] = maxAttendees;

    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/editEvent");
    var response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'organizationID': organizationID,
          'eventID': eventID,
          'name': name,
          'description': description,
          'location': location,
          'startTime': startTime?.toIso8601String(),
          'endTime': endTime?.toIso8601String(),
          'eventTags': eventTags,
          'semester': semester,
          'maxAttendees': maxAttendees.toString(),
        }));
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        // Successful
        return;
      case 404:
        throw EventNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<String> deleteEvent(String organizationID, String eventID) async {
    Map<String, String?> params = {
      "organizationID": organizationID,
      "eventID": eventID
    };
    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/deleteSingleEvent");
    var response = await http.delete(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'organizationID': organizationID,
          'eventID': eventID,
        }));
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return ("Success");
      case 404:
        throw EventNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<List<Event>> fetchEventsByOrg(String organizationID) async {
    Map<String, dynamic>? params = {"organizationID": organizationID};

    var uri = Uri.https(
        'knightassist-43ab3aeaada9.herokuapp.com', '/api/searchEvent', params);
    //print(uri);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    //print(body);
    final List<dynamic> dataList = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<Event> list = [];
        for (dynamic d in dataList) {
          Map<String, String?> params = {"eventID": d['_id']};
          var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
              '/api/searchOneEvent', params);
          var response = await http.get(uri);

          final dynamic eventData = jsonDecode(response.body);

          List<String> attendees = [];
          List<dynamic> registeredVolunteers = [];
          List<String> tags = [];
          List<CheckedInStudent> checkins = [];
          List<Review> reviews = [];

          for (dynamic s in eventData[0]['attendees']) {
            attendees.add(s);
          }
          for (dynamic s in eventData[0]['registeredVolunteers']) {
            registeredVolunteers.add(s);
          }
          if (eventData[0]['tags'] != null) {
            for (dynamic s in eventData[0]['tags']) {
              tags.add(s);
            }
          }
          for (dynamic s in eventData[0]['checkedInStudents']) {
            CheckedInStudent c = CheckedInStudent(
                studentId: s['studentId'],
                checkInTime: DateTime.parse(s['checkInTime']),
                checkOutTime: DateTime.parse(s['checkInTime']),
                id: s['_id']);

            checkins.add(c);
          }
          for (dynamic s in eventData[0]['feedback']) {
            Review r = Review(
                studentId: s['studentId'],
                eventId: s['eventId'],
                studentName: s['studentName'],
                eventName: s['eventName'],
                rating: s['rating'] + 0.00,
                feedbackText: s['feedbackText'],
                wasReadByUser: s['wasReadByUser'],
                id: s['_id'],
                timeFeedbackSubmitted:
                    DateTime.parse(s['timeFeedbackSubmitted']),
                createdAt: DateTime.parse(s['createdAt']),
                updatedAt: DateTime.parse(s['updatedAt']));
            reviews.add(r);
          }

          Event e = Event(
              id: eventData[0]['_id'],
              name: eventData[0]['name'],
              description: eventData[0]['description'],
              location: eventData[0]['location'],
              sponsoringOrganization: eventData[0]['sponsoringOrganization'],
              attendees: attendees,
              registeredVolunteers: registeredVolunteers,
              profilePicPath: eventData[0]['profilePicPath'],
              startTime: DateTime.parse(eventData[0]['startTime']),
              endTime: DateTime.parse(eventData[0]['endTime']),
              eventTags: tags,
              maxAttendees: eventData[0]['maxAttendees'],
              checkedInStudents: checkins,
              feedback: reviews,
              createdAt: DateTime.parse(eventData[0]['createdAt']),
              updatedAt: DateTime.parse(eventData[0]['updatedAt']));

          list.add(e);
        }
        return list;
      case 404:
        throw OrganizationNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Future<List<Event>> fetchEventsByStudent(String studentID) async {
    Map<String, dynamic>? params = {"studentID": studentID};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/searchUserRSVPedEvents', params);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    final List<dynamic> dataList = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<Event> list = [];
        for (dynamic d in dataList) {
          Map<String, String?> params = {"eventID": d['_id']};
          var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
              '/api/searchOneEvent', params);
          var response = await http.get(uri);

          final dynamic eventData = jsonDecode(response.body);

          List<String> attendees = [];
          List<dynamic> registeredVolunteers = [];
          List<String> tags = [];
          List<CheckedInStudent> checkins = [];
          List<Review> reviews = [];

          for (dynamic s in eventData[0]['attendees']) {
            attendees.add(s);
          }
          for (dynamic s in eventData[0]['registeredVolunteers']) {
            registeredVolunteers.add(s);
          }
          if (eventData[0]['tags'] != null) {
            for (dynamic s in eventData[0]['tags']) {
              tags.add(s);
            }
          }
          for (dynamic s in eventData[0]['checkedInStudents']) {
            CheckedInStudent c = CheckedInStudent(
                studentId: s['studentId'],
                checkInTime: DateTime.parse(s['checkInTime']),
                checkOutTime: DateTime.parse(s['checkInTime']),
                id: s['_id']);

            checkins.add(c);
          }
          for (dynamic s in eventData[0]['feedback']) {
            Review r = Review(
                studentId: s['studentId'],
                eventId: s['eventId'],
                studentName: s['studentName'],
                eventName: s['eventName'],
                rating: s['rating'] + 0.00,
                feedbackText: s['feedbackText'],
                wasReadByUser: s['wasReadByUser'],
                id: s['_id'],
                timeFeedbackSubmitted:
                    DateTime.parse(s['timeFeedbackSubmitted']),
                createdAt: DateTime.parse(s['createdAt']),
                updatedAt: DateTime.parse(s['updatedAt']));
            reviews.add(r);
          }

          Event e = Event(
              id: eventData[0]['_id'],
              name: eventData[0]['name'],
              description: eventData[0]['description'],
              location: eventData[0]['location'],
              sponsoringOrganization: eventData[0]['sponsoringOrganization'],
              attendees: attendees,
              registeredVolunteers: registeredVolunteers,
              profilePicPath: eventData[0]['profilePicPath'],
              startTime: DateTime.parse(eventData[0]['startTime']),
              endTime: DateTime.parse(eventData[0]['endTime']),
              eventTags: tags,
              maxAttendees: eventData[0]['maxAttendees'],
              checkedInStudents: checkins,
              feedback: reviews,
              createdAt: DateTime.parse(eventData[0]['createdAt']),
              updatedAt: DateTime.parse(eventData[0]['updatedAt']));

          list.add(e);
        }
        return list;
      case 404:
        throw UserNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  List<EventHistory> getEventHistoryList() {
    return _history.value;
  }

  EventHistory? getEventHistory(String id) {
    return _getEventHistory(_history.value, id);
  }

  Future<List<EventHistory>> fetchEventHistoryList(String studentID) async {
    Map<String, dynamic> params = {"studentId": studentID};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/historyOfEvents_User', params);
    var response = await http.get(uri);
    print(response.body);

    switch (response.statusCode) {
      case 200:
        _history.value = (json.decode(response.body) as List)
            .map((i) => EventHistory.fromMap(i))
            .toList();
        return _history.value;
      default:
        throw Exception();
    }
  }

  Stream<List<EventHistory>> watchEventHistoryList() {
    return _history.stream;
  }

  Stream<EventHistory?> watchEventHistory(String id) {
    return watchEventHistoryList()
        .map((history) => _getEventHistory(history, id));
  }

  Future<List<EventHistory>> searchEventHistories(
      String id, String query) async {
    assert(
      _history.value.length <= 100,
      'Client-side search should only be performed if the number of histories is small. '
      'Consider doing server-side search for larger datasets.',
    );

    final historyList = await fetchEventHistoryList(id);
    return historyList
        .where((history) =>
            history.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static EventHistory? _getEventHistory(
      List<EventHistory> histories, String id) {
    try {
      return histories.firstWhere((history) => history.id == id);
    } catch (e) {
      return null;
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
Future<List<Event>> eventsListFuture(EventsListFutureRef ref, String id) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.fetchEventsList();
}

@riverpod
Stream<Event?> event(EventRef ref, String id) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.watchEvent(id);
}

@riverpod
Future<List<Event>> eventsListOrg(EventsListOrgRef ref, String orgID) async {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.fetchEventsByOrg(orgID);
}

@riverpod
Future<List<Event>> eventsListStudent(
    EventsListStudentRef ref, String uid) async {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.fetchEventsByStudent(uid);
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

@riverpod
Stream<List<EventHistory>> eventHistoryListStream(
    EventHistoryListStreamRef ref) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.watchEventHistoryList();
}

@riverpod
Future<List<EventHistory>> eventHistoryListFuture(
    EventHistoryListFutureRef ref, String id) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.fetchEventHistoryList(id);
}

@riverpod
Stream<EventHistory?> eventHistory(EventHistoryRef ref, String id) {
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.watchEventHistory(id);
}

@riverpod
Future<List<EventHistory>> eventHistoryListSearch(
    EventHistoryListSearchRef ref, String id, String query) async {
  final link = ref.keepAlive();
  final timer = Timer(const Duration(seconds: 60), () {
    link.close();
  });
  ref.onDispose(() => timer.cancel());
  final eventsRepository = ref.watch(eventsRepositoryProvider);
  return eventsRepository.searchEventHistories(id, query);
}
