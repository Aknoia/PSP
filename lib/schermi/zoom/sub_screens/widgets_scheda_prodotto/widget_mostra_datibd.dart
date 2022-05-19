// Flutter imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// Package imports:
import 'package:get/get.dart';

import '../../../../controllers/scheda_prodotto_controller/scheda_prodotto_controller.dart';
import '../../../../defaultFunctions/data_america_to_ita.dart';
import '../../../../defaultFunctions/prendi_int.dart';
import '../../../../defaultFunctions/variabile_a_euro.dart';
import '../../../../defaultsWidgets/widget_in_caricamento.dart';
// Project imports:
import '../../../../theme/shapes.dart';




class MostraDatiBD extends StatelessWidget {
  const MostraDatiBD({Key? key,required this.controller}) : super(key: key);

  final SchedaProdottoController controller;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => ListView(
        children: [

          /// primo blocco di informazioni (immagine, minsan, ean)
          widgetImmagineDati(),

          /// Secondo blocco di informazioni (giacienze, costi)
          widgetGiacienzeCosti(),


          /// Terzo blocco informazioni (categoria farmaco)
          widgetCategorieFarmaco(),
        ],
      ),

      onLoading: const WidgetInCaricamento(),
      onError: (errore) => Text('$errore'),
    );
  }


  Widget widgetImmagineDati() {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      shape: kShapeSchedaProd,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: <Widget>[

          const SizedBox(height: 20.0),

          SelectableText(
            controller.prodotto.descrizioneEstesa,
            textAlign: TextAlign.center,

            style: const TextStyle(fontWeight: FontWeight.bold),
          ),

          (controller.immagineProdotto.isNotEmpty)
              ? Image.network(controller.immagineProdotto.value, height: 100.0)
              : SizedBox(
                  height: 100,
                  child: Image.asset(
                    'assets/defaultIcons/immagine_default.png',
                    color: Get.theme.selectedRowColor,
                  ),
                ),

          ListTile(
            title: AutoSizeText(
              'Minsan: ${controller.prodotto.minsan}',
              maxLines: 1,
              minFontSize: 15.0,
              maxFontSize: 20.0,
              textAlign: TextAlign.left,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),

            subtitle: AutoSizeText(
              'EAN: ${controller.prodotto.codiceEAN}',
              maxLines: 1,
              minFontSize: 15.0,
              maxFontSize: 20.0,
              style: const TextStyle(fontWeight: FontWeight.w400)
            ),
          ),

          ListTile(
            title: const AutoSizeText(
              'Ragione sociale: ',
              maxLines: 1,
              minFontSize: 15.0,
              maxFontSize: 20.0,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            subtitle: AutoSizeText(
              controller.prodotto.ragioneSociale,
              maxLines: 1,
              minFontSize: 15.0,
              maxFontSize: 20.0,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }





  Widget widgetGiacienzeCosti() {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      shape: kShapeSchedaProd,

      child: Column(
        children: <Widget>[
          ListTile(
            title: AutoSizeText(
              'Prezzo farmacia: ${varToEuro(controller.prodotto.prezzoCalc.toString())}',
              maxLines: 1,
              minFontSize: 15.0,
              maxFontSize: 20.0,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),

            subtitle: AutoSizeText(
              'dal: ${dataAmericaToIta(controller.prodotto.dataCalcoloPrezzoFarm)}',
              maxLines: 1,
              minFontSize: 15.0,
              maxFontSize: 20.0,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),

            leading: Image.asset(
              'assets/defaultIcons/offerta.png',
              color: Colors.green.shade800,
            ),
          ),

          ListTile(
            title: AutoSizeText(
              'Prezzo banca dati: ${controller.prodotto.prezzoBancaDati}€',
              maxLines: 1,
              minFontSize: 15.0,
              maxFontSize: 20.0,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),

            subtitle: AutoSizeText(
              'dal: ${dataAmericaToIta(controller.prodotto.dataCalcoloBD)}',
              maxLines: 1,
              minFontSize: 15.0,
              maxFontSize: 20.0,
              style: const TextStyle(fontWeight: FontWeight.w400),
            ),

            leading: Image.asset(
              'assets/defaultIcons/euro.png',
              color: Colors.green.shade800,
            ),
          ),

          ListTile(
            title: Row(
              children: <Widget>[
                const AutoSizeText(
                  'Giacenza: ',
                  maxLines: 1,
                  minFontSize: 15.0,
                  maxFontSize: 20.0,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                AutoSizeText(
                  '${prendiInt(controller.prodotto.disponibilita.toString())}',
                  maxLines: 1,
                  minFontSize: 15.0,
                  maxFontSize: 20.0,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),

            leading: Image.asset(
              'assets/defaultIcons/lista_numerata.png',
              color: Colors.green.shade800,
            ),
          ),

          ListTile(
            title: Row(
              children: <Widget>[
                const AutoSizeText(
                  'Giacenza Robot: ',
                  maxLines: 1,
                  minFontSize: 15.0,
                  maxFontSize: 20.0,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),

                AutoSizeText(
                  '${controller.prodotto.giacenzaRobot}',
                  maxLines: 1,
                  minFontSize: 15.0,
                  maxFontSize: 20.0,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),

              ],
            ),

            leading: Image.asset(
              'assets/defaultIcons/robot.png',
              color: Colors.green.shade800,
            ),
          ),
        ],
      ),
    );
  }




  Widget widgetCategorieFarmaco() {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
      shape: kShapeSchedaProd,

      child: Column(
        children: <Widget>[

          const SizedBox(height: 10.0),

          ListTile(
            title: const AutoSizeText(
              'ATC:',
              maxLines: 1,
              minFontSize: 20.0,
              maxFontSize: 25.0,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            subtitle: Column(
              children: <Widget>[

                AutoSizeText(
                  controller.prodotto.codiceFarmaco1,
                  maxLines: 1,
                  minFontSize: 15.0,
                  maxFontSize: 20.0,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),

                AutoSizeText(
                  controller.prodotto.codiceFarmaco2,
                  maxLines: 1,
                  minFontSize: 15.0,
                  maxFontSize: 20.0,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),

                AutoSizeText(
                  controller.prodotto.codiceFarmaco3,
                  maxLines: 1,
                  minFontSize: 15.0,
                  maxFontSize: 20.0,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),

                AutoSizeText(
                  controller.prodotto.codiceFarmaco4,
                  maxLines: 1,
                  minFontSize: 15.0,
                  maxFontSize: 20.0,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),

                AutoSizeText(
                  controller.prodotto.codiceFarmaco5,
                  maxLines: 1,
                  minFontSize: 15.0,
                  maxFontSize: 20.0,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
