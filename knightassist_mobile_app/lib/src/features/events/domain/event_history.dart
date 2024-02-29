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
    String time = map['checkOut'][1].toString();

    //TimeOfDay stringToTimeOfDay(String tod) {
    //final format = DateFormat.jmz(); //"6:00:00 AM"
    //return TimeOfDay.fromDateTime(format.parse(tod));
    //}

    TimeOfDay fromString(String time) {
      int hh = 0;
      if (time.endsWith('PM')) hh = 12;
      time = time.split(' ')[0];
      return TimeOfDay(
        hour: hh +
            int.parse(time.split(":")[0]) %
                24, // in case of a bad time format entered manually by the user
        minute: int.parse(time.split(":")[1]) % 60,
      );
    }

    TimeOfDay checkOutTime = fromString(time);
    //print(checkOutTime.minute);

    List<String> numbers = [];
    NumberFormat formatter = new NumberFormat("00");

    for (String s in date.split('-')) {
      String formattedNumber = formatter.format(double.parse(s));
      numbers.add(formattedNumber);
    }
    String number = numbers.join('-');
    String str = number.split('-').reversed.join('-');
    String remove = number.replaceAll('-', '');

    DateTime checkOutDT = DateTime.parse(str);

    DateTime checkOutFull = DateTime(checkOutDT.year, checkOutDT.month,
        checkOutDT.day, checkOutTime.hour, checkOutTime.minute);

    // format dates from the event history api to be parsed in Dart DateTimes
    String dateCheckIn = map['checkIn'][0].toString().replaceAll('/', '-');
    String timeCheckIn = map['checkIn'][1].toString();
    List<String> numbersCheckIn = [];

    TimeOfDay checkInTime = fromString(timeCheckIn);

    for (String s in dateCheckIn.split('-')) {
      String formattedNumberCheckIn = formatter.format(double.parse(s));
      numbersCheckIn.add(formattedNumberCheckIn);
    }
    String numberCheckIn = numbersCheckIn.join('-');
    String strCheckIn = numberCheckIn.split('-').reversed.join('-');
    String removeCheckIn = numberCheckIn.replaceAll('-', '');

    DateTime checkInDT = DateTime.parse(strCheckIn);

    DateTime checkInFull = DateTime(checkInDT.year, checkInDT.month,
        checkInDT.day, checkInTime.hour, checkInTime.minute);

    return EventHistory(
      id: map['ID'],
      name: map['name'],
      org: map['org'],
      checkIn: checkInFull,
      checkOut: checkOutFull,
      hours: double.parse(map['hours']),
      wasAdjusted: map['wasAdjusted'],
      adjustedTotal: map['adjustedTotal'],
      whoAdjusted: map['whoAdjusted'],
    );
  }
}
