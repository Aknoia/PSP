// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'dialog_chiedi_conferma.dart';
import '../../../controllers/login_controller/pagina_login_controller.dart';
import '../../../defaultFunctions/prendi_iniziali.dart';
import '../../../utils/impostazioni.dart';

class ElencaFarmacie extends StatelessWidget {
  const ElencaFarmacie({Key? key, required this.isListEmpty, required this.controller, required this.ctrlScroll}) : super(key: key);

  final bool isListEmpty;

  final LoginController controller;
  final ScrollController ctrlScroll;

  @override
  Widget build(BuildContext context) {
    if (isListEmpty)  {
      return Semantics(
        value: 'Lista farmacie, vuota',
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 1,

            itemBuilder: (BuildContext context, int index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  GestureDetector(

                    onTap: () => Get.offNamed('/qrcode'),


                    child: Container(
                      width: 86.0,
                      height: 86.0,
                      alignment: const Alignment(0.0, 0.0),
                      padding: const EdgeInsets.all(2.0),

                      decoration: BoxDecoration(
                        color: Get.theme.highlightColor,
                        shape: BoxShape.circle,
                      ),
                      child: CircleAvatar(
                        backgroundColor: Get.theme.primaryColor,
                        radius: 45.0,

                        child: Text(
                          '+',
                          style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.green.shade800,
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10.0), /// SPACER

                  const SizedBox(
                    width: 100.0,

                    child: AutoSizeText(
                      'Aggiungi farmacia',
                      maxLines: 1,
                      maxFontSize: 18.0,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            }
        ),
      );
    } else {
      return Semantics(
        value: 'Lista farmacie, elementi presenti',
        label: 'Lista farmacie, elementi presenti',
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[

            Image.asset(
                'assets/defaultIcons/freccia_sinistra.png',
                scale: 2,
                color: Colors.green.shade800
            ),


            SizedBox(
              width: 190.0,
              child: Center(
                child: Obx(
                      () => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        controller: ctrlScroll,
                        physics: const BouncingScrollPhysics(),

                        itemCount: controller.listaFarmacie.length,

                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              GestureDetector(
                                onLongPress: () async {
                                  await chiediConferma(
                                    controller.listaFarmacie[index],
                                    'Conferma eliminazione',
                                    controller,
                                  );

                                  controller.update();
                                },

                                onTap: () {
                                  DatiUtente.farmacia = controller.listaFarmacie[index];

                                  Get.toNamed('/homepage', arguments: [0]);
                                },

                                child: Container(
                                  width: 86.0,
                                  height: 86.0,
                                  padding: const EdgeInsets.all(2.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade800,
                                    shape: BoxShape.circle,
                                  ),

                                  child: CircleAvatar(
                                    backgroundColor: Get.theme.primaryColor,
                                    radius: 45.0,
                                    child: Text(
                                      prendiIniziali(controller.listaFarmacie[index].nome),

                                      style: const TextStyle(
                                        fontSize: 40.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(
                                width: 100.0,
                                child: AutoSizeText(
                                  controller.listaFarmacie[index].nome,
                                  maxLines: 2,
                                  maxFontSize: 18.0,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          );
                        },
                  ),
                ),
              ),
            ),

            Image.asset(
              'assets/defaultIcons/freccia_destra.png',
              scale: 2,
              color: Colors.green.shade800,
            ),
          ],
        ),
      );
    }
  }
}
