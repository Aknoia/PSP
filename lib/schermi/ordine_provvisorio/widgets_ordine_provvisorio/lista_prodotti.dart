// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import '../../../defaultsWidgets/widget_colonne_testo.dart';
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';
import '../../../controllers/ordine_provvisorio_controller/ordine_provvisorio_controller.dart';
import '../../../defaultsWidgets/widget_in_caricamento.dart';
import '../../../defaultsWidgets/widget_ricerca_vuota.dart';

class ListaProdotti extends StatelessWidget {
  const ListaProdotti({Key? key, required this.controller}) : super(key: key);

  final OrdineProvController controller;

  @override
  Widget build(BuildContext context) {
    return controller.obx(
            (state) => (controller.listaOrdini.isEmpty) ? const RicercaVuota(messaggio: 'Nessun prodotto trovato') : Expanded(
              child: Scrollbar(
                thickness: 5,
                child: Obx(
                      () => ListView.builder(
                      itemCount: controller.listaOrdini.length,


                      itemBuilder: (context, index) {
                        String immagine = controller.listaOrdini[index].flag == 'V' ? 'disponibile.png' : 'ritardo.png';
                        Color colore = controller.listaOrdini[index].flag == 'V' ? Colors.green.shade800 : Colors.red.shade800;

                        return Card(
                          elevation: 5.0,

                          shape: kCardShape,

                          child: ListTile(
                            onTap: () async {
                              if (FocusManager.instance.primaryFocus!.hasFocus) {
                                FocusManager.instance.primaryFocus!.unfocus();
                              }


                              await Get.toNamed(
                                '/modificaordine',
                                arguments: [controller.listaOrdini, controller.listaGrossisti, index, 'N'],
                              )?.then((_) {

                                if (controller.ultimaOperazione.value == 1) {
                                  controller.avviaRicerca(controller.ctrlRicerca.text);
                                } else {
                                  controller.avviaRicerca('');
                                }
                              });
                            },

                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  alignment: Alignment.centerLeft,
                                  width: 0.6 * larghezzaSchermo - 15,

                                  child: AutoSizeText(
                                    controller.listaOrdini[index].descrizione,
                                    softWrap: false,
                                    textAlign: TextAlign.left,
                                    style: const TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold),
                                  ),
                                ),

                                Container(
                                  padding: const EdgeInsets.only(
                                    left: 10.0,
                                    right: 10.0,
                                  ),

                                  alignment: Alignment.center,

                                  child: Image.asset(
                                    'assets/defaultIcons/$immagine',
                                    color: colore,
                                  ),
                                ),

                                const Spacer(),

                                Container(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  alignment: Alignment.centerRight,

                                  child: AutoSizeText(
                                    'Quantità: ${controller.listaOrdini[index].quantita}',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 10.0, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),

                            subtitle: WidgetColonneTesto(
                              descrizioneColonne: ['Minsan: ${controller.listaOrdini[index].minsan}', 'Grossista: ${controller.listaOrdini[index].ditta}', 'Prezzo: ${controller.listaOrdini[index].prezzo}€'],
                              larghezza: const [0.3, 0.3, 0.3],
                              allinea: const [TextAlign.left, TextAlign.center, TextAlign.right],
                              stileTesto: const [FontWeight.w400, FontWeight.normal, FontWeight.normal],
                              colori: const [Colors.blueGrey, Colors.blueGrey, Colors.blueGrey],
                              fSize: const [10, 10, 10],
                            ),
                          ),
                        );
                      }
                  ),
                ),
              ),
            ),

      onEmpty: const RicercaVuota(messaggio: 'Nessun prodotto trovato'),
      onLoading: const WidgetInCaricamento(),
    );
  }
}
