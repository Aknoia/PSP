// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import '../../../controllers/ordine_provvisorio_controller/ordine_provvisorio_controller.dart';
import '../../../theme/shapes.dart';

class ListaGrossisti extends StatelessWidget {
  const ListaGrossisti({Key? key, required this.controller}) : super(key: key);

  final OrdineProvController controller;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 2,

      child: ListView.builder(
        shrinkWrap: true,
        itemCount: controller.listaGrossisti.length + 1,

        itemBuilder: (context, index) {
          return Card(
            shape: kCardShape,
            child: Obx(
                  () => CheckboxListTile(
                    selected: false,
                    checkColor: Colors.white,
                    activeColor: Colors.green.shade600,

                    title: AutoSizeText(
                      (index == 0) ? 'Seleziona Tutti: ' : 'Grossista',
                      textAlign: TextAlign.center,
                      minFontSize: 18.0,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold
                      ),
                    ),

                    subtitle: (index == 0) ? null : AutoSizeText('${controller.listaGrossisti[index - 1]}', textAlign: TextAlign.center, minFontSize: 16.0),

                    value: controller.grossistiSelezionati.contains((index == 0) ? 'tutti' : '${controller.listaGrossisti[index - 1]}'),

                    onChanged: (valore) => controller.modificaCheckBox(index, valore),
                  ),
            ),
          );
        },
      ),
    );
  }
}
