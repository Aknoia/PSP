// Flutter imports:
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Project imports:
import 'colori.dart';

ThemeData stileApplicazione() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: colorePrimario,
    canvasColor:  colorePrimario,
    highlightColor: coloreEvidenzia,
    selectedRowColor: coloreRigaSelezionata,

    textSelectionTheme: TextSelectionThemeData(cursorColor: Colors.cyan.shade600),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: colorePrimario,
      ),
    ),


    fontFamily: 'Raleway',


    textTheme: Get.textTheme.apply(
      displayColor: Colors.black,
      bodyColor: Colors.black,
      fontFamily: 'Raleway',
    ),


    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: coloreSecondario,
      primary: colorePrimario,
    ),
  );
}
