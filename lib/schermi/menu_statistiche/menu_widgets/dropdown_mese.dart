// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:enum_to_string/enum_to_string.dart';

// Project imports:
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';
import '../../../controllers/menu_statistiche_controller/menu_statistiche_controller.dart';


class DropDownMese extends StatelessWidget {
  const DropDownMese({Key? key, required this.controller, required this.id}) : super(key: key);

  final int id;

  final MenuStatisticheController controller;

  @override
  Widget build(BuildContext context) {
    /// Creo la lista di valori del menu
    List<DropdownMenuItem<String>> valoriDropDownMenu = List.generate(
      controller.dataSelezionata.value.tipiMesi!.length,
          (index) =>
          DropdownMenuItem(
            value: controller.dataSelezionata.value.tipiMesi![index],

            child: Text(
              controller.dataSelezionata.value.tipiMesi![index],
              style: TextStyle(
                fontSize: fontSizePiccolo / 1.5,
                color: Colors.black,
              ),
            ),
          ),
    );


    return Container(
      width: 300.0,
      decoration: ShapeDecoration(
        shape: kCardAdvisor1,
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Text(
            (id == 1) ? 'DA MESE: ' : 'A MESE',
            style: TextStyle(
              fontSize: fontSizePiccolo / 1.3,
            ),
          ),

          Card(
            color: Get.theme.primaryColor,
            elevation: 0.0,
            child: Obx(
                  () =>
                  DropdownButton<String>(
                    value: EnumToString.convertToString((id == 1) ? controller.meseIn.value : controller.meseOut.value),


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


                    onChanged: (String? meseIn) {
                      (id == 1) ? controller.setMeseInController(meseIn!) : controller.setMeseOutController(meseIn!);
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