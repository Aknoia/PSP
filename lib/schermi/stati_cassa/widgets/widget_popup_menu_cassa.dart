// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/stati_cassa_controller/stati_cassa_controller.dart';
import '../../../utils/enums.dart';

class PopupMenuCassa extends StatelessWidget {
  const PopupMenuCassa({Key? key, required this.controller}) : super(key: key);

  final StatiCassaController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        PopupMenuButton<int>(
          onSelected: (int value) {
            if (value == 1) {

              Get.toNamed('/storicovendite');

            } else {

              Get.toNamed('/venditeutenti', arguments: controller.giorniPeriodo[0]);

            }
          },

          child: Image.asset(
            'assets/defaultIcons/kebab_menu.png',
            scale: 1.8,
          ),

          itemBuilder: (BuildContext context) => (controller.tempoReport == TempoReport.giorno) ? <PopupMenuEntry<int>>[

            const PopupMenuItem<int>(
              value: 1,
              child: Text('Storico Vendite giornata'),
            ),

            const PopupMenuItem<int>(
              value: 2,
              child: Text('Dettaglio per utente'),
            ),

          ] :

          <PopupMenuEntry<int>>[
            const  PopupMenuItem<int>(
              value: 2,
              child: Text('Dettaglio per utente'),
            ),
          ],

        ),

        const SizedBox(width: 15.0),
      ],
    );
  }
}