// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'menu_widgets/dropdown_tipologia.dart';
import 'menu_widgets/dropdown_anno.dart';
import 'menu_widgets/dropdown_mese.dart';
import '../../controllers/menu_statistiche_controller/menu_statistiche_controller.dart';
import '../../theme/dimensioni.dart';
import '../../theme/shapes.dart';


class MenuStatistiche extends GetView<MenuStatisticheController> {
  const MenuStatistiche({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MenuStatisticheController());

    return Center(
      child: Column (
        children: <Widget>[

          /// Spacer
          const SizedBox(height: 20.0),

          Image.asset('assets/icone/Statistiche.ico'),

          /// Titolo
          Text(
            'Statistiche',
            style: TextStyle(fontSize: fontSizePiccolo),
          ),

          /// Spacer
          const SizedBox(height: 10.0),

          /// DropDown 1
          DropDownTipologia(controller: controller),

          /// Spacer
          const SizedBox(height: 50.0),

          /// DropDown 2
          DropDownAnno(controller: controller),

          /// Spacer
          const SizedBox(height: 10.0),

          /// DropDown 3
          DropDownMese(controller: controller, id: 1),

          /// Spacer
          const SizedBox(height: 10.0),

          /// DropDown 4
          DropDownMese(controller: controller, id: 2),

          const SizedBox(height: 70.0),

          SizedBox(
            child: Column (
              children: <Widget>[
                SizedBox(
                  width: 300.0,
                  child: Card(
                    shape: kCardAdvisor1,

                    child: ListTile(
                      title: const AutoSizeText(
                        'ELABORA',
                        textAlign: TextAlign.center,
                        maxFontSize: 25.0,
                        minFontSize: 15.0,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      onTap: () => Get.toNamed(
                          '/paginastatistiche',
                          arguments: [controller.dataSelezionata.value, controller.tipoReport.value],
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}