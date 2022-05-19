// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:enum_to_string/enum_to_string.dart';

// Project imports:
import '../../../utils/enums.dart';
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';
import '../../../controllers/menu_statistiche_controller/menu_statistiche_controller.dart';


class DropDownTipologia extends StatelessWidget {
  const DropDownTipologia({Key? key, required this.controller}) : super(key: key);

  final MenuStatisticheController controller;

  @override
  Widget build(BuildContext context) {
    /// Creo la lista di valori del menu
    List<DropdownMenuItem<String>> valoriDropDownMenu = List.generate(
      TipoStatistica.values.length,
          (index) => DropdownMenuItem(
            value: EnumToString.convertToString(TipoStatistica.values[index]),

            child: Text(
              (EnumToString.convertToString(TipoStatistica.values[index])).replaceAll(RegExp(r'degrasi'), 'Degrassi'),
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

          Card(
            color: Get.theme.primaryColor,
            elevation: 0.0,

            child: Obx(
                  () => DropdownButton<String>(
                    value: EnumToString.convertToString(controller.tipoReport.value),


                    iconSize: 18.0,
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



                    onChanged: (String? nuovoTipoReport) {
                      controller.setTipoStatisticaController(nuovoTipoReport!);
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
