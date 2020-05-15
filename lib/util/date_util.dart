import 'package:flutter/material.dart';

String generateDateString(DateTime date) {
  var day = date.day.toString().padLeft(2, '0');
  var month = date.month.toString().padLeft(2, '0');
  var year = date.year.toString().padLeft(4, '0');

  return day + "." + month + "." + year;
}

String generateTimeString(TimeOfDay time, BuildContext context) {
  final MaterialLocalizations localizations = MaterialLocalizations.of(context);
  final String formattedTimeOfDay = localizations.formatTimeOfDay(
      time,
      alwaysUse24HourFormat: true
  );

  return formattedTimeOfDay;
}

DateTime generateTimestamp(DateTime date, TimeOfDay time, BuildContext context) {
  final timeString = generateTimeString(time, context);

  final dateString =
          date.year.toString().padLeft(4, '0') +
          "-" +
          date.month.toString().padLeft(2, '0') +
          "-" +
          date.day.toString().padLeft(2, '0') +
          "T" +
          timeString + ":00";

  return DateTime.parse(dateString);

}
