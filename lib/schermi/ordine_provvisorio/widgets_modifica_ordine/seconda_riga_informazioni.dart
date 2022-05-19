// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:auto_size_text_field/auto_size_text_field.dart';

//  Project imports:
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';
import '../../../controllers/ordine_provvisorio_controller/modifica_ordine_controller.dart';

class SecondaRigaInformazioni extends StatelessWidget {
  const SecondaRigaInformazioni({Key? key, required this.controller}) : super(key: key);

  final ModificaOrdineController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[

        ///Disponibilità
        Container(
          padding: const EdgeInsets.all(5.0),
          width: larghezzaSchermo / 4.2,

          child: IgnorePointer(
            ignoring: true,

            child: AutoSizeTextField(
              controller: controller.ctrlDisp,

              textAlign: TextAlign.center,
              maxLines: 1,
              minFontSize: 10.0,
              maxFontSize: 20.0,

              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: kTextFieldShape,

                labelText: 'Disponibilità',
                labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.0),
              ),
            ),
          ),
        ),

        /// Quantità venduta
        Container(
          padding: const EdgeInsets.all(5.0),
          width: larghezzaSchermo / 4.0,

          child: AutoSizeTextField(
            controller: controller.ctrlQtaVenduta,
            focusNode: controller.ctrlFocusQtaVen,

            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],

            textAlign: TextAlign.center,
            maxLines: 1,
            minFontSize: 10.0,
            maxFontSize: 15.0,

            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              focusedBorder: kTextFieldShape,
              enabledBorder: kTextFieldShape,

              labelText: 'Qta Venduta',
              labelStyle: const TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
            ),

            onSubmitted: (valore) => (valore.isEmpty) ? controller.ctrlQtaVenduta.text = '0' : null,

            onChanged: (valore) {
              valore = valore.substring(valore.length - 1);
              if (controller.toccato.value == false) {
                controller.ctrlQtaVenduta.text = valore;

                controller.ctrlQtaVenduta.selection = TextSelection.fromPosition(
                  TextPosition(
                    offset: controller.ctrlQtaVenduta.text.length,
                  ),
                );

                controller.toccato.value = true;
              }
            },
            onTap: () => controller.ctrlQtaVenduta.clear(),
          ),
        ),

        ///Quantità totale
        Container(
          padding: const EdgeInsets.all(5.0),
          width: larghezzaSchermo / 4.3,

          child: IgnorePointer(
            ignoring: true,

            child: AutoSizeTextField(
              controller: controller.ctrlQtaTot,

              minFontSize: 10.0,
              maxFontSize: 15.0,
              maxLines: 1,

              textAlign: TextAlign.center,

              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                enabledBorder: kTextFieldShape,
                labelText: 'Qta Totale',

                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
