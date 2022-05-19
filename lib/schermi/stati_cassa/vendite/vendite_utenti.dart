// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import '../../../defaultFunctions/prendi_numero.dart';
import '../../../defaultsWidgets/widget_dati_vendite.dart';
import '../../../defaultsWidgets/widget_in_caricamento.dart';
import '../../../defaultsWidgets/widget_appbar_back.dart';
import '../../../controllers/stati_cassa_controller/vendite_controller/vendite_utenti_controller.dart';
import '../../../theme/shapes.dart';
import '../../../theme/dimensioni.dart';

class VenditeUtenti extends GetView<VenditeUtentiController> {
  const VenditeUtenti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        leading: const AppbarBackButton(),

        title: Image.asset('assets/immagini/scritta.png'),
      ),

      body: Column(
        children: [
          Card(
            elevation: 5.0,
            color: Get.theme.scaffoldBackgroundColor,
            shape: kShapeDettVend,

            child: Column (
              children: <Widget> [

                const SizedBox(height: 15.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AutoSizeText(
                      (controller.periodo.getDataIn() == controller.periodo.getDataOut())
                          ? 'Vendite del ${controller.periodo.getDataIn()}'
                          : 'Vendite dal ${controller.periodo.getDataIn()} al ${controller.periodo.getDataOut()}',

                      minFontSize: 20,
                      maxFontSize: 25,
                      style: TextStyle(
                        fontSize: fontSizeGrande,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],

                ),
                const SizedBox(
                  height: 20.0,
                  width: 400.0,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20.0),


          controller.obx(
                (state) => Expanded(
                  child: Scrollbar(
                    thickness: 2,
                    child: ListView.builder(
                        itemCount: controller.vendite.length,
                        itemBuilder: (context, index) {
                          if (int.tryParse(controller.vendite[index].cassaLibera.numeroPezzi)! > 0) {
                            bool mostraDatiFinali = (index >= controller.infoUtenti.length) ? false : true;

                            return Column(children: <Widget>[
                              Card(
                                elevation: 5.0,
                                margin: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 10.0, right: 10.0),

                                color: Get.theme.scaffoldBackgroundColor,
                                shape: kShapeDettVend,

                                child: ListTile(
                                  contentPadding: const EdgeInsets.only(top: 10.0, left: 15.0),

                                  title: Row(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/defaultIcons/account_box.png',
                                        color: Colors.green.shade600,
                                      ),

                                      const SizedBox(width: 10.0),

                                      AutoSizeText(
                                        controller.vendite[index].nomeUtente,
                                        textAlign: TextAlign.center,
                                        minFontSize: 20.0,
                                        maxFontSize: 25.0,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),

                                  subtitle: Column(
                                    children: <Widget>[

                                      const SizedBox(height: 10.0),

                                      WidgetDatiVendite(
                                        descrizione: 'Pezzi:',
                                        valore: controller.vendite[index].cassaLibera.numeroPezzi,
                                        coloreDati: Colors.black,
                                        nonUsareEuro: true,
                                        fSize: fontSizePiccolo,
                                      ),

                                      const SizedBox(height: 5.0),

                                      WidgetDatiVendite(
                                        descrizione: 'Tot. Vendita libera:',
                                        valore: controller.vendite[index].cassaLibera.totaleVenditaLibera,
                                        coloreDati: Colors.black,
                                        fSize: fontSizePiccolo,
                                      ),

                                      const SizedBox(height: 5.0),

                                      WidgetDatiVendite(
                                        descrizione: 'Margine netto V.libera:',
                                        valore: ((prendiNumero(controller.vendite[index].cassaLibera.valoreVenditaAlCosto) / prendiNumero(controller.vendite[index].cassaLibera.totaleLiberaDeivato)) * 100).toString(),
                                        coloreDati: Colors.black,
                                        nonUsareEuro: false,
                                        digits: 2,
                                        fSize: fontSizePiccolo,
                                      ),

                                      const SizedBox(height: 5.0),

                                      WidgetDatiVendite(
                                        descrizione: 'Tot. Vendita varia:',
                                        valore: controller.vendite[index].cassaLibera.totaleVenditaVaria,
                                        coloreDati: Colors.black,
                                        fSize: fontSizePiccolo,
                                      ),

                                      const SizedBox(height: 5.0),

                                      WidgetDatiVendite(
                                        descrizione: 'Tot. Sospesi:',
                                        valore: controller.vendite[index].cassaLibera.totaleSospesi,
                                        coloreDati: Colors.black,
                                        fSize: fontSizePiccolo,
                                      ),

                                      const SizedBox(height: 5.0),

                                      WidgetDatiVendite(
                                        descrizione: 'Tot. Acconti:',
                                        valore: controller.vendite[index].cassaLibera.totaleAcconti,
                                        coloreDati: Colors.black,
                                        fSize: fontSizePiccolo,
                                      ),

                                      const SizedBox(height: 5.0),

                                      WidgetDatiVendite(
                                        descrizione: 'Tot. Mutualistica:',
                                        valore: controller.vendite[index].cassaMutualistica.totali,
                                        coloreDati: Colors.black,
                                        fSize: fontSizePiccolo,
                                      ),

                                      const SizedBox(height: 5.0),

                                      WidgetDatiVendite(
                                        descrizione: 'Tot. Ticket:',
                                        valore: controller.vendite[index].cassaMutualistica.totaleTicket,
                                        coloreDati: Colors.black,
                                        fSize: fontSizePiccolo,
                                      ),

                                      const SizedBox(height: 5.0),

                                      (mostraDatiFinali) ?  WidgetDatiVendite(
                                        descrizione: 'Numero Vendite:',
                                        valore: controller.infoUtenti[index].numeroVendite.toString(),
                                        coloreDati: Colors.black,
                                        nonUsareEuro: true,
                                        digits: 0,
                                        fSize: fontSizePiccolo,
                                        wait: false,
                                      ) : const SizedBox(),

                                      const SizedBox(height: 5.0),

                                      (mostraDatiFinali) ? WidgetDatiVendite(
                                        descrizione: 'Orario di lavoro:',
                                        valore: controller.infoUtenti[index].tempoLavorato,
                                        coloreDati: Colors.black,
                                        nonUsareEuro: true,
                                        soloStringhe: true,
                                        digits: 1,
                                        fSize: fontSizePiccolo,
                                        wait: false,
                                      ) : const SizedBox(),

                                      const SizedBox(height: 5.0),

                                      (mostraDatiFinali) ? WidgetDatiVendite(
                                        descrizione: 'Vendite al minuto:',
                                        valore: (controller.infoUtenti[index].minuti / controller.infoUtenti[index].numeroVendite).toString(),
                                        coloreDati: Colors.black,
                                        nonUsareEuro: true,
                                        digits: 1,
                                        fSize: fontSizePiccolo,
                                        wait: false,
                                      ) : const SizedBox(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        }
                    ),
                  ),
                ),

            onLoading: const WidgetInCaricamento(),
            onEmpty: const Padding(
              padding: EdgeInsets.only(top: 50.0),
              child: Center(
                child: AutoSizeText(
                  'Nessuna informazione da mostrare',
                  minFontSize: 20.0,
                  maxFontSize: 30.0,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}
