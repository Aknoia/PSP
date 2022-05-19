// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';

//  Project imports:
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';
import '../../../controllers/ordine_provvisorio_controller/modifica_ordine_controller.dart';

class TastoMostraGenerici extends StatelessWidget {
  const TastoMostraGenerici({Key? key, required this.controller}) : super(key: key);

  final ModificaOrdineController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      width: larghezzaSchermo / 2.0,
      height: 30.0,
      decoration: kBoxDec,
      child: ElevatedButton(

        style: ElevatedButton.styleFrom(elevation: 0.0),
        onPressed: () => (controller.genericiTotali.value != 0)
            ? controller.mostraGenerici()
            : null,

        child: Obx(
              () => AutoSizeText.rich(
            TextSpan(
                text: 'Generici: ',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.black,
                ),

                semanticsLabel: "Generici",

                children: [
                  TextSpan(
                      text: '${controller.genericiTotali}',
                      style: const TextStyle(fontWeight: FontWeight.w600)
                  ),
                ]
            ),

            maxLines: 1,
          ),
        ),
      ),
    );
  }
}
