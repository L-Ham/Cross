import 'package:flutter/material.dart';

int calculateScheduledTimeInMinutes(DateTime scheduledDate, TimeOfDay scheduledTime) {
  DateTime now = DateTime.now();
  DateTime scheduledDateTime = DateTime(
    scheduledDate.year,
    scheduledDate.month,
    scheduledDate.day,
    scheduledTime.hour,
    scheduledTime.minute,
  );

  return scheduledDateTime.difference(now).inMinutes;
}