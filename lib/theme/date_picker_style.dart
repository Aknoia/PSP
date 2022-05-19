// Flutter imports:
import 'package:flutter/material.dart';


Theme stileDatePicker(Widget? child) {
  return Theme(
    data: ThemeData.from(
        colorScheme: const ColorScheme.light(
          primary: Colors.blue,
          surface:  Colors.blue,
        ),
    ),

    child: child!,
  );
}