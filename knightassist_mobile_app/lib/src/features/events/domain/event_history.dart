import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knightassist_mobile_app/src/features/events/domain/event.dart';

class EventHistory {
  EventHistory({
    required this.id,
    required this.name,
    required this.org,
    required this.checkIn,
    required this.checkOut,
    required this.hours,
    required this.wasAdjusted,
    this.adjustedTotal,
    this.whoAdjusted,
  });

  final String id;
  final String name;
  final String org;
  final DateTime checkIn;
  final DateTime checkOut;
  final double hours;
  final bool wasAdjusted;
  final double? adjustedTotal;
  final String? whoAdjusted;

  factory EventHistory.fromMap(Map<String, dynamic> map) {
    // format dates from the event history api to be parsed in Dart DateTimes
    String date = map['checkOut'][0].toString().replaceAll('/', '-');
    List<String> numbers = [];
    NumberFormat formatter = new NumberFormat("00");

    for (String s in date.split('-')) {
      String formattedNumber = formatter.format(double.parse(s));
      numbers.add(formattedNumber);
    }
    String number = numbers.join('-');
    String str = number.split('-').reversed.join('-');
    String remove = number.replaceAll('-', '');

    // format dates from the event history api to be parsed in Dart DateTimes
    String dateCheckIn = map['checkIn'][0].toString().replaceAll('/', '-');
    List<String> numbersCheckIn = [];

    for (String s in dateCheckIn.split('-')) {
      String formattedNumberCheckIn = formatter.format(double.parse(s));
      numbersCheckIn.add(formattedNumberCheckIn);
    }
    String numberCheckIn = numbersCheckIn.join('-');
    String strCheckIn = numberCheckIn.split('-').reversed.join('-');
    String removeCheckIn = numberCheckIn.replaceAll('-', '');

    return EventHistory(
      id: map['ID'],
      name: map['name'],
      org: map['org'],
      checkIn: DateTime.parse(strCheckIn),
      checkOut: DateTime.parse(str),
      hours: double.parse(map['hours']),
      wasAdjusted: map['wasAdjusted'],
      adjustedTotal: map['adjustedTotal'],
      whoAdjusted: map['whoAdjusted'],
    );
  }
}
