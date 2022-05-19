// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'widget_elenca_farmacie.dart';
import '../../../controllers/login_controller/pagina_login_controller.dart';


class WidgetConfiguraFarmacie extends StatelessWidget {
  WidgetConfiguraFarmacie({Key? key, required this.controller}) : super(key: key);

  final LoginController controller;

  final ctrlScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 50.0),

          /// SPACER

          Semantics(
            value: 'Titolo, scegli la tua farmacia',
            label: 'Titolo, scegli la tua farmacia',

            child: Text(
              'Scegli la tua farmacia',
              style: Get.textTheme.headline5,
            ),
          ),

          const SizedBox(height: 100.0),

          /// SPACER
          Container(
            width: 240.0,
            height: 140.0,

            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(25.0),
              border: Border.all(color: Get.theme.selectedRowColor),

              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0.0, 0.0),
                ),

                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  spreadRadius: -1.0,
                  blurRadius: 1.0,
                ),
              ],
            ),

            child: SizedBox(
              width: 190.0,
              child: Center(
                child: ElencaFarmacie(
                  controller: controller,
                  ctrlScroll: ctrlScroll,
                  isListEmpty: controller.planetConfig.value.listaFarmacie.isEmpty,
                ),
              ),
            ),
          ),

          const SizedBox(height: 35.0),

          ///SPACER

          SizedBox(
            width: 300.0,

            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
                side: BorderSide(
                  width: 2.0,
                  color: Get.theme.selectedRowColor,
                ),
              ),

              child: Semantics(
                value: 'Bottone, aggiungi farmacia',
                button: true,

                child: ListTile(

                  title: const Text('Aggiungi farmacia'),


                  leading: Image.asset(
                    'assets/defaultIcons/aggiungi.png',
                    scale: 1.6,
                    color: Colors.green.shade800,
                  ),

                  onTap: () => Get.offNamed('/qrcode'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}



/// TODO
//   Widget elencaFarmacie () {
//     if (controller.planetConfig.value.listaFarmacie.isEmpty) {
//       return Semantics(
//         value: 'Lista farmacie, vuota',
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           shrinkWrap: true,
//           itemCount: 1,
//
//           itemBuilder: (BuildContext context, int index) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//
//               children: <Widget>[
//                 GestureDetector(
//
//                   onTap: () => Get.offNamed('/qrcode'),
//
//
//                   child: Container(
//                     child: CircleAvatar(
//                       backgroundColor: Get.theme.primaryColor,
//                       radius: 45.0,
//
//                       child: Text(
//                         '+',
//                         style: TextStyle(
//                           fontSize: 40.0,
//                           color: Colors.green.shade800,
//                         ),
//                       ),
//                     ),
//
//                     width: 86.0,
//                     height: 86.0,
//                     alignment: const Alignment(0.0, 0.0),
//                     padding: const EdgeInsets.all(2.0),
//
//                     decoration: BoxDecoration(
//                       color: Get.theme.highlightColor,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 10.0), /// SPACER
//
//                 const SizedBox(
//                   width: 100.0,
//
//                   child: AutoSizeText(
//                     'Aggiungi farmacia',
//                     maxLines: 1,
//                     maxFontSize: 18.0,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ],
//             );
//           }
//         ),
//       );
//     }
//
//     return Semantics(
//       value: 'Lista farmacie, elementi presenti',
//       label: 'Lista farmacie, elementi presenti',
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: <Widget>[
//
//           Image.asset(
//               'assets/defaultIcons/freccia_sinistra.png',
//               scale: 2,
//               color: Colors.green.shade800
//           ),
//
//
//           SizedBox(
//             width: 190.0,
//             child: Center(
//               child: Obx(
//               () => ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   shrinkWrap: true,
//                   controller: ctrlScroll,
//                   physics: const BouncingScrollPhysics(),
//
//                   itemCount: controller.listaFarmacie.length,
//
//                   itemBuilder: (BuildContext context, int index) {
//                     return Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: <Widget>[
//
//                         GestureDetector(
//                           onLongPress: () async {
//                             await chiediConferma(
//                               controller.listaFarmacie[index],
//                               'Conferma eliminazione',
//                               controller,
//                             );
//
//                             controller.update();
//                           },
//
//                           onTap: () {
//                             DatiUtente.farmacia = controller.listaFarmacie[index];
//
//                             Get.toNamed('/homepage', arguments: [0]);
//                           },
//
//                           child: Container(
//                             width: 86.0,
//                             height: 86.0,
//                             padding: const EdgeInsets.all(2.0),
//                             decoration: BoxDecoration(
//                               color: Colors.green.shade800,
//                               shape: BoxShape.circle,
//                             ),
//
//                             child: CircleAvatar(
//                               backgroundColor: Get.theme.primaryColor,
//                               radius: 45.0,
//                               child: Text(
//                                 prendiIniziali(controller.listaFarmacie[index].nome),
//
//                                 style: const TextStyle(
//                                   fontSize: 40.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//
//                         SizedBox(
//                           width: 100.0,
//                           child: AutoSizeText(
//                             controller.listaFarmacie[index].nome,
//                             maxLines: 2,
//                             maxFontSize: 18.0,
//                             textAlign: TextAlign.center,
//                           ),
//                         )
//                       ],
//                     );
//                   },
//                 ),
//               ),
//             ),
//           ),
//
//           Image.asset(
//             'assets/defaultIcons/freccia_destra.png',
//             scale: 2,
//             color: Colors.green.shade800,
//           ),
//         ],
//       ),
//     );
//   }
// }
