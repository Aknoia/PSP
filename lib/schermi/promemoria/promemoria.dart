// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'widgets/widget_mostra_promemoria.dart';
import '../../controllers/promemoria_controller/promemoria_controller.dart';
import '../../defaultsWidgets/widget_in_caricamento.dart';

class Promemoria extends GetView<PromemoriaController> {
  const Promemoria({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Get.put(PromemoriaController());

    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 20.0),

          Image.asset('assets/immagini/promemoria.png'),

          const AutoSizeText(
            'Promemoria',
            maxLines: 1,
            minFontSize: 20.0,
            maxFontSize: 25.0,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 70.0),

          controller.obx(
                (state) => MostraPromemoria(controller: controller),

            onLoading: const WidgetInCaricamento(),
          )
        ],
      ),
    );
  }
}


//   Widget _costruisciPaginaPromemoria() {
//     return Column(
//       children: <Widget>[
//         SizedBox(
//           width: fontSizePiccolo * 16.2,
//           child: Card(
//             shape: kCardAdvisor1,
//             child: ListTile(
//               title: WidgetDatiVendite(
//                   descrizione: (controller.demInScadenza == 0) ? 'Nessuna ricetta in scadenza' : '${controller.demInScadenza} Ricette in scadenza',
//                   valore: '',
//                   coloreDati: Colors.black,
//                   nonUsareEuro: true,
//                   digits: 0,
//                   fSize: fontSizePiccolo / 1.3,
//                   wait: (controller.demInScadenza == -1),
//                   soloStringhe: true
//               ),
//
//               leading: SizedBox(
//                   width: 36.0,
//                   height: 36.0,
//                   child: Image.asset('assets/icone/dem.ico')
//               ),
//             ),
//           ),
//         ),
//
//         SizedBox(
//           width: fontSizePiccolo * 16.2,
//           child: Card(
//             shape: kCardAdvisor1,
//
//             child: ListTile(
//               title: WidgetDatiVendite(
//                 descrizione: (controller.invendibili == 0) ? 'Nessun prodotto invendibili' : '${controller.invendibili} Prodotti invendibili',
//                 valore: '',
//                 coloreDati: Colors.black,
//                 nonUsareEuro: true,
//                 digits: 0,
//                 fSize: fontSizePiccolo / 1.3,
//                 wait: (controller.invendibili == -1),
//                 soloStringhe: true,
//               ),
//
//               leading: SizedBox(
//                 width: 36.0,
//                 height: 36.0,
//                 child: Image.asset('assets/immagini/invendibili.png'),
//               ),
//             ),
//           ),
//         ),
//
//         SizedBox(
//           width: fontSizePiccolo * 16.2,
//           child: Card(
//             shape: kCardAdvisor1,
//
//             child: ListTile(
//               title: WidgetDatiVendite(
//                 descrizione: (controller.contabiliInScadenza == -1 || controller.contabiliInScadenza == 0) ? 'Nessuna scadenza contabile' : '${controller.contabiliInScadenza} Scadenze Contabili',
//                 valore: '',
//                 coloreDati: Colors.black,
//                 nonUsareEuro: true,
//                 digits: 0,
//                 fSize: fontSizePiccolo / 1.3,
//                 wait: (controller.contabiliInScadenza == -1),
//                 soloStringhe: true,
//               ),
//
//               leading: SizedBox(
//                   width: 36.0,
//                   height: 36.0,
//                   child: Image.asset('assets/immagini/scadcont.png'),
//               ),
//             ),
//           ),
//         ),
//
//         SizedBox(
//           width: fontSizePiccolo * 16.2,
//           child: Card(
//             shape: kCardAdvisor1,
//
//             child: ListTile(
//               title: WidgetDatiVendite(
//                   descrizione: (controller.prodottiInScadenza == 0) ? 'Nessun prodotto in scadenza' : '${controller.prodottiInScadenza} Prodotti in scadenza',
//                   valore: '',
//                   coloreDati: Colors.black,
//                   nonUsareEuro: true,
//                   digits: 0,
//                   fSize: fontSizePiccolo / 1.3,
//                   wait: (controller.prodottiInScadenza == -1),
//                   soloStringhe: true
//               ),
//
//               leading: SizedBox(
//                 width: 36.0,
//                 height: 36.0,
//                 child: Image.asset('assets/immagini/scadenza.png'),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }