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
  Future<List<Notification>> pushNotifications(String userId) async {
    Map<String, String?> params = {
      "userId": userId,
    };
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/pushNotifications', params);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        //print(body['url']);
        return body['url'];
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }
}

@Riverpod(keepAlive: true)
NotificationsRepository notificationsRepository(NotificationsRepositoryRef ref) {
  return NotificationsRepository();
}
