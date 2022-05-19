// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/stati_cassa_controller/stati_cassa_controller.dart';
import '../../../defaultsWidgets/widget_dati_vendite.dart';
import '../../../defaultsWidgets/widget_dettaglio_vendite_confronto.dart';
import '../../../utils/enums.dart';
import '../../../theme/shapes.dart';
import '../../../theme/dimensioni.dart';


class ListaVendite extends StatelessWidget {
  const ListaVendite({Key? key, required this.controller}) : super(key: key);

  final StatiCassaController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: controller.vendite.length,
        itemBuilder: (context, index) => Card(
          elevation: 2.0,
          shape: kCardShape,

          child: ListTile(
            title: Column(
              children: <Widget>[

                Obx(
                      () => WidgetDatiVendite(
                        descrizione: controller.vendite[index]['descr'],
                        valore: controller.vendite[index]['valore'].replaceAll(RegExp(r'Giorni Lavorati'), ''),
                        coloreDati: Colors.black,
                        nonUsareEuro: controller.vendite[index]['descr'].toLowerCase().contains('num') || controller.vendite[index]['descr'].contains('%'),
                        fSize: fontSizeMedio,
                      ),
                ),

                (controller.tempoReport == TempoReport.intervallo) ? const SizedBox() :

                Obx(
                      () => WidgetDatiVenditeConfronto(
                        vecchioValore: controller.venditePrecedenti[index]['valore'].replaceAll(RegExp(r'Giorni Lavorati'), ''),
                        nuovoValore: controller.vendite[index]['valore'].replaceAll(RegExp(r'Giorni Lavorati'), ''),
                        nonUsareEuro: controller.vendite[index]['descr'].toLowerCase().contains('num') || controller.vendite[index]['descr'].contains('%'),
                        usaPercentuale: controller.vendite[index]['descr'].contains('%'),
                        cifre: controller.vendite[index]['descr'].toLowerCase().contains('num') ? 0 : 2,
                        fSize: fontSizeMedio,
                      ),
                ),
              ],
            ),

            onTap: () => controller.indiceSelezionato = index,
          ),
        ),
      ),
    );
  }
}