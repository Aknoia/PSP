// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../utils/api_helper.dart';

class InserisciPostITController extends GetxController {
  InserisciPostITController(this.minsan, this.descrizioneProdotto);

  final String descrizioneProdotto;
  final String minsan;

  late TextEditingController ctrlDescrizione;
  late TextEditingController ctrlQta;
  late TextEditingController ctrlNote;
  late TextEditingController ctrlCliente;
  late TextEditingController ctrlTelefono;

  final chiaveFormPOSTIT = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    ctrlDescrizione = TextEditingController(text: descrizioneProdotto);
    ctrlQta = TextEditingController(text: '1');
    ctrlNote = TextEditingController();
    ctrlCliente = TextEditingController();
    ctrlTelefono = TextEditingController();
  }

  @override
  void onClose() {
    ctrlDescrizione.dispose();
    ctrlQta.dispose();
    ctrlCliente.dispose();
    ctrlTelefono.dispose();
    ctrlNote.dispose();

    super.onClose();
  }



  void salvaPostIt() async {

    int esito = await Get.find<APIHelper>().inviaPostIt(minsan, ctrlNote.text, ctrlQta.text, ctrlCliente.text, ctrlTelefono.text);

    if (esito == 201) {

      Get.snackbar(
        'Esito operazione',
        'PostIT salvato correttamente',
        backgroundColor: Colors.green.shade800,
        colorText: Colors.black,
      );

    } else {
      Get.snackbar(
        'Esito operazione',
        'Errore inserimento postit: $esito',
        backgroundColor: Colors.red.shade900,
        colorText: Colors.black,
      );

    }
  }
}