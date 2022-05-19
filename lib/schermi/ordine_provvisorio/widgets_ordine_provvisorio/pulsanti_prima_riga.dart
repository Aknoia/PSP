// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'lista_grossisti.dart';
import '../../../controllers/ordine_provvisorio_controller/ordine_provvisorio_controller.dart';
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';

class PulsantiPrimaRiga extends StatelessWidget {
  const PulsantiPrimaRiga({Key? key, required this.controller}) : super(key: key);

  final OrdineProvController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[

        Container(
          margin: const EdgeInsets.all(8.0),
          width: larghezzaSchermo / 2.18,
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
                    'Seleziona Grossisti',
                    maxLines: 1,
                    minFontSize: 10.0,
                    maxFontSize: 15.0,
                    style: TextStyle(color: Colors.black),
                  ),

                  Image.asset(
                    'assets/defaultIcons/lista_cerchiata.png',
                    scale: 1.5,
                    color: Colors.green.shade800,
                  )
                ],
              ),

              onPressed: () {
                controller.ctrlRicerca.text = '';
                controller.vecchiaRicerca.value = '';
                _mostraDialogGrossisti();
              }
          ),
        ),

        const Spacer(),

        Container(
          margin: const EdgeInsets.all(8.0),
          width: larghezzaSchermo / 2.2,
          alignment: Alignment.centerRight,

          decoration: kBoxDec,

          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0.0,
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  Image.asset(
                    'assets/defaultIcons/aggiorna.png',
                    scale: 1.5,
                    color: Colors.green.shade800,
                  ),

                  const AutoSizeText(
                    'Riporta Vendite',
                    maxLines: 1,
                    minFontSize: 10.0,
                    maxFontSize: 15.0,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),

              onPressed: () async {
                controller.riportaVendite(riportaGrossisti: false);

                Get.snackbar(
                  'RIPORTA VENDITE',
                  'Vendite riportare correttamente',
                  backgroundColor: Colors.green.shade600,
                );
              }
          ),
        ),
      ],
    );
  }



  /// Mostra i grossisti disponibili e permette di selezionarli per vedere i loro prodotti
  Future<void> _mostraDialogGrossisti() async {
    await Get.dialog(
      AlertDialog(
        elevation: 10,
        shape: kShapeAlertDialog,



        title: const SizedBox(
          width: 20.0,
          height: 20.0,
          child: AutoSizeText(
            'Scegli i grossisti da mostrare',
            textAlign: TextAlign.center,
          ),
        ),

        content: SizedBox(
          width: 350,
          height: altezzaSchermo / 2,

          child: Center(
            child: (controller.listaGrossisti.isEmpty)
                ? const AutoSizeText('Nessun grossista disponibile', textAlign: TextAlign.center, minFontSize: 18.0, style: TextStyle(fontWeight: FontWeight.bold))
                : ListaGrossisti(controller: controller),
          ),
        ),

        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: larghezzaSchermo / 3.5,
                height: altezzaSchermo / 13.0,

                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(

                      elevation: 0.0,

                      shape: kShapeOrdineProv,
                    ),

                    child: AutoSizeText(
                      'Annulla',
                      maxLines: 1,
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.red.shade900,
                        fontSize: 16.0,
                      ),

                    ),

                    onPressed: () {
                      controller.grossistiSelezionati.clear();
                      controller.annullato.value = true;
                      Get.back();
                    }
                ),
              ),

              const SizedBox(width: 10.0),

              SizedBox(
                width: larghezzaSchermo / 3.5,
                height: altezzaSchermo / 13.0,

                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0.0,

                      shape: kShapeOrdineProv,
                    ),

                    child: AutoSizeText(
                      'Conferma',
                      maxLines: 1,
                      textAlign: TextAlign.center,

                      style: TextStyle(
                        color: Colors.green.shade800,
                        fontSize: 16.0,
                      ),

                    ),

                    onPressed: () {
                      Get.back();
                    }
                ),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );

    /// Aggiorno la lista prodotti
    controller.avviaRicerca('');

    /// Modifico il focus del textfield
    controller.ctrlFocus.unfocus();
  }
}
