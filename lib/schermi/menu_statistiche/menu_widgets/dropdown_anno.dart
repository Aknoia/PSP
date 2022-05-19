// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/menu_statistiche_controller/menu_statistiche_controller.dart';
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';

class DropDownAnno extends StatelessWidget {
  const DropDownAnno({Key? key, required this.controller}) : super(key: key);

  final MenuStatisticheController controller;

  @override
  Widget build(BuildContext context) {
    /// Creo la lista di valori del menu
    List<DropdownMenuItem<String>> valoriDropDownMenu = List.generate(
      controller.dataSelezionata.value.tipiAnno!.length,
          (index) => DropdownMenuItem(
            value: controller.dataSelezionata.value.tipiAnno![index],
            child: Text(
              controller.dataSelezionata.value.tipiAnno![index],
              style: TextStyle(
                fontSize: fontSizePiccolo / 1.5,
                color: Colors.black,
              ),
            ),
          ),
    );


    return Container(
      width: 300.0,
      decoration:  ShapeDecoration(shape: kCardAdvisor1),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Text(
            'DA ANNO: ',
            style: TextStyle(
              fontSize: fontSizePiccolo / 1.3,
            ),
          ),

          Card(
            elevation: 0.0,
            color: Get.theme.primaryColor,

            child: Obx(
                  () => DropdownButton<String>(
                    value: controller.annoIn.value,

                    iconSize: 24.0,
                    elevation: 16,
                    icon: Image.asset(
                      'assets/defaultIcons/doppia_freccia_sotto.png',
                      scale: 2,
                      color: Colors.green.shade800,
                    ),

                    underline: Container(
                      height: 2.0,
                      color: Get.theme.selectedRowColor,
                    ),


                    onChanged: (String? annoIn) {
                      controller.setAnnoInController(annoIn!);
                    },


                    items: valoriDropDownMenu,
              ),
            ),
          ),
        ],
      ),
    );
  }
}