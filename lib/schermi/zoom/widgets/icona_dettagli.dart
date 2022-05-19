// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../modelli/prodotto.dart';
Widget iconaDettagli({required Prodotto prodotto}) {
  return IconButton(

    icon: Image.asset(
      'assets/defaultIcons/cerca.png',
      scale: 1.5,

      color: Colors.blue,
    ),

    onPressed: () => Get.toNamed('/schedaprodotto', arguments: prodotto),
  );
}
