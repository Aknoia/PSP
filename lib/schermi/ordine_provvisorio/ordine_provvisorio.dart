// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'widgets_ordine_provvisorio/box_ricerca.dart';
import 'widgets_ordine_provvisorio/pulsanti_prima_riga.dart';
import 'widgets_ordine_provvisorio/pulsanti_seconda_riga.dart';
import 'widgets_ordine_provvisorio/lista_prodotti.dart';
import '../../defaultsWidgets/widget_in_caricamento.dart';
import '../../defaultsWidgets/widget_colonne_testo.dart';
import '../../controllers/ordine_provvisorio_controller/ordine_provvisorio_controller.dart';
import '../../theme/shapes.dart';



class OrdineProvvisorio extends GetView<OrdineProvController> {
  const OrdineProvvisorio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(OrdineProvController());
    controller.caricaGrossisti();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Obx(
        () => (controller.inizializzato.value == true) ? Column(
          children: <Widget>[

            const SizedBox(height: 10.0),

            BoxRicerca(controller: controller),

            PulsantiPrimaRiga(controller: controller),

            PulsantiSecondaRiga(controller: controller),

            const SizedBox(height: 20.0),

            /// Colonne lista prodotti
            Card(
              elevation: 12.0,

              shape: kShapeSchedaProd,

              child: Column(
                children: const <Widget>[
                   SizedBox(height: 10.0),

                  Padding(
                    padding:  EdgeInsets.only(
                      bottom: 2.0,
                      left: 6.0,
                      top: 1.0,
                    ),

                    child: WidgetColonneTesto(
                      descrizioneColonne: ['Descrizione', 'Disponibilità'],
                      larghezza: [0.8, 0.2],
                      allinea: [TextAlign.left, TextAlign.center],
                      stileTesto: [FontWeight.bold, FontWeight.bold],
                      colori: [Colors.black, Colors.black],
                      fSize: [12, 12],
                    ),
                  ),

                  SizedBox(height: 10.0),
                ],
              ),
            ),


            ListaProdotti(controller: controller),
          ],
        ) : const WidgetInCaricamento(),
      ),
    );
  }
}