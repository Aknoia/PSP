// Flutter imports:
import 'package:flutter/material.dart';

Widget iconaEsaurimento({required bool esaurito}) {
  String icona = (esaurito) ? 'ritardo.png' : 'checkbox_vuoto.png';

  return Image.asset(
    'assets/defaultIcons/$icona',
    scale: 1.5,
    color: (esaurito) ? Colors.red.shade800 : Colors.green.shade700,
  );
}