// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

//  Project imports:
import '../../../theme/dimensioni.dart';
import '../../../defaultFunctions/numero_mese_a_nome.dart';
import '../../../controllers/ordine_provvisorio_controller/modifica_ordine_controller.dart';

class TabellaStatistiche extends StatelessWidget {
  const TabellaStatistiche({Key? key, required this.controller}) : super(key: key);

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

      child: Theme(
        data: ThemeData(dividerColor: Get.theme.selectedRowColor),
        child: Obx(
              () => DataTable(
                headingRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade100),
                dataRowColor: MaterialStateColor.resolveWith((states) => Colors.grey.shade100),

                horizontalMargin: 5.0,
                columnSpacing: 2.0,
                dataRowHeight: 20.0,
                headingRowHeight: 25.0,


                columns: const [

                  /// MESI
                  DataColumn(
                    label: Text(
                      'Mese',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),


                  DataColumn(
                    label: Text(
                      '',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),


                  /// ACQUISTATI
                  DataColumn(
                    label: Text(
                      'Acquistati',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    numeric: true,
                  ),


                  /// VENDUTI
                  DataColumn(
                    label: Text(
                        'Venduti',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                        )
                    ),
                    numeric: true,
                  ),
                ],


                /// DATAROWS
                rows: List<DataRow>.generate(
                  controller.listaStatistiche.length,
                      (index) => DataRow.byIndex(
                    index: index,
                    cells: [
                      /// DATACELL NOME MESE
                      DataCell(
                        Text(
                          numMeseToNome(index + 1),
                          style: const TextStyle(fontSize: 11.0),
                        ),
                      ),

                      /// DATACELL ICONA
                      DataCell(
                        (DateTime.now().month == (index + 1))
                            ? Image.asset(
                          'assets/defaultIcons/attenzione.png',
                          scale: 1.5,
                          color: Colors.green.shade800,
                        )
                            : Image.asset(
                          'assets/defaultIcons/attenzione.png',
                          scale: 1.5,
                          color: Colors.grey.shade100,
                        ),
                      ),

                      /// DATACELL ACQUISTI
                      DataCell(
                        Text(
                            controller.listaStatistiche[index].totaleAcquisti.toString(),
                            style: const TextStyle(fontSize: 12.0)
                        ),
                      ),


                      /// DATACELL VENDUTI
                      DataCell(
                        Text(
                          controller.listaStatistiche[index].venduto.toString(),
                          style: TextStyle(
                            fontSize: 12.0,
                            color: controller.listaStatistiche[index].venduto > 0 ? Colors.green.shade800 : Colors.red.shade900,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
