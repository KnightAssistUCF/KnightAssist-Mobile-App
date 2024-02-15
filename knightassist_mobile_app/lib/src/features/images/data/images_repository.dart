import 'dart:convert';

import 'package:knightassist_mobile_app/src/common_widgets/alert_dialogs.dart';
import 'package:knightassist_mobile_app/src/exceptions/app_exception.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/utils/in_memory_store.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'images_repository.g.dart';

class ImagesRepository {

  // this returns the URL of an image from KnightAssist S3 bucket
  Future<String> retriveImage(String typeOfImage, String idOfEntity) async {
    Map<String, String?> params = {"typeOfImage": typeOfImage, "idOfEntity": idOfEntity};
    var uri = Uri.https('knightassist-43ab3aeaada9.herokuapp.com',
        '/api/retrieveImage', params);
    var response = await http.get(uri);
    var body = jsonDecode(response.body);
    switch (response.statusCode) {
      case 200:
        return response.body;
      default:
        String err = body["error"];
        throw Exception(err);
    }
  }

}

@Riverpod(keepAlive: true)
ImagesRepository imagesRepository(ImagesRepositoryRef ref) {
  return ImagesRepository();
}
