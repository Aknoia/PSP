// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/menu_statistiche_controller/pagina_statistiche_controller.dart';

class ColonnaFiltroRicerca extends StatelessWidget {
  const ColonnaFiltroRicerca({Key? key, required this.controller}) : super(key: key);

  final PaginaStatisticheController controller;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            const Text('Ordina per:  Valore'),

            Obx(
                  () => Switch(
                value: controller.ordinaMargine.value,

                /// Colori
                activeColor: Colors.green.shade800,
                inactiveTrackColor: Colors.red.shade200,
                inactiveThumbColor: Colors.red.shade800,

                onChanged: (valore) {
                  controller.ordinaMargine.value = valore;
                  if (controller.ordinaMargine.value) {
                    controller.statistiche.sort((b, a) => a.margine.compareTo(b.margine));
                  } else {
                    controller.statistiche.sort((b, a) => double.parse(a.totaleVenduto).compareTo(double.parse(b.totaleVenduto)));
                  }

                },
              ),
            ),

            const Text('Margine'),
          ],
        ),

        Padding(
          padding: const EdgeInsets.only(
            left: 5.0,
            right: 5.0,
          ),

          child: TextField(
            controller: controller.ctrlFiltro,

            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Get.theme.selectedRowColor),
              ),

              labelText: 'Filtro:',
              hintText: 'immetti un filtro di ricerca',
              prefixText: ' ',

              prefixIcon: Image.asset(
                'assets/defaultIcons/lista_filtri.png',
                scale: 1.5,
                color: Get.theme.selectedRowColor,
              ),

              enabledBorder:  OutlineInputBorder(
                borderSide:  BorderSide(
                  color: Get.theme.selectedRowColor,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
