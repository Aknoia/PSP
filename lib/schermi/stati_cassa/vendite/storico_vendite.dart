// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'storico_widgets/widget_titolo.dart';
import 'storico_widgets/mostra_storico_vendite.dart';
import 'storico_widgets/espandi_vendite.dart';
import '../../../controllers/stati_cassa_controller/vendite_controller/storico_vendite_controller.dart';
import '../../../defaultFunctions/data_america_to_ita.dart';
import '../../../defaultsWidgets/widget_dati_vendite.dart';
import '../../../defaultsWidgets/widget_in_caricamento.dart';
import '../../../defaultsWidgets/widget_appbar_back.dart';
import '../../../modelli/storico_vendite.dart';
import '../../../theme/shapes.dart';
import '../../../theme/dimensioni.dart';

class StoricoVendite extends GetView<StoricoVenditeController> {
  const StoricoVendite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        leading: const AppbarBackButton(),

        title: Image.asset('assets/immagini/scritta.png'),
      ),

      body: Column(
        children: <Widget>[
          const SizedBox(height: 10.0),

          TitoloStorico(controller: controller),

          const SizedBox(height: 40.0),

          controller.obx(
                (state) => MostraStoricoVendite(controller: controller),

            onLoading: const WidgetInCaricamento(),

            onError: (errore) => Text(errore.toString()),

            onEmpty: const Center(
                child: AutoSizeText(
                  'Nessuna vendita effettuata',
                  minFontSize: 20.0,
                  maxFontSize: 30.0,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
            ),
          ),
        ],
      ),
    );
  }
}


class DettaglioRigheVenditeUtenti2 extends GetView<StoricoVenditeController> {
  const DettaglioRigheVenditeUtenti2({Key? key, required this.storicovendite, required this.nomeUtente}) : super(key: key);

  final List<TotaleStorico> storicovendite;

  final String nomeUtente;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        leading: const AppbarBackButton(),

        title: Image.asset('assets/immagini/scritta.png'),
      ),

      body: Column(
        children: <Widget>[
          const SizedBox(height: 10.0),

          Card(
            elevation: 10.0,
            margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 5.0, right: 5.0),


            color: Get.theme.scaffoldBackgroundColor,

            shape: kShapeDettVend,

            child: Column(
              children: <Widget>[
                const SizedBox(height: 10.0),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: <Widget>[

                    AutoSizeText(
                      'Vendite del ${dataAmericaToIta(storicovendite[0].dataStorico.toString().substring(0, 10))}',
                      minFontSize: 20,
                      maxFontSize: 25,
                      style: TextStyle(
                        fontSize: fontSizeGrande,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      'Utente: $nomeUtente',
                      style: TextStyle(fontSize: fontSizeMedio),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 10.0,
                  width: 400.0,
                ),
              ],
            ),
          ),

          const SizedBox(height: 15.0),

          Expanded(
            child: ListView.builder(
                itemCount: storicovendite.length,

                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.indiceElementoCliccato.value == index) {
                        controller.indiceElementoCliccato.value = -1;
                      } else {
                        controller.indiceElementoCliccato.value = index;
                      }
                    },

                    child: Card(
                      elevation: 5.0,
                      margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),

                      color: Get.theme.scaffoldBackgroundColor,

                      shape: kShapeDettVend,

                      child: ListTile(
                        leading: Image.asset(
                          'assets/defaultIcons/simbolo_euro.png',
                          color: Colors.green.shade600,
                        ),

                        title: Text(
                          'Ora: ${DateFormat('hh:mm').format(storicovendite[index].dettaglio[0].dataVendita)}',
                          style: TextStyle(fontSize: fontSizeMedio),
                        ),

                        subtitle: Obx(() => (controller.indiceElementoCliccato.value != index) ?
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: WidgetDatiVendite(
                              descrizione: 'Totale vendita:',
                              valore: '${storicovendite[index].importo}',
                              coloreDati: Colors.black,
                              nonUsareEuro: false,
                              fSize: fontSizePiccolo,
                            ),
                          ) : EspandiVendite(
                          vendite: storicovendite[index].dettaglio,
                          fontSize: fontSizeMedio,
                        ),
                      )),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}



// TODO
//  Widget _costruisciStoricoVendite() {
//    return ListView.builder(
//        shrinkWrap: true,
//        itemCount: controller.listaTotaliUtenti.length,
//
//        itemBuilder: (context, index) {
//          Utente utenteAttuale = controller.listaTotaliUtenti[index];
//          List<TotaleStorico> storicoAttuale = controller.storicoVenditeUtenti[index];
//
//          return GestureDetector (
//
//            onTap: () => Get.toNamed(
//              '/dettagliostoricoutente',
//              arguments: [storicoAttuale, utenteAttuale.descrizione],
//            ),
//
//            child: Card(
//              elevation: 5.0,
//              margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),
//
//              color: Get.theme.scaffoldBackgroundColor,
//              shape: kShapeDettVend,
//
//              child: ListTile(
//                contentPadding: const EdgeInsets.only(top: 10.0),
//
//                title: Row(
//                  children: <Widget>[
//                    const SizedBox(width: 15.0),
//
//                    Image.asset(
//                      'assets/defaultIcons/account_box.png',
//                      color: Colors.green.shade600,
//                    ),
//
//                    const SizedBox(width: 10.0),
//
//                    AutoSizeText(
//                      utenteAttuale.descrizione,
//                      minFontSize: 15.0,
//                      maxFontSize: 20.0,
//                      textAlign: TextAlign.center,
//                      style: const TextStyle(fontWeight: FontWeight.bold),
//                    ),
//
//                    const Spacer(),
//
//                    AutoSizeText(
//                      '${utenteAttuale.totaleVendite} €',
//                      minFontSize: 15.0,
//                      maxFontSize: 20.0,
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        fontSize: fontSizeGrande,
//                        fontWeight: FontWeight.w500
//                      ),
//                    ),
//
//                    const SizedBox(width: 20.0),
//                  ],
//                ),
//
//                subtitle: Column(
//                  children: <Widget>[
//
//                    barraColorataOrizzontale(
//                      altezza: 2.5,
//                      lunghezza: double.infinity,
//                      colore: Get.theme.selectedRowColor,
//                      bordi: const EdgeInsets.only(top: 10.0, bottom: 15.0),
//                    ),
//
//                    Padding(
//                      padding: const EdgeInsets.only(left: 15.0),
//                      child: WidgetDatiVendite(
//                        descrizione: 'Numero vendite:',
//                        valore: utenteAttuale.numeroVendite.toString(),
//                        coloreDati: Colors.black,
//                        nonUsareEuro: true,
//                        fSize: 18.0,
//                      ),
//                    ),
//
//                    const SizedBox(height: 5.0),
//
//                    Padding(
//                      padding: const EdgeInsets.only(left: 15.0),
//                      child: WidgetDatiVendite(
//                        descrizione: 'Durata lavoro:',
//                        valore: utenteAttuale.tempoLavorato,
//                        coloreDati: Colors.black,
//                        nonUsareEuro: true,
//                        soloStringhe: true,
//                        fSize: 18.0,
//                      ),
//                    ),
//
//                    const SizedBox(height: 5.0),
//
//                    Padding(
//                      padding: const EdgeInsets.only(left: 15.0),
//                      child: WidgetDatiVendite(
//                        descrizione: 'Vendite al minuto:',
//                        valore: (utenteAttuale.totaleMinuti / utenteAttuale.numeroVendite).toString(),
//                        coloreDati: Colors.black,
//                        nonUsareEuro: true,
//                        digits: 1,
//                        fSize: 18.0,
//                      ),
//                    ),
//
//                    const SizedBox(height: 5.0),
//
//                    Padding(
//                      padding: const EdgeInsets.only(left: 15.0),
//                      child: WidgetDatiVendite(
//                        descrizione: 'Orario prima vendita:',
//                        valore: DateFormat('hh:MM').format(storicoAttuale[storicoAttuale.length - 1].dataStorico),
//                        fSize: 18.0,
//                        coloreDati: Colors.black,
//                        nonUsareEuro: true,
//                        soloStringhe: true,
//                      ),
//                    ),
//
//                    const SizedBox(height: 5.0),
//
//                    Padding(
//                      padding: const EdgeInsets.only(left: 15.0),
//                      child: WidgetDatiVendite(
//                        descrizione: 'Orario ultima vendita:',
//                        valore: DateFormat('hh:MM').format(storicoAttuale[0].dataStorico),
//                        coloreDati: Colors.black,
//                        nonUsareEuro: true,
//                        soloStringhe: true,
//                        fSize: 18.0,
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          );
//        }
//    );
//  }
// }

