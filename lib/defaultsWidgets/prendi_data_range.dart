// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../theme/date_picker_style.dart';

/// Mostra un Dialog che permette di scegliere un intervallo di tempo
Future<List<DateTime>> prendiDataRange () async {
  DateTimeRange intervallo;

  intervallo = (await showDateRangePicker(
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),

    context: Get.context!,

    confirmText: 'Conferma',
    cancelText: 'Annulla',

    initialEntryMode: DatePickerEntryMode.calendarOnly,

    builder: (context, child) {
      return stileDatePicker(child);
    }
  ))!;

  return [intervallo.start, intervallo.end];
  }





/*intervallo = await Get.dialog(
    AlertDialog(
      title: const Center(
        child: Text(
          'Seleziona intervallo',
        ),
      ),

      content: Container(
        width: 400.0,
        height: 400.0,

        padding: const EdgeInsets.all(15.0),

        child: SfDateRangePicker(
          controller: _ctrlData,
          initialSelectedDate: DateTime.now(),

          view: DateRangePickerView.month,
          selectionMode: DateRangePickerSelectionMode.range,

          /// Bottoni
          showNavigationArrow: true,
          showActionButtons: true,

          /// Messaggi
          cancelText: 'Cancella',
          confirmText: 'Conferma',
          monthFormat: 'MMM',

          /// Label Mese-Anno
          /// Formato: "MMM AAAA"
          headerStyle: const DateRangePickerHeaderStyle(
              backgroundColor: Colors.blue,
              textAlign: TextAlign.center,
              textStyle: TextStyle(
                fontSize: 25,
                letterSpacing: 5,
                color: Colors.white,
              )
          ),

          monthViewSettings: const DateRangePickerMonthViewSettings(
            /// Label lista mesi
            viewHeaderStyle: DateRangePickerViewHeaderStyle(
              backgroundColor: Colors.lightBlue,
              textStyle: TextStyle(color: Colors.white),
            ),
          ),

          // Colori
          selectionColor: Colors.blue,
          rangeSelectionColor: Colors.lightBlue.shade200,
          endRangeSelectionColor: Colors.blue,
          startRangeSelectionColor: Colors.blue,
          todayHighlightColor: Colors.red,

          onSubmit: (nuovoIntervallo) {
            PickerDateRange tmp = nuovoIntervallo as PickerDateRange;

            Get.back(result : [tmp.startDate ?? DateTime.now(), tmp.endDate ?? DateTime.now()]);
          },

          onCancel: () {
            _ctrlData.selectedRanges = null;
            _ctrlData.selectedRanges?.add(DateTime.now() as PickerDateRange);
            _ctrlData.selectedRanges?.add(DateTime.now() as PickerDateRange);
          },
        ),
      )
    ),

    barrierDismissible: false,
  );*/