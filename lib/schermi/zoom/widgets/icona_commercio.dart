// Flutter imports:
import 'package:flutter/material.dart';

Widget iconaCommercio({required bool inCommercio}) {
  return Image.asset(
    "assets/defaultIcons/${inCommercio ? "prodotto_disponibile.png" : "blocca.png"}",
    scale: 1.5,
    color: (inCommercio) ? Colors.green.shade700 : Colors.red,
  );
}