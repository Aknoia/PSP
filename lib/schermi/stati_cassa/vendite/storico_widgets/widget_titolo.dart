// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import '../../../../controllers/stati_cassa_controller/vendite_controller/storico_vendite_controller.dart';
import '../../../../theme/shapes.dart';

class TitoloStorico extends StatelessWidget {
  const TitoloStorico({Key? key, required this.controller}) : super(key: key);

  final StoricoVenditeController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      color: Get.theme.scaffoldBackgroundColor,
      shape: kShapeDettVend,

      child: Column (
        children: <Widget> [
          const SizedBox(height: 15.0),

          AutoSizeText(
            'Vendite del ${controller.periodo.getDataIn()}',
            maxLines: 1,
            minFontSize: 20.0,
            maxFontSize: 25.0,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(
            height: 15.0,
            width: 400.0,
          ),

          const SizedBox(height: 10.0),
        ],
      ),
    );
  }

}