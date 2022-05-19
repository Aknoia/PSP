// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports
import 'pagina_statistiche_widgets/mostra_totali.dart';
import 'pagina_statistiche_widgets/widget_box_statistica.dart';
import 'pagina_statistiche_widgets/colonna_filtro_ricerca.dart';
import '../../defaultsWidgets/widget_in_caricamento.dart';
import '../../defaultsWidgets/widget_appbar_back.dart';
import '../../controllers/menu_statistiche_controller/pagina_statistiche_controller.dart';



class Statistiche extends GetView<PaginaStatisticheController>{
  const Statistiche({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/immagini/scritta.png'),

        centerTitle: true,

        leading: const AppbarBackButton(),
      ),

      body: controller.obx(
              (state) => Column(
                children: <Widget>[
                  /// Mostra i totali
                  MostraTotali(controller: controller),

                  ColonnaFiltroRicerca(controller: controller),

                  const SizedBox(height: 20.0),

                  Expanded(
                    child: Obx(
                          () => ListView.builder(
                        itemCount: controller.statistiche.length,
                        itemBuilder: (context, index) {
                          bool mostraStatistica = true;

                          if (controller.filtro.value.isNotEmpty) {
                            if (controller.statistiche[index].descrizione.length < 4) {
                              controller.filtro.value = '';
                            } else {
                              mostraStatistica = (controller.statistiche[index].descrizione.toLowerCase().contains(controller.filtro.value));
                            }
                          }

                          return mostraStatistica ? BoxStatistica(
                            ordinaPerMargine: controller.ordinaMargine.value,
                            statistica: controller.statistiche[index],
                            tipoReport: controller.tipoStatistica,
                          ) : Container();
                        },
                      ),
                    ),
                  ),
                ],
              ),

        onLoading: const WidgetInCaricamento(),

        onEmpty: const Center(
            child: AutoSizeText(
              'NESSUNA STATISTICA DA MOSTRARE',
              minFontSize: 20.0,
              maxFontSize: 30.0,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
        ),
      ),
    );
  }
}

