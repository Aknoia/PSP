// Flutter import:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../controllers/advisor_controller/advisor_menu_controller.dart';
import '../../theme/dimensioni.dart';
import '../../theme/shapes.dart';
import '../../defaultsWidgets/widget_dati_vendite.dart';

class AdvisorMenu extends GetView<AdvisorController> {
  const AdvisorMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(AdvisorController());

    return Center(
      child: Column (
        children: <Widget>[

          const SizedBox(height: 20.0),

          Image.asset('assets/icone/advisor.ico'),

          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: AutoSizeText(
              'Advisor di Gestione',
              minFontSize: 20.0,
              maxFontSize: 25.0,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 80.0),


          SizedBox(
            child: Column (
              children: <Widget>[
                SizedBox(
                  width: 300.0,
                  child: Card(
                    shape: kCardAdvisor1,

                    child: ListTile(
                      leading: SizedBox(
                        width: 36.0,
                        height: 36.0,

                        child: Image.asset(
                          'assets/icone/sospesi.ico',
                          scale: 0.5,
                        ),
                      ),

                      title: Obx(
                          () => WidgetDatiVendite(
                            descrizione: (controller.sospesi.value == '-1') ? 'Sospesi' : 'Sospesi aperti: ${controller.sospesi}',
                            valore: '',
                            coloreDati: Colors.black,
                            nonUsareEuro: true,
                            digits: 0,
                            fSize: fontSizePiccolo / 1.2,
                            wait: (controller.status.isLoading),
                            soloStringhe: true
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 300.0,
                  child: Card(
                    shape: kCardAdvisor1,

                    child: ListTile(
                      leading: SizedBox(
                        width: 36.0,
                        height: 36.0,

                        child: Image.asset(
                          'assets/icone/prenota.ico',
                          scale: 0.5,
                        ),
                      ),

                      title: Obx(
                          () => WidgetDatiVendite(
                            descrizione: (controller.prenotazioni.value == '-1') ? 'Prenotati' : 'Prenotazioni: ${controller.prenotazioni}',
                            valore: '',
                            coloreDati: Colors.black,
                            nonUsareEuro: true,
                            digits: 0,
                            fSize: fontSizePiccolo / 1.2,
                            wait: (controller.status.isLoading),
                            soloStringhe: true
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  width: 300.0,
                  child: Card(
                    shape: kCardAdvisor1,

                    child: ListTile(
                      title: const AutoSizeText(
                        'Giacenze Rettificate',
                        minFontSize: 10,
                        maxFontSize: 14,
                        maxLines: 1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),

                      leading: SizedBox(
                        width: 36.0,
                        height: 36.0,

                        child: Image.asset(
                          'assets/icone/giacenze.ico',
                          scale: 0.5,
                        ),
                      ),

                      trailing: Image.asset(
                        'assets/defaultIcons/freccia_destra.png',
                        scale: 2,
                        color: Colors.green.shade800,
                      ),

                      onTap: () => Get.toNamed('/giacRettificate'),
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