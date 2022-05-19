// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'widget_titolo_statistica_.dart';
import '../../../modelli/statistica.dart';
import '../../../utils/enums.dart';
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';
import '../../../defaultsWidgets/widget_dati_vendite.dart';
import '../../../defaultsWidgets/barra_colorata_orizzontale.dart';


class BoxStatistica extends StatelessWidget {
  const BoxStatistica({Key? key, required this.ordinaPerMargine, required this.statistica, required this.tipoReport}) : super(key: key);

  final bool ordinaPerMargine;

  final Statistica statistica;

  final TipoStatistica tipoReport;

  @override
  Widget build(BuildContext context) {
    Widget boxValore = WidgetDatiVendite(
      descrizione: 'Venduto: ',
      valore: statistica.totaleVenduto,
      coloreDati: Colors.black,
      nonUsareEuro: false,
      fSize: fontSizeMedio,
    );

    Widget boxMargine = WidgetDatiVendite(
      descrizione: 'Margine: ',
      valore: '${statistica.margine} %',
      coloreDati: Colors.black,
      nonUsareEuro: true,
      soloStringhe: true,
      fSize: fontSizeMedio,
    );



    return Card(
      margin: const EdgeInsets.only(
        top: 10.0,
        bottom: 20.0,
        left: 5.0,
        right: 5.0,
      ),

      elevation: 12.0,
      shape: kShapeOrdineProv,

      child: InkWell(

        /// Va al dettaglio della statistica
        onTap: () => Get.toNamed(
          '/dettagliostatistica',
          arguments: [statistica, tipoReport],
        ),

        child: Column(
          children: <Widget>[
            ListTile(
              title: widgetTitoloStatistica(statistica.descrizione),

              subtitle: Column(
                children: <Widget>[

                  const SizedBox(height: 10.0),

                  BarraColorataOrizzontale(lunghezza: double.infinity, colore: Colors.cyan.shade600, altezza: 3),

                  const SizedBox(height: 5.0),

                  ordinaPerMargine ? boxMargine : boxValore,

                  ordinaPerMargine ? boxValore : boxMargine,

                  const SizedBox(height: 5.0),

                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),

                    child: Row(
                      children: <Widget>[
                        const Text('pezzi % : '),

                        Expanded(
                          child: LinearProgressIndicator(
                              backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),

                              value: (statistica.qtaIncidenza / 100),

                              valueColor: AlwaysStoppedAnimation(Get.theme.selectedRowColor)
                          ),
                        ),

                        Text(
                          '${statistica.qtaIncidenza} %',
                          style: TextStyle(
                            fontSize: fontSizeGrande,
                          ),
                        ),

                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),

                    child: Row(
                      children: <Widget>[

                        const Text('valore % : '),

                        Expanded(
                          child: LinearProgressIndicator(
                              backgroundColor: const Color.fromRGBO(209, 224, 224, 0.2),

                              value: (statistica.valoreIncidenza / 100),

                              valueColor: AlwaysStoppedAnimation(Get.theme.selectedRowColor)
                          ),
                        ),

                        Text(
                          '${statistica.valoreIncidenza} %',
                          style: TextStyle(
                            fontSize: fontSizeGrande,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
