// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

// Project imports:
import '../../../../controllers/stati_cassa_controller/vendite_controller/storico_vendite_controller.dart';
import '../../../../modelli/utente.dart';
import '../../../../modelli/storico_vendite.dart';
import '../../../../defaultsWidgets/widget_dati_vendite.dart';
import '../../../../defaultsWidgets/barra_colorata_orizzontale.dart';
import '../../../../theme/dimensioni.dart';
import '../../../../theme/shapes.dart';


class MostraStoricoVendite extends StatelessWidget {
  const MostraStoricoVendite({Key? key, required this.controller}) : super(key: key);

  final StoricoVenditeController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        thickness: 2,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: controller.listaTotaliUtenti.length,

          itemBuilder: (context, index) {
            Utente utenteAttuale = controller.listaTotaliUtenti[index];
            List<TotaleStorico> storicoAttuale = controller.storicoVenditeUtenti[index];


            return GestureDetector(
              onTap: () => Get.toNamed(
                '/dettagliostoricoutente',
                arguments: [storicoAttuale, utenteAttuale.descrizione],
              ),


              child: Card(
                elevation: 5.0,
                margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),

                color: Get.theme.scaffoldBackgroundColor,
                shape: kShapeDettVend,

                child: ListTile(
                  contentPadding: const EdgeInsets.only(top: 10.0),

                  title: Row(
                    children: <Widget>[
                      const SizedBox(width: 15.0),

                      Image.asset(
                        'assets/defaultIcons/account_box.png',
                        color: Colors.green.shade600,
                      ),

                      const SizedBox(width: 10.0),

                      AutoSizeText(
                        utenteAttuale.descrizione,
                        minFontSize: 15.0,
                        maxFontSize: 20.0,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),

                      const Spacer(),

                      AutoSizeText(
                        '${utenteAttuale.totaleVendite} €',
                        minFontSize: 15.0,
                        maxFontSize: 20.0,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: fontSizeGrande,
                            fontWeight: FontWeight.w500
                        ),
                      ),

                      const SizedBox(width: 20.0),
                    ],
                  ),

                  subtitle: Column(
                    children: <Widget>[

                      BarraColorataOrizzontale(
                        altezza: 2.5,
                        lunghezza: double.infinity,
                        colore: Get.theme.selectedRowColor,
                        bordi: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: WidgetDatiVendite(
                          descrizione: 'Numero vendite:',
                          valore: utenteAttuale.numeroVendite.toString(),
                          coloreDati: Colors.black,
                          nonUsareEuro: true,
                          fSize: 18.0,
                        ),
                      ),

                      const SizedBox(height: 5.0),

                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: WidgetDatiVendite(
                          descrizione: 'Durata lavoro:',
                          valore: utenteAttuale.tempoLavorato,
                          coloreDati: Colors.black,
                          nonUsareEuro: true,
                          soloStringhe: true,
                          fSize: 18.0,
                        ),
                      ),

                      const SizedBox(height: 5.0),

                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: WidgetDatiVendite(
                          descrizione: 'Vendite al minuto:',
                          valore: (utenteAttuale.totaleMinuti / utenteAttuale.numeroVendite).toString(),
                          coloreDati: Colors.black,
                          nonUsareEuro: true,
                          digits: 1,
                          fSize: 18.0,
                        ),
                      ),

                      const SizedBox(height: 5.0),

                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: WidgetDatiVendite(
                          descrizione: 'Orario prima vendita:',
                          valore: DateFormat('HH:mm').format(storicoAttuale.first.dataStorico),
                          fSize: 18.0,
                          coloreDati: Colors.black,
                          nonUsareEuro: true,
                          soloStringhe: true,
                        ),
                      ),

                      const SizedBox(height: 5.0),

                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: WidgetDatiVendite(
                          descrizione: 'Orario ultima vendita:',
                          valore: DateFormat('HH:mm').format(storicoAttuale.last.dataStorico),
                          coloreDati: Colors.black,
                          nonUsareEuro: true,
                          soloStringhe: true,
                          fSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}
