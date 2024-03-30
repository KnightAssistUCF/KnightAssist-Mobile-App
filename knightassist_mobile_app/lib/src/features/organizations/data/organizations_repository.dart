import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/announcements/domain/announcement.dart';
import 'package:knightassist_mobile_app/src/features/students/domain/student_user.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'organizations_repository.g.dart';

class OrganizationsRepository {
  final _organizations = InMemoryStore<List<Organization>>([]);

  List<Organization> getOrganizationsList() {
    return _organizations.value;
  }

  Organization? getOrganization(String id) {
    return _getOrganization(_organizations.value, id);
  }

  Future<List<Organization>> fetchOrganizationsList() async {
    var uri = Uri.https(
        'knightassist-43ab3aeaada9.herokuapp.com', '/api/loadAllOrganizations');
    var response = await http.get(uri);
    //var body = jsonDecode(response.body);
    final List<dynamic> dataList = jsonDecode(response.body);
    //print(dataList);
    //print(dataList[0]);
    //final item = dataList[0];
    //print(item['name']);
    //print(item['_id']);

    var body = json.decode(response.body);
    switch (response.statusCode) {
      case 200:
        List<Organization> list = [];
        //for (Map<String, dynamic> json
        //in List<Map<String, dynamic>>.from(body)) {
        //list.add(Organization.fromMap(jsonDecode(json)));
        for (dynamic d in dataList) {
          //String s = d.toString();
          //list.add(organizationFromJson(s));

          Map<String, String?> params = {"organizationID": d['_id']};
          var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
              '/api/organizationSearch', params);
          var response = await http.get(uri);
          //print(jsonDecode(response.body));
          //print(
          //"-------------------------------------------------------------------------------------------------");

          final dynamic orgData = jsonDecode(response.body);
          //print(orgData['name'].toString());
          //print(orgData['contact']['socialMedia']['facebook']!);
          //print(orgData);

          List<String> tags = [];
          List<String> followers = [];
          List<String> favorites = [];
          List<Announcement> updates = [];
          List<String> eventsArray = [];

          for (dynamic s in orgData['categoryTags']) {
            tags.add(s);
          }
          if (orgData['followers'] != null) {
            for (dynamic s in orgData['followers']) {
              followers.add(s);
            }
          }
          for (dynamic s in orgData['favorites']) {
            favorites.add(s);
          }
          for (dynamic s in orgData['updates']) {
            Announcement a = Announcement(
                title: s['title'] == null ? '' : s['title'] ?? '',
                content: s['content'] ?? '',
                date: DateTime.parse(s['date'] ?? ''),
                id: (s['updateID'] ?? ''));

            updates.add(a);
          }
          for (dynamic s in orgData['eventsArray']) {
            eventsArray.add(s);
          }

          Organization o = Organization(
              contact: orgData['contact'] == null
                  ? Contact()
                  : Contact(
                      socialMedia: orgData['contact']['socialMedia'] == null
                          ? SocialMedia()
                          : SocialMedia(
                              facebook: orgData['contact']['socialMedia']
                                      ['facebook'] ??
                                  '',
                              twitter: orgData['contact']['socialMedia']
                                      ['twitter'] ??
                                  '',
                              instagram: orgData['contact']['socialMedia']
                                      ['instagram'] ??
                                  '',
                              linkedin: orgData['contact']['socialMedia']
                                      ['linkedin'] ??
                                  ''),
                      email: orgData['contact']['email'] ?? '',
                      phone: orgData['contact']['phone'] ?? '',
                      website: orgData['contact']['website'] ?? ''),
              id: orgData['_id'],
              organizationId: orgData['organizationId'],
              name: orgData['name'],
              password: orgData['password'],
              email: orgData['email'],
              description: orgData['description'] ?? '',
              logoUrl: orgData['profilePicPath'],
              categoryTags: tags,
              followers: followers,
              favorites: favorites,
              announcements: updates,
              calendarLink: orgData['calendarLink'] ?? '',
              isActive: orgData['isActive'],
              eventHappeningNow: orgData['eventHappeningNow'],
              backgroundUrl: orgData['backgroundUrl'] ?? '',
              eventsArray: eventsArray,
              location: orgData['location'] ?? '',
              workingHoursPerWeek: orgData['workingHoursPerWeek'] == null
                  ? WorkingHoursPerWeek()
                  : WorkingHoursPerWeek(
                      monday: orgData['workingHoursPerWeek']['monday'] == null
                          ? WeekDay()
                          : WeekDay(
                              start: DateTime.parse(
                                  orgData['workingHoursPerWeek']['monday']
                                      ['start']),
                              end: DateTime.parse(orgData['workingHoursPerWeek']
                                  ['monday']['end'])),
                      tuesday: orgData['workingHoursPerWeek']['tuesday'] == null
                          ? WeekDay()
                          : WeekDay(
                              start: DateTime.parse(
                                  orgData['workingHoursPerWeek']['tuesday']
                                      ['start']),
                              end: DateTime.parse(orgData['workingHoursPerWeek']
                                  ['tuesday']['end'])),
                      wednesday: orgData['workingHoursPerWeek']['wednesday'] ==
                              null
                          ? WeekDay()
                          : WeekDay(
                              start: DateTime.parse(
                                  orgData['workingHoursPerWeek']['wednesday']
                                      ['start']),
                              end: DateTime.parse(orgData['workingHoursPerWeek']
                                  ['wednesday']['end'])),
                      thursday: orgData['workingHoursPerWeek']['thursday'] ==
                              null
                          ? WeekDay()
                          : WeekDay(
                              start: DateTime.parse(
                                  orgData['workingHoursPerWeek']['thursday']
                                      ['start']),
                              end: DateTime.parse(orgData['workingHoursPerWeek']
                                  ['thursday']['end'])),
                      friday: orgData['workingHoursPerWeek']['friday'] == null
                          ? WeekDay()
                          : WeekDay(
                              start: DateTime.parse(
                                  orgData['workingHoursPerWeek']['friday']
                                      ['start']),
                              end: DateTime.parse(orgData['workingHoursPerWeek']
                                  ['friday']['end'])),
                      saturday: orgData['workingHoursPerWeek']['saturday'] ==
                              null
                          ? WeekDay()
                          : WeekDay(
                              start: DateTime.parse(
                                  orgData['workingHoursPerWeek']['saturday']
                                      ['start']),
                              end: DateTime.parse(orgData['workingHoursPerWeek']
                                  ['saturday']['end'])),
                      sunday: orgData['workingHoursPerWeek']['sunday'] == null
                          ? WeekDay()
                          : WeekDay(
                              start: DateTime.parse(
                                  orgData['workingHoursPerWeek']['sunday']
                                      ['start']),
                              end: DateTime.parse(orgData['workingHoursPerWeek']
                                  ['sunday']['end'])),
                    ),
              recoveryTokenForOrg: orgData['recoveryTokenForORG'],
              confirmTokenForOrg: orgData['confirmTokenForORG'],
              emailTokenForOrg: orgData['EmailTokenForORG'],
              emailValidated: orgData['EmailValidated'],
              v: orgData['__v'],
              createdAt: DateTime.parse(orgData['createdAt']),
              updatedAt: DateTime.parse(orgData['updatedAt']),
              profilePicPath: orgData['profilePicPath'],
              role: orgData['role'],
              firstTimeLogin: orgData['firstTimeLogin']);

          //print(o.name);
          //print(o.contact?.website);
          //print(o.contact?.socialMedia?.facebook);

          list.add(o);
        }

        _organizations.value = list;
        return _organizations.value;
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  Stream<List<Organization>> watchOrganizationsList() {
    return _organizations.stream;
  }

  Stream<Organization?> watchOrganization(String id) {
    return watchOrganizationsList()
        .map((organization) => _getOrganization(organization, id));
  }

  Future<List<Organization>> searchOrganizations(String query) async {
    final organizationsList = await fetchOrganizationsList();
    return organizationsList
        .where((organization) =>
            organization.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static Organization? _getOrganization(
      List<Organization> organizations, String id) {
    try {
      return organizations.firstWhere((organization) => organization.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<String> editOrganization(
      String organizationID,
      String? password,
      String? name,
      String? email,
      String? description,
      String? logoUrl,
      List<String>? followers,
      List<String>? favorites,
      List<String>? updates,
      String? calendarLink,
      Contact? contact,
      bool? isActive,
      bool? eventHappeningNow,
      String? backgroundUrl,
      List<String>? events,
      String? location,
      List<String>? categoryTags,
      WorkingHoursPerWeek? workingHoursPerWeek) async {
    Map<String, dynamic> params = {'organizationID': organizationID};
    if (name != null) params['name'] = name;
    if (password != null) params['password'] = password;
    if (email != null) params['email'] = email;
    if (description != null) params['description'] = description;
    if (location != null) params['location'] = location;
    if (logoUrl != null) params['logoUrl'] = logoUrl;
    if (followers != null) params['followers'] = followers;
    if (favorites != null) params['favorites'] = favorites;
    if (updates != null) params['updates'] = updates;
    if (calendarLink != null) params['calendarLink'] = calendarLink;
    if (contact != null) params['contact'] = contact.toJson();
    if (isActive != null) params['isActive'] = isActive;
    if (eventHappeningNow != null) {
      params['eventHappeningNow'] = eventHappeningNow;
    }
    if (backgroundUrl != null) params['backgroundUrl'] = backgroundUrl;
    if (events != null) params['events'] = events;
    if (categoryTags != null) params['categoryTags'] = categoryTags;
    if (workingHoursPerWeek != null) {
      params['workingHoursPerWeek '] = workingHoursPerWeek.toJson();
    }

    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/editOrganizationProfile");
    var response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'id': organizationID,
          'name': name,
          'email': email,
          'password': password,
          'description': description,
          'logoUrl': logoUrl,
          'favorites': favorites,
          'updates': updates,
          'calendarLink': calendarLink,
          'location': location,
          'categoryTags': categoryTags,
          'contact': contact?.toJson(),
          'isActive': isActive,
          'eventHappeningNow': eventHappeningNow,
          'backgroundUrl': backgroundUrl,
          'eventsArray': events,
          'workingHoursPerWeek': workingHoursPerWeek?.toJson()
        }));
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

  Future<void> deleteOrganization(String id) async {
    Map<String, String?> params = {
      "organizationID": id,
    };
    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/organizationDelete");
    var response = await http.delete(uri, body: params);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        // TODO: Does frontend want a success message for deleting an organizaztion?
        break;
      case 404:
        throw OrganizationNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

  // TODO: Awaiting talk with Yohan over followers vs favorites
  Future<List<StudentUser>> getFollowers(String id) async {
    Map<String, String?> params = {"organizationID": id};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/loadAllStudentsInORG', params);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    final dynamic dataList = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<StudentUser> list = [];
        //for (String json in List<String>.from(body)) {
        //list.add(StudentUser.fromMap(jsonDecode(json)));
        //}

        for (dynamic d in dataList['favorites']) {
          Map<String, String?> params = {"userID": d['_id']};
          var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
              '/api/searchUser', params);
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
            eventsHistory.add(s);
          }
          for (dynamic s in studentData['userStudentSemesters']) {
            userStudentSemesters.add(s);
          }
          if (studentData['categoryTags'] != null) {
            for (dynamic s in studentData['categoryTags']) {
              tags.add(s);
            }
          }

          StudentUser s = StudentUser(
              id: studentData['_id'],
              email: studentData['email'],
              firstName: studentData['firstName'],
              lastName: studentData['lastName'],
              favoritedOrganizations: favoritedOrganizations,
              eventsRsvp: eventsRSVP,
              eventsHistory: eventsHistory,
              totalVolunteerHours: studentData['totalVolunteerHours'],
              semesterVolunteerHourGoal:
                  studentData['semesterVolunteerHourGoal'],
              categoryTags: tags,
              recoveryToken: studentData['recoveryToken'],
              confirmToken: studentData['confirmTokeb'],
              emailToken: studentData['EmailToken'],
              emailValidated: studentData['emailValidated'],
              password: studentData['password'],
              createdAt: studentData['createdAt'],
              updatedAt: studentData['updatedAt'],
              profilePicPath: studentData['profilePicPath'],
              role: studentData['role'],
              firstTimeLogin: studentData['firstTimeLogin']);

          list.add(s);
        }

        return list;
      case 404:
        throw OrganizationNotFoundException();
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }
}

@riverpod
OrganizationsRepository organizationsRepository(
    OrganizationsRepositoryRef ref) {
  return OrganizationsRepository();
}

@riverpod
Stream<List<Organization>> organizationsListStream(
    OrganizationsListStreamRef ref) {
  final organizationsRepository = ref.watch(organizationsRepositoryProvider);
  return organizationsRepository.watchOrganizationsList();
}

@riverpod
Future<List<Organization>> organizationsListFuture(
    OrganizationsListFutureRef ref, String id) {
  final organizationsRepository = ref.watch(organizationsRepositoryProvider);
  return organizationsRepository.fetchOrganizationsList();
}

@riverpod
Stream<Organization?> organization(OrganizationRef ref, String id) {
  final organizationsRepository = ref.watch(organizationsRepositoryProvider);
  return organizationsRepository.watchOrganization(id);
}

@riverpod
Future<List<Organization>> organizationsListSearch(
    OrganizationsListSearchRef ref, String query) async {
  final link = ref.keepAlive();
  final timer = Timer(const Duration(seconds: 60), () {
    link.close();
  });
  ref.onDispose(() => timer.cancel());
  final organizationsRepository = ref.watch(organizationsRepositoryProvider);
  return organizationsRepository.searchOrganizations(query);
}
