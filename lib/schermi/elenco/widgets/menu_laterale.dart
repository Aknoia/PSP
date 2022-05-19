// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart';

// Project imports:
import '../../../defaultFunctions/prendi_iniziali.dart';
import '../../../controllers/elenco_controller/elenco_controller.dart';
import '../../../modelli/farmacia.dart';
import '../../../utils/impostazioni.dart';


class MenuLaterale extends StatelessWidget {
  const MenuLaterale({Key? key, required this.nome, required this.controller}) : super(key: key);

  final String nome;
  final ElencoController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[

        /// Testata del menu
        DrawerHeader(
          decoration: BoxDecoration(
            color:  Colors.grey.shade100,
          ),
          child: Column(
            children: <Widget>[
              Container(
                width: 76.0,
                height: 76.0,
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Colors.red.shade900,
                  shape: BoxShape.circle,
                ),

                child: GestureDetector(
                  child: CircleAvatar(
                    radius: 50.0,

                    foregroundColor: Colors.red.shade900,

                    child: Text(
                      prendiIniziali(nome),
                      style: TextStyle(color: Colors.green.shade800),
                    ),
                  ),

                  /// Salvo la nuova farmacia e modifico il QRCODE
                  onTap:() async {
                    Map risultato = json.decode(await controller.modificaQRCode());

                    DatiUtente.farmacia = Farmacia.fromJSON(risultato);

                  },
                ),
              ),

              const Text(
                'Ciao',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),

              AutoSizeText(
                nome,
                maxLines: 1,
                minFontSize: 10.0,
                maxFontSize: 40.0,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),

              Divider(
                color: Colors.red.shade900,
                thickness: 1.0,
                height: 14.0,
              ),
            ],
          ),
        ),



        /// Stati di cassa
        ListTile(
          title: const Text('Totali di Cassa'),

          leading: SizedBox(
            width: 36.0,
            height: 36.0,
            child: Image.asset(
              'assets/icone/totalicassa.ico',
              scale: 0.5,
            ),
          ),

          onTap: () => controller.cambiaPaginaSchermo(0),
        ),



        /// Menu delle statistiche
        ListTile(
          title: const Text('Statistiche'),

          leading: SizedBox(
            width: 36.0,
            height: 36.0,
            child: Image.asset(
              'assets/icone/Statistiche.ico',
              scale: 0.5,
            ),
          ),

          onTap: () => controller.cambiaPaginaSchermo(1),
        ),

        /// Advisor di gestione
        ListTile(
          title: const Text('Advisor di gestione'),

          leading: SizedBox(
            width: 36.0,
            height: 36.0,
            child: Image.asset(
              'assets/icone/advisor.ico',
              scale: 0.5,
            ),
          ),

          onTap: () => controller.cambiaPaginaSchermo(2),
        ),

        /// Ordine provvisorio
        ListTile(
          title: const Text('Ordine Prov.'),

          leading: SizedBox(
            width: 36.0,
            height: 36.0,
            child: Image.asset(
                'assets/icone/I32_OrdProv32x32.ico',
                scale: 0.5
            ),
          ),

          onTap: () => controller.cambiaPaginaSchermo(3),
        ),


        /// Lista dei promemoria
        ListTile(
          title: const Text('Promemoria'),

          leading: SizedBox(
            width: 36.0,
            height: 36.0,
            child: Image.asset('assets/immagini/promemoria.png'),
          ),

          onTap: () => controller.cambiaPaginaSchermo(4),
        ),


        /// Lista delle news
        Obx(
              () => ListTile(
                title: const Text('Notizie'),

                leading: (controller.numeroNotifiche > 0) ? Badge(
                  badgeColor: Get.theme.highlightColor,
                  shape: BadgeShape.circle,
                  toAnimate: true,

                  borderRadius: BorderRadius.circular(20.0),

                  badgeContent: Text(
                    controller.numeroNotifiche.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),

                  child: Image.asset(
                    'assets/defaultIcons/news.png',
                    scale: 1.3,
                    color: Get.theme.selectedRowColor,
                  ),
                ) : Image.asset(
                  'assets/defaultIcons/news.png',
                  scale: 1.3,
                  color: Get.theme.selectedRowColor,
                ),

                onTap: () => controller.cambiaPaginaSchermo(5),
          ),
        ),


        /// Zoom per ricerca prodotti
        ListTile(
            title: const Text('Zoom'),

            leading: SizedBox(
              width: 36.0,
              height: 36.0,
              child: Image.asset(
                'assets/defaultIcons/cerca.png',
                alignment: Alignment.centerLeft,
                scale: 1.3,
                color: Get.theme.selectedRowColor,
              ),
            ),

            onTap: () => controller.cambiaPaginaSchermo(6)),

        ListTile(
          title: const Text('Esci'),

          leading: Image.asset(
            'assets/defaultIcons/esci.png',
            scale: 1.2,
            alignment: Alignment.centerLeft,
            color: Get.theme.selectedRowColor,
          ),

          onTap: () => Get.offNamed('/'),
        ),
      ],
    );
  }
}