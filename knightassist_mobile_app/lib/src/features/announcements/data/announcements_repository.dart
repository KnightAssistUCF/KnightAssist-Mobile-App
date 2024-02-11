import 'dart:async';
import 'dart:convert';

import 'package:knightassist_mobile_app/src/features/announcements/domain/announcement.dart';
import 'package:knightassist_mobile_app/src/features/students/data/students_repository.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'announcements_repository.g.dart';

class AnnouncementsRepository {
  final _announcements = InMemoryStore<List<Announcement>>([]);

  List<Announcement> getAnnouncementsList() {
    return _announcements.value;
  }

  Announcement? getAnnouncement(String title) {
    return _getAnnouncement(_announcements.value, title);
  }

// returns the list of all announcements from all a student's favorited organizations
  Future<List<Announcement>> fetchStudentFavOrgAnnouncements(
      String studentID) async {
    Map<String, String?> params = {"studentID": studentID};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/favoritedOrgsAnnouncements', params);
    var response = await http.get(uri);
    Map<String, dynamic> map = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<dynamic> announcementJson = map['data'];
        List<Announcement> list = [];

        for (dynamic d in announcementJson) {
          Map<String, String?> params = {
            "title": d['title'],
            "organizationID": d['organizationID']
          };
          var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
              '/api/searchForAnnouncement', params);
          var response = await http.get(uri);
          final dynamic announcementData = jsonDecode(response.body);

          Announcement s = Announcement(
            title: announcementData['title'] ?? '',
            content: announcementData['content'] ?? '',
            date: DateTime.parse(announcementData['date']),
          );

          list.add(s);
          _announcements.value.add(s);
        }

        //String announcementsJson = map['announcements'];
        //_announcements.value = (json.decode(announcementsJson) as List)
        //.map((i) => Announcement.fromMap(i))
        // .toList();
        //return _announcements.value;

        return list;
      default:
        throw Exception(response.body);
    }
  }

  Stream<List<Announcement>> watchAnnouncementsList() {
    return _announcements.stream;
  }

  Stream<Announcement?> watchAnnouncement(String title) {
    return watchAnnouncementsList()
        .map((announcement) => _getAnnouncement(announcement, title));
  }

  Future<List<Announcement>> searchAnnouncements(String query) async {
    assert(
      _announcements.value.length <= 100,
      'Client-side search should only be performed if the number of announcements is small. '
      'Consider doing server-side search for larger datasets.',
    );
    final announcementsList = await fetchStudentFavOrgAnnouncements('');
    return announcementsList
        .where((announcement) =>
            announcement.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  static Announcement? _getAnnouncement(
      List<Announcement> announcements, String title) {
    try {
      return announcements
          .firstWhere((announcement) => announcement.title == title);
    } catch (e) {
      return null;
    }
  }

  Future<String> addAnnouncement(
      String title, String content, DateTime date) async {
    Map<String, dynamic> params = {
      'title': title,
      'content': content,
      'date': date.toIso8601String(),
    };

    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/createOrgAnnouncement");
    var response = await http.post(uri, body: params);
    switch (response.statusCode) {
      case 200:
        return "Success";
      default:
        throw Exception();
    }
  }

  // CURRENTLY DOES NOT WORK PENDING API CHANGES
  Future<String> editAnnouncement(String announcementID,
      {String? title, String? content}) async {
    Map<String, dynamic> params = {'announcementID': announcementID};
    if (title != null) params['title'] = title;
    if (content != null) params['content'] = content;

    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/editOrgAnnouncement");
    var response = await http.post(uri, body: params);
    switch (response.statusCode) {
      case 200:
        return "Success";
      default:
        throw Exception();
    }
  }
}

@riverpod
AnnouncementsRepository announcementsRepository(
    AnnouncementsRepositoryRef ref) {
  return AnnouncementsRepository();
}

@riverpod
Stream<List<Announcement>> announcementsListStream(
    AnnouncementsListStreamRef ref) {
  final announcementsRepository = ref.watch(announcementsRepositoryProvider);
  return announcementsRepository.watchAnnouncementsList();
}

/*@riverpod
Future<List<Announcement>> announcementsListFuture(
    AnnouncementsListFutureRef ref) {
  final announcementsRepository = ref.watch(announcementsRepositoryProvider);
  return announcementsRepository.fetchAnnouncementsList();
}*/

@riverpod
Stream<Announcement?> announcement(AnnouncementRef ref, String title) {
  final announcementsRepository = ref.watch(announcementsRepositoryProvider);
  return announcementsRepository.watchAnnouncement(title);
}

@riverpod
Future<List<Announcement>> announcementsListSearch(
    AnnouncementsListSearchRef ref, String query) async {
  final link = ref.keepAlive();
  final timer = Timer(const Duration(seconds: 60), () {
    link.close();
  });
  ref.onDispose(() => timer.cancel());
  final announcementsRepository = ref.watch(announcementsRepositoryProvider);
  return announcementsRepository.searchAnnouncements(query);
}
