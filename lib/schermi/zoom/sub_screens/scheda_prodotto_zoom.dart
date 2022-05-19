// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'crea_prenotazione.dart';
import 'widgets_scheda_prodotto/widget_mostra_datibd.dart';
import 'widgets_scheda_prodotto/widget_prendi_informazioni.dart';
import '../../../controllers/scheda_prodotto_controller/scheda_prodotto_controller.dart';
import '../../../defaultsWidgets/widget_appbar_back.dart';

class SchedaProdottoZoom extends GetView<SchedaProdottoController> {
  const SchedaProdottoZoom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,

            title: Image.asset('assets/immagini/scritta.png'),

            leading: const AppbarBackButton(),

            bottom: TabBar(
              tabs: [
                Tab(
                  icon: Image.asset(
                    'assets/defaultIcons/banca_dati.png',
                    color: Get.theme.selectedRowColor,
                  ),

                  text: 'Banca Dati',
                ),

                Tab(
                  icon: Image.asset(
                    'assets/defaultIcons/informazioni.png',
                    color: Get.theme.selectedRowColor,
                  ),

                  text: 'Info',
                ),

                Tab(
                  icon: Image.asset(
                    'assets/defaultIcons/telematica.png',
                    color: Get.theme.selectedRowColor,
                  ),

                  text: 'Telematica',
                ),

                Tab(
                  icon: Image.asset(
                    'assets/icone/prenota.ico',
                    color: Get.theme.selectedRowColor,
                    scale: 2.2,
                  ),

                  text: 'Prenota',
                ),
              ],
            ),
          ),

          body: TabBarView(
            children: [

              MostraDatiBD(controller: controller),

              PrendiInformazioniProdotto(controller: controller),

              Container(),

              PaginaCreaPrenotazione(codiceProdotto: controller.prodotto.minsan),

            ],
          ),
        ),
    );
  }
}