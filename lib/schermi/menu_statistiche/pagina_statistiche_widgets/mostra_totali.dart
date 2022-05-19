// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:enum_to_string/enum_to_string.dart';

// Project imports:
import '../../../../theme/shapes.dart';
import '../../../../theme/dimensioni.dart';
import '../../../../defaultsWidgets/widget_dati_vendite.dart';
import '../../../../controllers/menu_statistiche_controller/pagina_statistiche_controller.dart';

class MostraTotali extends StatelessWidget {
  const MostraTotali({Key? key, required this.controller}) : super(key: key);

  final PaginaStatisticheController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,

      color: Get.theme.scaffoldBackgroundColor,
      shape: kShapeOrdineProv,


      child: Column (
        children: <Widget> [
          const SizedBox(
            height: 15.0,
            width: 400.0,
          ),

          AutoSizeText(
            'Mese: ${controller.periodo.meseIn} - ${controller.periodo.meseOut} / ${controller.periodo.annoIn} per ${EnumToString.convertToString(controller.tipoStatistica)} :',
            maxFontSize: 20.0,
            minFontSize: 15.0,
            maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(
            height: 5.0,
            width: 400.0,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),

            child: WidgetDatiVendite(
              descrizione: 'Totale vendite:',
              valore: '${controller.statistiche[0].valoreVendutoComplessivo}',
              coloreDati: Colors.black,
              fSize: fontSizeMedio,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),

            child: WidgetDatiVendite(
              descrizione: 'Totale acquisti:',
              valore: '${controller.statistiche[0].valoreAcquistatoComplessivo}',
              coloreDati: Colors.black,
              fSize: fontSizeMedio,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),

            child: WidgetDatiVendite(
              descrizione: 'Totale pezzi venduti:',
              valore: '${controller.statistiche[0].pezziVendutiComplessivi}',
              coloreDati: Colors.black,
              fSize: fontSizeMedio,
              nonUsareEuro: true,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10.0),

            child: WidgetDatiVendite(
              descrizione: 'Totale pezzi acquistati:',
              valore: '${controller.statistiche[0].pezziAcquistatiComplessivi}',
              coloreDati: Colors.black,
              nonUsareEuro: true,
              fSize: fontSizeMedio,
            ),
          ),

          const SizedBox(
            height: 15.0,
            width: 400.0,
          ),
        ],
      ),
    );
  }
}
