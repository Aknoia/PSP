// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'widgets/widget_info_intervallo_cassa.dart';
import 'widgets/widget_popup_menu_cassa.dart';
import '../../schermi/stati_cassa/widgets/widget_lista_vendite.dart';
import '../../theme/dimensioni.dart';
import '../../utils/enums.dart';
import '../../defaultsWidgets/widget_percentuale.dart';
import '../../defaultsWidgets/widget_in_caricamento.dart';
import '../../controllers/stati_cassa_controller/stati_cassa_controller.dart';


class StatiCassa extends GetView<StatiCassaController> {
  const StatiCassa({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => StatiCassaController());
    
    return controller.obx(
      (_) => Column(
        children: <Widget>[
          InfoIntervalloCassa(controller: controller),

          const SizedBox(height: 5.0),

          PopupMenuCassa(controller: controller),

          Obx(
                () => Container(
                  margin: const EdgeInsets.only(bottom: 20.0),
                  child: percentuale(
                    controller.venditePrecedenti[controller.indiceSelezionato]['descr'],
                    controller.venditePrecedenti[controller.indiceSelezionato]['valore'].replaceAll(RegExp(r'Giorni Lavorati'), ''),
                    controller.vendite[controller.indiceSelezionato]['valore'].replaceAll(RegExp(r'Giorni Lavorati'), ''),
                    fsize: fontSizeMedio,
                    confrontare: (controller.tempoReport == TempoReport.intervallo),
                  ),
                ),
          ),

          const SizedBox(height: 5.0),

          ListaVendite(controller: controller),
        ],
      ),

      onLoading: const WidgetInCaricamento(),
    );
  }




  // TODO
  // Widget mostraDatiVendite() {
  //   return
  // }
}