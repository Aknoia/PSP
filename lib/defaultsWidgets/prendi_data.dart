// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../theme/date_picker_style.dart';

/// Mostra un Dialog per scegliere una data
Future<DateTime> prendiData(DatePickerMode mostra) async {
  DateTime? dataOutput = await showDatePicker(
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),

      context: Get.context!,

      confirmText: 'Conferma',
      cancelText: 'Annulla',


      initialDatePickerMode: mostra,
      initialEntryMode: DatePickerEntryMode.calendarOnly,

      builder: (context, child) {
        return stileDatePicker(child);
      }
  );

  return dataOutput ?? DateTime.now();
}