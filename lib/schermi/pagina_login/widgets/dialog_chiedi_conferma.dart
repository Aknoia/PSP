// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../modelli/farmacia.dart';
import '../../../utils/impostazioni.dart';
import '../../../controllers/login_controller/pagina_login_controller.dart';


Future chiediConferma(Farmacia farmacia, String titolo, LoginController controller) async {
  await Get.dialog(
    AlertDialog(
      shape: RoundedRectangleBorder(
        side: BorderSide(width: 3.0, color: Get.theme.selectedRowColor),
        borderRadius: BorderRadius.circular(10.0),
      ),

      title: Text(
        titolo,
        textAlign: TextAlign.center,

      ),

      content: Text(
        farmacia.nome,
        textAlign: TextAlign.center,
      ),

      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),

              child: const Text(
                'Annulla',
                style: TextStyle(color: Colors.black),
              ),


              onPressed: () => Get.back(),
            ),

            TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),

              child: const Text(
                'Conferma',
                style: TextStyle(color: Colors.black),
              ),

              onPressed: () {

                controller.planetConfig.value.listaFarmacie.remove(farmacia);
                controller.listaFarmacie.remove(farmacia);


                if (controller.planetConfig.value.listaFarmacie.isEmpty) {
                  controller.nessunConfig.value = true;
                }

                DatiUtente.salvaConfigPlanet(controller.planetConfig.value.toJson());
                Get.back();
              }
            ),
          ],
        ),
      ],
    ),
  );
}