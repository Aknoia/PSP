// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';


// Project imports:
import 'widgets/icona_commercio.dart';
import 'widgets/icona_dettagli.dart';
import 'widgets/icona_esaurimento.dart';
import '../../theme/shapes.dart';
import '../../theme/dimensioni.dart';
import '../../defaultsWidgets/widget_pulisci_controller.dart';
import '../../defaultsWidgets/widget_colonne_testo.dart';
import '../../defaultsWidgets/widget_in_caricamento.dart';
import '../../defaultsWidgets/widget_colonne.dart';
import '../../defaultFunctions/variabile_a_euro.dart';
import '../../controllers/zoom_controller/zoom_controller.dart';

class Zoom extends GetView<ZoomController> {
  const Zoom({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Get.put(ZoomController());

    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20.0),

          Image.asset(
            'assets/defaultIcons/cerca.png',
            scale: 1.5,
            color: Colors.green.shade800,
          ),

          Text(
            'Cerca Prodotti',
            style: TextStyle(
              fontSize: fontSizePiccolo,
            ),
          ),

          const SizedBox(height: 20.0),

          Padding(
            padding: const EdgeInsets.only(
              right: 5.0,
              left: 5.0,
            ),

            child: TextField(
              controller: controller.ctrlRicerca,

              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Get.theme.selectedRowColor,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: BorderSide(
                    width: 1.0,
                    color: Get.theme.selectedRowColor,
                  ),
                ),

                labelText: 'Cerca:',
                labelStyle: const TextStyle(color: Colors.black),

                hintText: 'immetti minsan o descrizione',

                prefixIcon: IconButton(
                  icon: Image.asset(
                    'assets/defaultIcons/fotocamera.png',
                    scale: 1.2,
                    color: Colors.green.shade800,
                  ),

                  onPressed: () async => controller.scannerizzaProdotto(),
                ),

                suffixIcon: IconaPulisciController(controller: controller.ctrlRicerca),
              ),

              onTap: () => controller.ctrlRicerca.clear(),

              onSubmitted: (ricerca) => (ricerca.isEmpty) ? controller.ctrlRicerca.text = 'Inserisci minsan o nome prodotto' : null,
            ),
          ),

          const SizedBox(height: 20.0),

          Card(
            elevation: 12.0,
            shape: kCardShape,


            child: Column(
              children: const <Widget>[

                SizedBox(height: 10.0),

                Padding(
                  padding: EdgeInsets.only(
                    bottom: 2.0,
                    left: 6.0,
                    right: 0.0,
                    top: 1.0,
                  ),

                  child: WidgetColonneTesto(
                    descrizioneColonne: ['Descrizione', 'Disponibilità'],
                    larghezza: [0.7, 0.2],
                    allinea: [TextAlign.left,TextAlign.center],
                    stileTesto: [FontWeight.bold, FontWeight.bold],
                    colori: [Colors.black, Colors.black],
                    fSize: [10, 10],
                  ),
                ),

                SizedBox(height: 10.0),
              ],
            ),
          ),

          controller.obx(
                  (state) => mostraProdottiTrovati(),

            onError: (errore) => Text(errore!),

            onLoading: const WidgetInCaricamento(),

            onEmpty: Card(
              elevation: 5.0,
              shape: kCardShape,

              child: ListTile(
                title: Column(
                  children: const <Widget>[
                    SizedBox(height: 5.0),

                    WidgetColonneTesto(
                      descrizioneColonne: ['Nessun prodotto', '0 Pz disponibili'],
                      larghezza: [0.6, 0.3],
                      allinea: [TextAlign.left, TextAlign.right],
                      stileTesto: [FontWeight.bold, FontWeight.bold],
                      colori: [Colors.black, Colors.black],
                      fSize: [15, 13],
                    ),

                    SizedBox(height: 5.0),
                  ],
                ),
              )
            )
          )
        ],
      )
    );
  }


  Widget mostraProdottiTrovati() {
    return Expanded(
      child: Obx(
        () => Scrollbar(
          child: ListView.builder(
            itemCount: controller.vendite.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 5.0,
                shape: kCardShape,

                child: Obx(
                    () => InkWell(
                      onTap: () {
                        if (controller.indiceSelezione == index) {
                          controller.indiceSelezione = -1;
                        } else {
                          controller.indiceSelezione = index;
                        }
                      },

                      child: ListTile(
                            title: Column(
                              children: <Widget>[
                                const SizedBox(height: 5.0),

                                WidgetColonneTesto(
                                  descrizioneColonne: [controller.vendite[index].descrizione, '${controller.vendite[index].disponibilita} Pz disponibili'],
                                  larghezza: const [0.6, 0.3],
                                  allinea: const [TextAlign.left, TextAlign.right],
                                  stileTesto: const [FontWeight.bold, FontWeight.bold],
                                  colori: const [Colors.black, Colors.black],
                                  fSize: const [15, 13],
                                ),

                                const SizedBox(height: 5.0),
                              ]
                            ),

                            subtitle: (index != controller.indiceSelezione)
                                ? WidgetColonneTesto(
                              descrizioneColonne: [controller.vendite[index].ragioneSociale, varToEuro(controller.vendite[index].prezzoCalc.toString())],
                              larghezza: const [0.6, 0.3],
                              allinea: const [TextAlign.left, TextAlign.right],
                              stileTesto: const [FontWeight.normal, FontWeight.normal],
                              colori: const [Colors.black, Colors.black],
                              fSize: const [12, 12],
                            ) : Column (
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: <Widget>[
                                WidgetColonneTesto(
                                  descrizioneColonne: [controller.vendite[index].descrizioneEstesa, 'IVA ${controller.vendite[index].codIVA}%'],
                                  larghezza: const [0.76, 0.15],
                                  allinea: const [TextAlign.left, TextAlign.right],
                                  stileTesto: const [FontWeight.normal, FontWeight.normal],
                                  colori: const [Colors.blueGrey, Colors.blueGrey],
                                  fSize: const [13, 13]
                                ),

                                const SizedBox(height: 5.0),

                                WidgetColonneTesto(
                                  descrizioneColonne: [controller.vendite[index].ragioneSociale, varToEuro(controller.vendite[index].prezzoCalc.toString())],
                                  larghezza: const [0.6, 0.3],
                                  allinea: const [TextAlign.left, TextAlign.right],
                                  stileTesto: const [FontWeight.normal, FontWeight.normal],
                                  colori: const [Colors.black, Colors.black],
                                  fSize: const [13, 13],
                                ),

                                const SizedBox(height: 10.0),

                                const WidgetColonneTesto(
                                  descrizioneColonne: ['IN COMMERCIO', 'ESAURIMENTO', 'DETTAGLIO'],
                                  larghezza: [0.25, 0.25, 0.25],
                                  allinea: [TextAlign.center, TextAlign.center, TextAlign.center],
                                  stileTesto: [FontWeight.w600, FontWeight.w600, FontWeight.w600],
                                  colori: [Colors.black, Colors.black, Colors.black],
                                  fSize: [12, 12, 12],
                                ),

                                WidgetColonne(
                                  widgets: [
                                  iconaCommercio(inCommercio: controller.vendite[index].inCommercio),
                                  iconaEsaurimento(esaurito: controller.vendite[index].esaurito),
                                  iconaDettagli(prodotto: controller.vendite[index]),
                                  ],

                                  larghezza: const [0.25, 0.25, 0.25],
                                ),
                              ],
                            ),
                        ),
                      ),
                  ),
              );
            },
          ),
        ),
      ),
    );
  }
}
