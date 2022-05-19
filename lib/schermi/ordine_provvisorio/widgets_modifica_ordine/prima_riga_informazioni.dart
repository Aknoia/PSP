// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text_field/auto_size_text_field.dart';

//  Project imports:
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';
import '../../../controllers/ordine_provvisorio_controller/modifica_ordine_controller.dart';

class PrimaRigaInformazioni extends StatelessWidget {
  const PrimaRigaInformazioni({Key? key, required this.controller}) : super(key: key);

  final ModificaOrdineController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          width: larghezzaSchermo / 1.5,
          padding: const EdgeInsets.only(
            left: 10.0,
            right: 5.0,
          ),
          child: IgnorePointer(
            ignoring: true,
            child: AutoSizeTextField(
              controller: controller.ctrlDescrizione,

              maxLines: 1,
              minFontSize: 12,
              maxFontSize: 20,
              style: const TextStyle(fontSize: 10.0),

              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: kTextFieldShape,

                labelText: 'Minsan: ${controller.minsan}',

                labelStyle: const TextStyle(
                  fontSize: 20.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),

        Container(
          padding: const EdgeInsets.all(5.0),
          width: 120.0,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
            ),
            child: IgnorePointer(
              ignoring: true,
              child: AutoSizeTextField(
                controller: controller.ctrlGrossista,

                maxLines: 1,
                minFontSize: 10.0,
                maxFontSize: 20.0,
                textAlign: TextAlign.center,

                style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors.black,
                ),

                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    enabledBorder: kTextFieldShape,
                    labelText: 'Grossista',

                    labelStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            onPressed: () {
              controller.cambiaGrossista();
            },
          ),
        ),
      ],
    );
  }
}
