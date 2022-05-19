// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import '../../../controllers/ordine_provvisorio_controller/ordine_provvisorio_controller.dart';
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';

class PulsantiSecondaRiga extends StatelessWidget {
  const PulsantiSecondaRiga({Key? key, required this.controller}) : super(key: key);

  final OrdineProvController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.all(8.0),

          child: Container(
            width: larghezzaSchermo / 2.2,
            padding: const EdgeInsets.only(left: 10.0),
            alignment: Alignment.centerLeft,

            decoration: kBoxDec,

            child: ElevatedButton(

              style: ElevatedButton.styleFrom(
                elevation: 0.0,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  const AutoSizeText(
                    'Aggiungi Ordine \t',
                    maxLines: 1,
                    minFontSize: 10.0,
                    maxFontSize: 15.0,

                    style: TextStyle(color: Colors.black),
                  ),

                  Image.asset(
                    'assets/defaultIcons/aggiungi.png',
                    scale: 1.7,
                    color: Colors.green.shade800,
                  ),
                ],
              ),

              onPressed: () => Get.toNamed(
                '/aggiungiordine',
                arguments: [controller.listaGrossisti],
              ),
            ),
          ),
        ),

        const Spacer(),

        Container(
          width: larghezzaSchermo / 2.2,
          padding: const EdgeInsets.only(right: 10.0),
          alignment: Alignment.centerRight,
        ),
      ],
    );
  }
}
