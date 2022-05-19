// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

//  Project imports:
import '../../../theme/dimensioni.dart';
import '../../../controllers/ordine_provvisorio_controller/modifica_ordine_controller.dart';

class TabellaOfferte extends StatelessWidget {
  const TabellaOfferte({Key? key, required this.controller}) : super(key: key);

  final ModificaOrdineController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5.0),
        width: larghezzaSchermo - 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            width: 1.0,
            color: Colors.cyan.shade600,
          ),
        ),
        child: Obx(
              () => controller.offerteTotali.value == 0
              ? const Center(
                child: AutoSizeText(
                  'Nessuna offerta disponibile',
                  maxLines: 1,
                  minFontSize: 18,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
                  : Theme(
                data: ThemeData(dividerColor: Get.theme.selectedRowColor),
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey.shade100),
                  dataRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.grey.shade100),
                  horizontalMargin: 5.0,
                  columnSpacing: 2.0,
                  dataRowHeight: 40.0,
                  headingRowHeight: 25.0,
                  columns: const <DataColumn>[

                    /// CODICE FORNITORE
                    DataColumn(
                      label: Text(
                        'Cod.',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),



                    /// FORNITORE
                    DataColumn(
                      label: Text(
                        'Fornitore',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                      ),
                    ),



                    /// ICONA
                    DataColumn(
                      label: Text(
                        '',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),



                    /// QTA
                    DataColumn(
                      label: Text(
                        'Qta.',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      numeric: true,
                    ),



                    /// COSTO
                    DataColumn(
                      label: Text(
                        'Costo',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      numeric: true,
                    ),
                  ],



                  rows: List<DataRow>.generate(
                    controller.infoOrdine[1].length,
                        (index) => DataRow(
                          cells: [



                            /// DATACELL CODICEFORNITORE
                            DataCell(
                              Obx(
                                      () => Text(
                                        '${controller.infoOrdine[1][index].codiceFornitore}',
                                        style: const TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                              ),
                            ),



                            /// DATACELL FORNITORE
                            DataCell(
                              GestureDetector(
                                child: Obx(
                                      () => Text(
                                    '${controller.infoOrdine[1][index].fornitore}',
                                    style: const TextStyle(
                                      fontSize: 10.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),

                                onDoubleTap: () async {
                                  controller.ctrlQtaVenduta.text = controller.infoOrdine[1][index].quantita.toString();
                                  controller.grossistaAttuale.value = controller.infoOrdine[1][index].codiceFornitore;

                                  if (await controller.mostraOffertaScelta(index)) {
                                    controller.confermaOrdine();
                                  }
                                },
                              ),
                            ),




                            /// DATACELL ICONA
                            DataCell(
                              (index == 0)
                                  ? Image.asset(
                                'assets/defaultIcons/attenzione.png',
                                scale: 1.5,
                                color: Colors.green.shade800,
                              )
                                  : (index == (controller.listaProdotti.length - 1))
                                  ? Image.asset(
                                'assets/defaultIcons/attenzione.png',
                                scale: 1.5,
                                color: Colors.red.shade800,
                              )
                                  : Image.asset(
                                'assets/defaultIcons/attenzione.png',
                                color: Colors.grey.shade100,
                              ),
                            ),



                            /// DATACELL QTA
                            DataCell(
                              Obx(
                                    () => Text(
                                  '${controller.infoOrdine[1][index].quantita}',
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),



                            ///DATACELL COSTO
                            DataCell(
                              Obx(
                                    () => Text(
                                  '${(controller.infoOrdine[1][index].costo).toStringAsFixed(2)}€',
                                  style: const TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                  ),
                ),
              ),
        ),
    );
  }
}
