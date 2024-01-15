import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/authentication/domain/student_user.dart';
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
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<Organization> list = [];
        for (String json in List<String>.from(body)) {
          list.add(Organization.fromMap(jsonDecode(json)));
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

  // TODO: Streamline editing process so not all parameters need to be passed all the time
  // Please don't try to use this yet!
  Future<String> editOrganization(
      String organizationID,
      String password,
      String name,
      String email,
      String description,
      String logoUrl,
      List<String> followers,
      List<String> favorites,
      List<String> updates,
      String calendarLink,
      String contact,
      bool isActive,
      bool eventHappeningNow,
      String backgroundUrl,
      List<String> events,
      String location,
      List<String> categoryTags) async {
    Map<String, dynamic> params = {};
    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/editOrganizationProfile");
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
    switch (response.statusCode) {
      case 200:
        List<StudentUser> list = [];
        for (String json in List<String>.from(body)) {
          list.add(StudentUser.fromMap(jsonDecode(json)));
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
