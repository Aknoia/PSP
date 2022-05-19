// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

//  Project imports:
import '../../../../controllers/scheda_prodotto_controller/scheda_prodotto_controller.dart';
import '../../../../theme/dimensioni.dart';
import '../../../../theme/shapes.dart';
import '../../../../defaultsWidgets/widget_colonne_testo.dart';
import '../../../../defaultsWidgets/widget_in_caricamento.dart';


class PrendiInformazioniProdotto extends StatelessWidget {
  const PrendiInformazioniProdotto({Key? key,required this.controller}) : super(key: key);

  final SchedaProdottoController controller;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[

          widgetPostIt(),

          Divider(
            color: Colors.grey.shade400,
            thickness: 2,
          ),

          widgetGenerici(),
        ],
      ),

      onLoading: const WidgetInCaricamento(),
      onError: (errore) => Text('$errore'),
    );
  }



  Widget widgetPostIt() {
    //RxList<PostIT> postIt = RxList<PostIT>(controller.infoProdotto[0]);

    return Container(
      margin: const EdgeInsets.all(8.0),
      width: larghezzaSchermo,

      child: Center(
        child: ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              IconButton(
                icon: Image.asset(
                  'assets/defaultIcons/cerchio_aggiungi.png',
                  scale: 1.5,
                  color: Colors.green.shade800,
                ),

                tooltip: 'Aggiungi un PostIt',

                onPressed: () => Get.toNamed(
                    '/inseriscipostit',
                    arguments: [controller.prodotto.minsan, controller.prodotto.descrizione],
                  )?.then((_) => controller.leggiStatistiche()),
              ),

              const AutoSizeText(
                'PostIt',
                maxLines: 1,
              ),

              IconButton(
                  icon: Image.asset(
                    'assets/defaultIcons/cerchio_aggiungi.png',
                    scale: 1.5,
                    color: Colors.green.shade800,
                  ),

                  tooltip: 'Aggiungi un PostIt',

                  onPressed: () => Get.toNamed(
                        '/inseriscipostit',
                        arguments: [controller.prodotto.minsan, controller.prodotto.descrizione])
                    ?.then((_) => controller.leggiStatistiche()
                  ),
              ),
            ],
          ),

          subtitle: controller.obx(
              (state) => (controller.infoProdotto[0].isNotEmpty) ? SizedBox(
                height: altezzaSchermo / 3.8,

                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.infoProdotto[0].length,
                    itemBuilder: (context, index) => Card(
                      elevation: 5.0,
                      shape: kShapeOrdineProv,
                      child: Obx(
                        () => InkWell(
                          onTap: () {
                            if (controller.postItSelezionato == index) {
                              controller.postItSelezionato = -1;
                            } else {
                              controller.postItSelezionato = index;
                            }
                          },

                          child: ListTile(
                            contentPadding: const EdgeInsets.only(top: 10.0),

                            title: AutoSizeText(
                              'Progressivo: ${controller.infoProdotto[0][index].progressivo} - ${controller.infoProdotto[0][index].data}',
                              maxLines: 1,
                              minFontSize: 15.0,
                              maxFontSize: 20.0,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),

                           subtitle: controller.postItSelezionato != index ? const SizedBox() :
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: <Widget>[
                                AutoSizeText.rich(
                                  TextSpan(
                                    text: 'Utente: ',
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                    children: [TextSpan(text: controller.infoProdotto[0][index].utente, style: const TextStyle(fontWeight: FontWeight.w400))],
                                  ),

                                  maxLines: 1,
                                  minFontSize: 15.0,
                                  maxFontSize: 20.0,
                                  textAlign: TextAlign.center,
                                ),

                                AutoSizeText.rich(
                                  TextSpan(
                                    text: 'Note: ',
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                    children: [TextSpan(text: controller.infoProdotto[0][index].nota, style: const TextStyle(fontWeight: FontWeight.w400))],
                                  ),

                                  maxLines: 1,
                                  minFontSize: 15.0,
                                  maxFontSize: 20.0,
                                  textAlign: TextAlign.center,
                                ),

                                AutoSizeText.rich(
                                  TextSpan(
                                    text: 'Rif: ',
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                    children: [TextSpan(text: controller.infoProdotto[0][index].riferimento,  style: const TextStyle(fontWeight: FontWeight.w400))],
                                  ),

                                  maxLines: 1,
                                  minFontSize: 15.0,
                                  maxFontSize: 20.0,
                                  textAlign: TextAlign.center,
                                ),

                                AutoSizeText.rich(
                                  TextSpan(
                                    text: 'Cliente: ',
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                    children: [TextSpan(text: controller.infoProdotto[0][index].cliente, style: const TextStyle(fontWeight: FontWeight.w400))],
                                  ),

                                  maxLines: 1,
                                  minFontSize: 15.0,
                                  maxFontSize: 20.0,
                                  textAlign: TextAlign.center,
                                ),

                                AutoSizeText.rich(
                                  TextSpan(
                                    text: 'Telefono: ',
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                    children: [TextSpan(text: controller.infoProdotto[0][index].telefono, style: const TextStyle(fontWeight: FontWeight.w400))],
                                  ),

                                  maxLines: 1,
                                  minFontSize: 15.0,
                                  maxFontSize: 20.0,
                                  textAlign: TextAlign.center,
                                ),

                                const SizedBox(height: 10.0),

                                controller.infoProdotto[0][index].attiva          ? const AutoSizeText('PostIt Attivo', minFontSize: 15.0, maxFontSize: 20.0,)     : const Text('PostIt NON attivo'),
                                controller.infoProdotto[0][index].prenotato       ? const AutoSizeText('Prenotato', minFontSize: 15.0, maxFontSize: 20.0,)         : const SizedBox(),
                                controller.infoProdotto[0][index].sospeso         ? const AutoSizeText('Sospeso', minFontSize: 15.0, maxFontSize: 20.0,)           : const SizedBox(),
                                controller.infoProdotto[0][index].mancataVendita  ? const AutoSizeText('Mancata vendita!', minFontSize: 15.0, maxFontSize: 20.0,)  : const SizedBox(),
                              ],
                            ),

                            onTap: () {
                              if (controller.postItSelezionato == index) {
                                controller.postItSelezionato = -1;
                              } else {
                                controller.postItSelezionato = index;
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ) : const Center(child: Text('Nessun postit da visualizzare')),

            onError: (errore) => Text('$errore'),
            onLoading: const WidgetInCaricamento(),
          ),
        ),
      ),
    );
  }






  Widget widgetGenerici() {
    var generici = controller.infoProdotto[1];

    return Expanded(
      child: Center(
        child : ListTile(
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/icone/generici.ico',
                  width: 20,
                  height: 20,
                  color: Colors.green.shade800,
                ),

                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: AutoSizeText(
                    'Generici',
                    maxLines: 1,
                  ),
                ),

                Image.asset(
                  'assets/icone/generici.ico',
                  width: 20,
                  height: 20,
                  color: Colors.green.shade800,
                ),
              ]
          ),

          subtitle: generici.isEmpty ? const Center(child: Text('Nessun generico trovato')) :
          ListView.builder(
            shrinkWrap: true,
            itemCount: generici.length,
            itemBuilder: (context, index) => Card(
              shape: kShapeOrdineProv,

              child: ListTile(
                  title: WidgetColonneTesto(
                    descrizioneColonne: ['Minsan: ${generici[index].minsan}', generici[index].descrizione],
                    larghezza: const [0.30, 0.45],
                    allinea: const [TextAlign.left, TextAlign.right],
                    stileTesto: const[FontWeight.normal, FontWeight.bold],
                    colori: const [Colors.black, Colors.black],
                    fSize: const [12, 10],
                  ),

                  subtitle: WidgetColonneTesto(
                    descrizioneColonne: ['Costo unitario: ${generici[index].prezzoCalc}€', '${generici[index].qtaMagazzino} Pezzi disponibili'],
                    larghezza: const [0.30, 0.45],
                    allinea: const [TextAlign.left, TextAlign.right],
                    stileTesto: const [FontWeight.normal, FontWeight.normal],
                    colori: const [Colors.black, Colors.black],
                    fSize: const [10, 10],
                  ),

                  onTap: () => Get.toNamed(
                      '/inseriscipostit',
                      arguments: [generici[index].minsan, generici[index].descrizione],
                  )!.then((value) => controller.leggiStatistiche()),
              ),
            ),
          ),
        ),
      ),
    );
  }
}