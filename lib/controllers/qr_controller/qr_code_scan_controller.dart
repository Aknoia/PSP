// Dart imports:
import 'dart:convert';

// Package imports:

import 'package:get/get.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

// Project imports:
import '../../modelli/farmacia.dart';
import '../../utils/impostazioni.dart';
import '../../defaultFunctions/prendi_int.dart';

class QRCodeController extends GetxController {
  RxBool inErrore = RxBool(false);

  RxString codice = RxString('');

  Future<void> leggiQRCode() async {

    var result = await BarcodeScanner.scan();

    try {
      Farmacia nuovaFarmacia = Farmacia.fromJSON(jsonDecode(result.rawContent));

      /// Verifico la presenza del protocollo
      if (nuovaFarmacia.url.contains('https')) {
        nuovaFarmacia.url = nuovaFarmacia.url.substring(8);
      } else if (nuovaFarmacia.url.contains('http')) {
        nuovaFarmacia.url = nuovaFarmacia.url.substring(7);
      }

      /// Verifico la presenza della resource
      if (nuovaFarmacia.url.contains('api')) {
        nuovaFarmacia.url = nuovaFarmacia.url.substring(0, nuovaFarmacia.url.indexOf('/'));
      }

      /// Salvo la porta
      nuovaFarmacia.porta = prendiInt(nuovaFarmacia.url.substring(nuovaFarmacia.url.indexOf(':') + 1));

      DatiUtente.aggiornaFarmacia(nuovaFarmacia.toJson());
      DatiUtente.farmacia = nuovaFarmacia;

    } catch (e) {
      DatiUtente.salvaToken(e.toString());
      DatiUtente.salvaUrl(e.toString());

      inErrore.value = true;
    }
  }
}