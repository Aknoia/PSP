// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../utils/api_helper.dart';

class CreaPrenotazioneController extends GetxController {
  CreaPrenotazioneController(this.codiceProdotto);

  var idPrenotazione = RxInt(-1);

  String codiceProdotto;

  late TextEditingController ctrlMinsan;
  late TextEditingController ctrlQta;
  late TextEditingController ctrlCliente;
  late TextEditingController ctrlTelefono;
  late TextEditingController ctrlCodiceFiscale;
  late TextEditingController ctrlNote;

  final chiaveFormPrenotazione = GlobalKey<FormState>();


  @override
  void onInit() {
    super.onInit();

    ctrlMinsan = TextEditingController(text: codiceProdotto);
    ctrlQta = TextEditingController(text: '1');
    ctrlCliente = TextEditingController();
    ctrlTelefono = TextEditingController();
    ctrlCodiceFiscale = TextEditingController();
    ctrlNote = TextEditingController();
  }

  @override
  void onClose() {
    ctrlMinsan.dispose();
    ctrlQta.dispose();
    ctrlCliente.dispose();
    ctrlTelefono.dispose();
    ctrlCodiceFiscale.dispose();
    ctrlNote.dispose();

    super.onClose();
  }

  void setCampiDefault() {
    ctrlQta.text = '1';
    ctrlCliente.clear();
    ctrlTelefono.clear();
    ctrlCodiceFiscale.clear();
    ctrlNote.clear();
  }


  Future confermaPrenotazione() async {

    dynamic tmp;

    tmp = await Get.find<APIHelper>().creaPrenotazione(ctrlMinsan.text, int.parse(ctrlQta.text), ctrlCliente.text, ctrlTelefono.text, ctrlCodiceFiscale.text, ctrlNote.text);

    idPrenotazione.value = int.parse(tmp['idPren']);

    var esito2 = await Get.find<APIHelper>().inserisciArticoloInOrdine(idPrenotazione.value);

    setCampiDefault();

    if (esito2 == 201) {

      Get.snackbar(
        'Esito operazione',
        'Prenotazione confermata correttamente',
        backgroundColor: Colors.green.shade800,
        colorText: Colors.black,
      );


    } else {
      Get.snackbar(
        'Esito operazione',
        'Errore prenotazione: $esito2',
        backgroundColor: Colors.red.shade900,
        colorText: Colors.black,
      );
    }
  }
}