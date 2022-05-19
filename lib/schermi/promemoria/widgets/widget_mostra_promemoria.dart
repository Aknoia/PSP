// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../controllers/promemoria_controller/promemoria_controller.dart';
import '../../../theme/dimensioni.dart';
import '../../../theme/shapes.dart';
import '../../../defaultsWidgets/widget_dati_vendite.dart';

class MostraPromemoria extends StatelessWidget {
  const MostraPromemoria({Key? key, required this.controller}) : super(key: key);

  final PromemoriaController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          width: fontSizePiccolo * 16.2,
          child: Card(
            shape: kCardAdvisor1,
            child: ListTile(
              title: WidgetDatiVendite(
                  descrizione: (controller.demInScadenza == 0) ? 'Nessuna ricetta in scadenza' : '${controller.demInScadenza} Ricette in scadenza',
                  valore: '',
                  coloreDati: Colors.black,
                  nonUsareEuro: true,
                  digits: 0,
                  fSize: fontSizePiccolo / 1.3,
                  wait: (controller.demInScadenza == -1),
                  soloStringhe: true
              ),

              leading: SizedBox(
                  width: 36.0,
                  height: 36.0,
                  child: Image.asset('assets/icone/dem.ico')
              ),
            ),
          ),
        ),

        SizedBox(
          width: fontSizePiccolo * 16.2,
          child: Card(
            shape: kCardAdvisor1,

            child: ListTile(
              title: WidgetDatiVendite(
                descrizione: (controller.invendibili == 0) ? 'Nessun prodotto invendibili' : '${controller.invendibili} Prodotti invendibili',
                valore: '',
                coloreDati: Colors.black,
                nonUsareEuro: true,
                digits: 0,
                fSize: fontSizePiccolo / 1.3,
                wait: (controller.invendibili == -1),
                soloStringhe: true,
              ),

              leading: SizedBox(
                width: 36.0,
                height: 36.0,
                child: Image.asset('assets/immagini/invendibili.png'),
              ),
            ),
          ),
        ),

        SizedBox(
          width: fontSizePiccolo * 16.2,
          child: Card(
            shape: kCardAdvisor1,

            child: ListTile(
              title: WidgetDatiVendite(
                descrizione: (controller.contabiliInScadenza == -1 || controller.contabiliInScadenza == 0) ? 'Nessuna scadenza contabile' : '${controller.contabiliInScadenza} Scadenze Contabili',
                valore: '',
                coloreDati: Colors.black,
                nonUsareEuro: true,
                digits: 0,
                fSize: fontSizePiccolo / 1.3,
                wait: (controller.contabiliInScadenza == -1),
                soloStringhe: true,
              ),

              leading: SizedBox(
                width: 36.0,
                height: 36.0,
                child: Image.asset('assets/immagini/scadcont.png'),
              ),
            ),
          ),
        ),

        SizedBox(
          width: fontSizePiccolo * 16.2,
          child: Card(
            shape: kCardAdvisor1,

            child: ListTile(
              title: WidgetDatiVendite(
                  descrizione: (controller.prodottiInScadenza == 0) ? 'Nessun prodotto in scadenza' : '${controller.prodottiInScadenza} Prodotti in scadenza',
                  valore: '',
                  coloreDati: Colors.black,
                  nonUsareEuro: true,
                  digits: 0,
                  fSize: fontSizePiccolo / 1.3,
                  wait: (controller.prodottiInScadenza == -1),
                  soloStringhe: true
              ),

              leading: SizedBox(
                width: 36.0,
                height: 36.0,
                child: Image.asset('assets/immagini/scadenza.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}