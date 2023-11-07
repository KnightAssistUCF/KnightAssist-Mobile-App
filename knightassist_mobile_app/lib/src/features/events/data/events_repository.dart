import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';
import 'package:knightassist_mobile_app/src/features/organizations/domain/organization.dart';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

class EventsRepository {
  Future<List<Event>> getEventsByOrg(Organization org) async {
    Map<String, String?> params = {"organizationID": org.id};
    var uri = Uri.parse(
        "https://knightassist-43ab3aeaada9.herokuapp.com/api/searchEventsForOrg");
    var response = await http.post(uri, body: params);

    switch (response.statusCode) {
      case 200:
        // Successful
        List<Event> events = [];
        var json = jsonDecode(response.body);
        if (json['events'] != null) {
          json['events'].forEach((v) {
            events.add(Event.fromJson(v));
          });
        }
        return events;

      case 404:
        // Organization not found
        throw Exception();
      default:
        var body = jsonDecode(response.body);
        String err = body["error"];
        throw Exception(err);
    }
  }
}
