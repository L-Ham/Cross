  import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String formatDate(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  String formatTime(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }