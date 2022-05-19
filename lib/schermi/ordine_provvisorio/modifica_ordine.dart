// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:swipe/swipe.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'widgets_modifica_ordine/seconda_riga_informazioni.dart';
import 'widgets_modifica_ordine/prima_riga_informazioni.dart';
import 'widgets_modifica_ordine/tasto_mostra_generici.dart';
import 'widgets_modifica_ordine/tabella_offerte.dart';
import 'widgets_modifica_ordine/tabella_statistiche.dart';
import '../../theme/shapes.dart';
import '../../defaultsWidgets/widget_appbar_back.dart';
import '../../defaultsWidgets/widget_in_caricamento.dart';
import '../../controllers/ordine_provvisorio_controller/modifica_ordine_controller.dart';


class PaginaModificaOrdine extends GetView<ModificaOrdineController> {
  const PaginaModificaOrdine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return controller.obx(
      (state) => Swipe(
        onSwipeRight: () => controller.swipeDestro(),

        onSwipeLeft: () => controller.swipeSinistro(),

        child: Scaffold(
          appBar: AppBar(

            centerTitle: true,

            leading: const AppbarBackButton(),

            title: Image.asset('assets/immagini/scritta.png'),
          ),


          body: SingleChildScrollView(
            controller: controller.ctrlScroll,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                const SizedBox(height: 40.0),

                /// Mostra descrizione prodotto, minsan e grossista selezionato
                PrimaRigaInformazioni(controller: controller),

                const SizedBox(height: 15.0),

                /// Mostra disponibilità, quantità venduta e quantità totale
                SecondaRigaInformazioni(controller: controller),

                const SizedBox(height: 15.0),

                /// Tasto mostra generici
                TastoMostraGenerici(controller: controller),

                const SizedBox(height: 15.0),

                /// Tabella mostra offerte disponibili
                TabellaOfferte(controller: controller),

                const SizedBox(height: 25.0),

                TabellaStatistiche(controller: controller),

                const SizedBox(height: 15),

                Center(
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 2.0,
                        shape: kCardShape,
                      ),
                      child: AutoSizeText(
                        'Conferma Ordine',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.green.shade800,
                        ),
                      ),

                      onPressed: () {
                        if (controller.ctrlQtaVenduta.text != '0') {
                          controller.indice++;
                          controller.confermaOrdine();
                        } else {
                          controller.eliminaOrdine(controller.indice.value);
                        }
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      onLoading: const WidgetInCaricamento(),
    );
  }



  // Widget _primaRigaInformazioni() {
  //   return Row(
  //     children: <Widget>[
  //       Container(
  //         alignment: Alignment.center,
  //         width: larghezzaSchermo / 1.5,
  //         padding: const EdgeInsets.only(
  //           left: 10.0,
  //           right: 5.0,
  //         ),
  //         child: IgnorePointer(
  //           ignoring: true,
  //           child: AutoSizeTextField(
  //             controller: controller.ctrlDescrizione,
  //
  //             maxLines: 1,
  //             minFontSize: 12,
  //             maxFontSize: 20,
  //             style: const TextStyle(fontSize: 10.0),
  //
  //             decoration: InputDecoration(
  //               border: const OutlineInputBorder(),
  //               enabledBorder: kTextFieldShape,
  //
  //               labelText: 'Minsan: ${controller.minsan}',
  //
  //               labelStyle: const TextStyle(
  //                 fontSize: 20.0,
  //                 color: Colors.black,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //
  //       Container(
  //         padding: const EdgeInsets.all(5.0),
  //         width: 120.0,
  //         child: ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             elevation: 0.0,
  //           ),
  //           child: IgnorePointer(
  //             ignoring: true,
  //             child: AutoSizeTextField(
  //               controller: controller.ctrlGrossista,
  //
  //               maxLines: 1,
  //               minFontSize: 10.0,
  //               maxFontSize: 20.0,
  //               textAlign: TextAlign.center,
  //
  //               style: const TextStyle(
  //                 fontSize: 10.0,
  //                 color: Colors.black,
  //               ),
  //
  //               decoration: InputDecoration(
  //                   border: const OutlineInputBorder(),
  //                   enabledBorder: kTextFieldShape,
  //                   labelText: 'Grossista',
  //
  //                   labelStyle: const TextStyle(
  //                     color: Colors.black,
  //                     fontSize: 16.0,
  //                     fontWeight: FontWeight.bold,
  //                   )),
  //             ),
  //           ),
  //           onPressed: () {
  //             controller.cambiaGrossista();
  //           },
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _secondaRigaInformazioni() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //     children: <Widget>[
  //
  //       ///Disponibilità
  //       Container(
  //         padding: const EdgeInsets.all(5.0),
  //         width: larghezzaSchermo / 4.2,
  //
  //         child: IgnorePointer(
  //           ignoring: true,
  //
  //           child: AutoSizeTextField(
  //             controller: controller.ctrlDisp,
  //
  //             textAlign: TextAlign.center,
  //             maxLines: 1,
  //             minFontSize: 10.0,
  //             maxFontSize: 20.0,
  //
  //             decoration: InputDecoration(
  //               border: const OutlineInputBorder(),
  //               enabledBorder: kTextFieldShape,
  //
  //               labelText: 'Disponibilità',
  //               labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14.0),
  //             ),
  //           ),
  //         ),
  //       ),
  //
  //       /// Quantità venduta
  //       Container(
  //         padding: const EdgeInsets.all(5.0),
  //         width: larghezzaSchermo / 4.0,
  //
  //         child: AutoSizeTextField(
  //           controller: controller.ctrlQtaVenduta,
  //           focusNode: controller.ctrlFocusQtaVen,
  //
  //           keyboardType: TextInputType.number,
  //           inputFormatters: <TextInputFormatter>[
  //             FilteringTextInputFormatter.digitsOnly
  //           ],
  //
  //           textAlign: TextAlign.center,
  //           maxLines: 1,
  //           minFontSize: 10.0,
  //           maxFontSize: 15.0,
  //
  //           decoration: InputDecoration(
  //             border: const OutlineInputBorder(),
  //             focusedBorder: kTextFieldShape,
  //             enabledBorder: kTextFieldShape,
  //
  //             labelText: 'Qta Venduta',
  //             labelStyle: const TextStyle(color: Colors.black, fontSize: 14.0, fontWeight: FontWeight.bold),
  //           ),
  //
  //           onSubmitted: (valore) => (valore.isEmpty) ? controller.ctrlQtaVenduta.text = '0' : null,
  //
  //           onChanged: (valore) {
  //             valore = valore.substring(valore.length - 1);
  //             if (controller.toccato.value == false) {
  //               controller.ctrlQtaVenduta.text = valore;
  //
  //               controller.ctrlQtaVenduta.selection = TextSelection.fromPosition(
  //                   TextPosition(
  //                       offset: controller.ctrlQtaVenduta.text.length,
  //                   ),
  //               );
  //
  //               controller.toccato.value = true;
  //             }
  //           },
  //           onTap: () => controller.ctrlQtaVenduta.clear(),
  //         ),
  //       ),
  //
  //       ///Quantità totale
  //       Container(
  //         padding: const EdgeInsets.all(5.0),
  //         width: larghezzaSchermo / 4.3,
  //
  //         child: IgnorePointer(
  //           ignoring: true,
  //
  //           child: AutoSizeTextField(
  //             controller: controller.ctrlQtaTot,
  //
  //             minFontSize: 10.0,
  //             maxFontSize: 15.0,
  //             maxLines: 1,
  //
  //             textAlign: TextAlign.center,
  //
  //             decoration: InputDecoration(
  //                 border: const OutlineInputBorder(),
  //                 enabledBorder: kTextFieldShape,
  //                 labelText: 'Qta Totale',
  //
  //                 labelStyle: const TextStyle(
  //                   color: Colors.black,
  //                   fontSize: 14.0,
  //                   fontWeight: FontWeight.bold,
  //                 ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _tastoMostraGenerici() {//
  //   return Container(
  //     padding: const EdgeInsets.all(5.0),
  //     width: larghezzaSchermo / 2.0,
  //     height: 30.0,
  //     decoration: kBoxDec,
  //     child: ElevatedButton(
  //
  //       child: Obx(
  //         () => AutoSizeText.rich(
  //           TextSpan(
  //             text: 'Generici: ',
  //             style: const TextStyle(
  //               fontWeight: FontWeight.bold,
  //               fontSize: 16.0,
  //               color: Colors.black,
  //             ),
  //
  //             semanticsLabel: "Generici",
  //
  //             children: [
  //               TextSpan(
  //                 text: '${controller.genericiTotali}',
  //                 style: const TextStyle(fontWeight: FontWeight.w600)
  //               ),
  //             ]
  //           ),
  //
  //           maxLines: 1,
  //         ),
  //       ),
  //
  //       style: ElevatedButton.styleFrom(elevation: 0.0),
  //       onPressed: () => (controller.genericiTotali.value != 0)
  //           ? controller.mostraGenerici()
  //           : null,
  //     ),
  //   );
  // }

  // Widget _tabellaOfferte() {
  //   return Container(
  //       padding: const EdgeInsets.all(5.0),
  //       width: larghezzaSchermo - 10,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(10.0),
  //         border: Border.all(
  //           width: 1.0,
  //           color: Colors.cyan.shade600,
  //         ),
  //       ),
  //       child: Obx(
  //         () => controller.offerteTotali.value == 0
  //             ? const Center(
  //                 child: AutoSizeText(
  //                   'Nessuna offerta disponibile',
  //                   maxLines: 1,
  //                   minFontSize: 18,
  //                   textAlign: TextAlign.center,
  //                   style: TextStyle(fontWeight: FontWeight.bold),
  //                 ),
  //               )
  //             : Theme(
  //                 data: ThemeData(dividerColor: Get.theme.selectedRowColor),
  //                 child: DataTable(
  //                   headingRowColor: MaterialStateColor.resolveWith(
  //                       (states) => Colors.grey.shade100),
  //                   dataRowColor: MaterialStateColor.resolveWith(
  //                       (states) => Colors.grey.shade100),
  //                   horizontalMargin: 5.0,
  //                   columnSpacing: 2.0,
  //                   dataRowHeight: 40.0,
  //                   headingRowHeight: 25.0,
  //                   columns: const <DataColumn>[
  //
  //                     /// CODICE FORNITORE
  //                     DataColumn(
  //                         label: Text(
  //                             'Cod.',
  //                             style: TextStyle(
  //                               fontSize: 11.0,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                         ),
  //                     ),
  //
  //                     /// FORNITORE
  //                     DataColumn(
  //                         label: Text(
  //                             'Fornitore',
  //                             style: TextStyle(
  //                               fontSize: 11.0,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                             maxLines: 1,
  //                         ),
  //                     ),
  //
  //                     /// ICONA
  //                     DataColumn(
  //                         label: Text(
  //                             '',
  //                             style: TextStyle(
  //                               fontSize: 11.0,
  //                               fontWeight: FontWeight.bold,
  //                             ),
  //                         ),
  //                     ),
  //
  //                     /// QTA
  //                     DataColumn(
  //                         label: Text(
  //                             'Qta.',
  //                             style: TextStyle(
  //                                 fontSize: 11.0,
  //                                 fontWeight: FontWeight.bold,
  //                             ),
  //                         ),
  //                         numeric: true,
  //                     ),
  //
  //                     /// COSTO
  //                     DataColumn(
  //                         label: Text(
  //                             'Costo',
  //                             style: TextStyle(
  //                                 fontSize: 11.0,
  //                                 fontWeight: FontWeight.bold,
  //                             ),
  //                         ),
  //                         numeric: true,
  //                     ),
  //                   ],
  //
  //
  //
  //                   rows: List<DataRow>.generate(
  //                     controller.infoOrdine[1].length,
  //                     (index) => DataRow(
  //                       cells: [
  //
  //                         /// DATACELL CODICEFORNITORE
  //                         DataCell(
  //                             Obx(
  //                               () => Text(
  //                                   '${controller.infoOrdine[1][index].codiceFornitore}',
  //                                   style: const TextStyle(
  //                                     fontSize: 10.0,
  //                                     fontWeight: FontWeight.w600,
  //                                   ),
  //                               )
  //                             ),
  //                         ),
  //
  //                         /// DATACELL FORNITORE
  //                         DataCell(
  //                           GestureDetector(
  //                             child: Obx(
  //                               () => Text(
  //                                   '${controller.infoOrdine[1][index].fornitore}',
  //                                   style: const TextStyle(
  //                                     fontSize: 10.0,
  //                                     fontWeight: FontWeight.w600,
  //                                   ),
  //                               ),
  //                             ),
  //
  //                             onDoubleTap: () async {
  //                               controller.ctrlQtaVenduta.text = controller.infoOrdine[1][index].quantita.toString();
  //                               controller.grossistaAttuale.value = controller.infoOrdine[1][index].codiceFornitore;
  //
  //                               if (await controller.mostraOffertaScelta(index)) {
  //                                 controller.confermaOrdine();
  //                               }
  //                             },
  //                           ),
  //                         ),
  //
  //
  //                         /// DATACELL ICONA
  //                         DataCell(
  //                             (index == 0)
  //                             ? Image.asset(
  //                               'assets/defaultIcons/attenzione.png',
  //                               scale: 1.5,
  //                               color: Colors.green.shade800,
  //                             )
  //                             : (index == (controller.listaProdotti.length - 1))
  //                             ? Image.asset(
  //                               'assets/defaultIcons/attenzione.png',
  //                               scale: 1.5,
  //                               color: Colors.red.shade800,
  //                             )
  //                             : Image.asset(
  //                               'assets/defaultIcons/attenzione.png',
  //                               color: Colors.grey.shade100,
  //                             ),
  //                         ),
  //
  //                         /// DATACELL QTA
  //                         DataCell(
  //                           Obx(
  //                             () => Text(
  //                                 '${controller.infoOrdine[1][index].quantita}',
  //                                 style: const TextStyle(
  //                                   fontSize: 10.0,
  //                                   fontWeight: FontWeight.w600,
  //                                 ),
  //                             ),
  //                           ),
  //                         ),
  //
  //                         ///DATACELL COSTO
  //                         DataCell(
  //                             Obx(
  //                               () => Text(
  //                                   '${(controller.infoOrdine[1][index].costo).toStringAsFixed(2)}€',
  //                                   style: const TextStyle(
  //                                       fontSize: 10.0,
  //                                       fontWeight: FontWeight.w600,
  //                                   ),
  //                               ),
  //                             ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //         ),
  //       )
  //   );
  // }

  // Widget _tabellaStatisticheOrdine() {
  //   return Container(
  //     padding: const EdgeInsets.all(5.0),
  //     width: larghezzaSchermo - 10,
  //
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       border: Border.all(
  //         width: 1.0,
  //         color: Colors.cyan.shade600,
  //       ),
  //     ),
  //
  //     child: Theme(
  //       data: ThemeData(dividerColor: Get.theme.selectedRowColor),
  //       child: Obx(
  //         () => DataTable(
  //           headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade100),
  //           dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade100),
  //
  //           horizontalMargin: 5.0,
  //           columnSpacing: 2.0,
  //           dataRowHeight: 20.0,
  //           headingRowHeight: 25.0,
  //
  //
  //           columns: const [
  //             DataColumn(
  //                 label: Text(
  //                     'Mese',
  //                     style: TextStyle(
  //                         fontSize: 11.0,
  //                         fontWeight: FontWeight.bold,
  //                     ),
  //                 ),
  //             ),
  //
  //
  //             DataColumn(
  //                 label: Text(
  //                     '',
  //                     style: TextStyle(
  //                         fontSize: 11.0,
  //                         fontWeight: FontWeight.bold,
  //                     ),
  //                 ),
  //             ),
  //
  //             /// ACQUISTATI
  //             DataColumn(
  //                 label: Text(
  //                     'Acquistati',
  //                     style: TextStyle(
  //                         fontSize: 11.0,
  //                         fontWeight: FontWeight.bold,
  //                     ),
  //                 ),
  //                 numeric: true,
  //             ),
  //
  //             /// VENDUTI
  //             DataColumn(
  //                 label: Text(
  //                     'Venduti',
  //                     style: TextStyle(
  //                         fontSize: 11.0,
  //                         fontWeight: FontWeight.bold,
  //                     )
  //                 ),
  //                 numeric: true,
  //             ),
  //           ],
  //
  //
  //           /// DATAROWS
  //           rows: List<DataRow>.generate(
  //             controller.listaStatistiche.length,
  //             (index) => DataRow.byIndex(
  //               index: index,
  //               cells: [
  //                 /// DATACELL NOME MESE
  //                 DataCell(
  //                   Text(
  //                     numMeseToNome(index + 1),
  //                     style: const TextStyle(fontSize: 11.0),
  //                   ),
  //                 ),
  //
  //                 /// DATACELL ICONA
  //                 DataCell(
  //                     (DateTime.now().month == (index + 1))
  //                     ? Image.asset(
  //                         'assets/defaultIcons/attenzione.png',
  //                         scale: 1.5,
  //                         color: Colors.green.shade800,
  //                       )
  //                     : Image.asset(
  //                         'assets/defaultIcons/attenzione.png',
  //                         scale: 1.5,
  //                         color: Colors.grey.shade100,
  //                       ),
  //                 ),
  //
  //                 /// DATACELL ACQUISTI
  //                 DataCell(
  //                     Text(
  //                       controller.listaStatistiche[index].totaleAcquisti.toString(),
  //                       style: const TextStyle(fontSize: 12.0)
  //                     ),
  //                 ),
  //
  //
  //                 /// DATACELL VENDUTI
  //                 DataCell(
  //                     Text(
  //                         controller.listaStatistiche[index].venduto.toString(),
  //                         style: TextStyle(
  //                             fontSize: 12.0,
  //                             color: controller.listaStatistiche[index].venduto > 0 ? Colors.green.shade800 : Colors.red.shade900,
  //                         ),
  //                     ),
  //                 )
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
