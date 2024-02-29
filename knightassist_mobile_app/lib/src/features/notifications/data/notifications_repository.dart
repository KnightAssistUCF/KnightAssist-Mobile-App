import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';

import 'package:knightassist_mobile_app/src/common_widgets/alert_dialogs.dart';
import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/notification.dart';

part 'notifications_repository.g.dart';

class NotificationsRepository {
  Future<List<PushNotification>> pushNotifications(String userId) async {
    Map<String, String?> params = {
      "userId": userId,
    };
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/pushNotifications', params);
    var response = await http.get(uri);
    var body = json.decode(response.body);
    print(body);
    final dynamic notificationList = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        List<PushNotification> list = [];
        for (dynamic d in notificationList['notifications']['new']) {
          PushNotification n = PushNotification(
              message: d['message'],
              type_is: d['type_is'],
              eventId: d['eventId'],
              orgId: d['orgId'],
              orgName: d['orgName'],
              createdAt: DateTime.parse(d['createdAt']),
              read: d['read'],
              id: d['_id']);
          list.add(n);
        }
        for (dynamic d in notificationList['notifications']['old']) {
          PushNotification n = PushNotification.fromJson(d);
          list.add(n);
        }
        return list;
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }
}

@Riverpod(keepAlive: true)
NotificationsRepository notificationsRepository(
    NotificationsRepositoryRef ref) {
  return NotificationsRepository();
}
