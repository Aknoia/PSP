// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:get/get.dart';


// Project imports:
import '../../utils/api_helper.dart';
import '../../modelli/ordine.dart';

class OrdineProvController extends GetxController with StateMixin {

  /// Controllers per TextField
  TextEditingController ctrlRicerca = TextEditingController();
  FocusNode ctrlFocus = FocusNode();

  /// Variabili reattive
  RxList listaGrossisti = RxList.empty(growable: true);
  RxList grossistiSelezionati = RxList.empty(growable: true);
  RxList listaOrdini = RxList<Ordine>.empty(growable: true);

  RxString vecchiaRicerca = RxString('');
  RxInt ultimaOperazione = RxInt(0);

  RxBool annullato = RxBool(true);
  RxBool inizializzato = RxBool(false);

  /// Timer per ricerche
  Timer debounce = Timer(const Duration(days: 1), () => {});
  Timer timer = Timer(const Duration(days: 1), () => {});

  @override
  void onInit() {
    super.onInit();

    //Controlla se si scrive nel textfield
    ctrlRicerca.addListener(() {
      if (debounce.isActive) debounce.cancel();

      debounce = Timer(const Duration(milliseconds: 400), () {
        if ((ctrlRicerca.text.length > 4) && (ctrlRicerca.text != vecchiaRicerca.value)) {
          change([], status: RxStatus.loading());

          grossistiSelezionati.clear();
          vecchiaRicerca.value = ctrlRicerca.text;

          avviaRicerca(ctrlRicerca.text);
        }
      });
    });

    avviaTimer();

    avviaRicerca('');
  }

  @override
  void onReady() {
    ctrlFocus.requestFocus();
  }

  @override
  void onClose() {
    FocusManager.instance.primaryFocus?.unfocus();
    ctrlRicerca.dispose();

    if (ctrlFocus.hasFocus) {
      ctrlFocus.unfocus();
    }

    ctrlFocus.dispose();

    super.onClose();
  }


  void avviaTimer() {
    timer.cancel();

    Timer.periodic(const Duration(seconds: 10), (tm) {
      timer = tm;
      riportaVendite(riportaGrossisti: false);
    });
  }


  /// Carica grossisti
  Future<void> caricaGrossisti() async {
    change([1], status: RxStatus.loading());

    listaGrossisti.clear();
    var grossisti = await Get.find<APIHelper>().dammiGrossisti();

    grossisti['grossisti'].forEach((grossista) {
      listaGrossisti.add(grossista['grossista']);
    });

    inizializzato.value = true;
    change([1], status: RxStatus.success());
  }


  Future<void> riportaVendite({bool riportaGrossisti = true}) async {
    if (riportaGrossisti) {
      await caricaGrossisti();
    }

    if (ultimaOperazione.value == 1) {
      avviaRicerca(vecchiaRicerca.value, riportaVendite: true);
    } else {
      avviaRicerca('', riportaVendite: true);
    }
  }


  Future avviaRicerca(String nome, {bool riportaVendite = false}) async {

    if (!riportaVendite) {
      change([], status: RxStatus.loading());
    }


    List risultati = [];

    if (nome.isNotEmpty) {
      risultati = await ricercaPerNome(nome.toLowerCase());
    } else if (grossistiSelezionati.isNotEmpty) {
      risultati = await ricercaPerGrossista();

      /// Controllo errori
    } else {

      if (riportaVendite) {
        change(['vuoto'], status: RxStatus.success());
      } else if (!annullato.value) {
        annullato.value = false;

        Get.snackbar(
          'ERRORE',
          'Selezionare almeno un grossista',
          colorText: Colors.black,
          backgroundColor: Colors.red,
        );
      }
    }

    if (risultati.isEmpty) {
      listaOrdini.clear();
      change([], status: RxStatus.empty());
    } else {
      if (!listEquals(listaOrdini, risultati)) {
        listaOrdini.clear();
        listaOrdini.addAll(risultati);
        refresh();
      }

      change([''], status: RxStatus.success());
    }
  }




  dynamic ricercaPerGrossista() async {
    try {
      List<Ordine> prodottiTrovati = List<Ordine>.empty(growable: true);
      List tmp = await Get.find<APIHelper>().dammiProdottiGrossisti(listaGrossisti);

      tmp = await Get.find<APIHelper>().dammiProdottiGrossisti((grossistiSelezionati.contains('tutti')) ? grossistiSelezionati.sublist(1) : grossistiSelezionati);
      ultimaOperazione.value = 2;

      if (tmp.isNotEmpty) {
        for (var prodottiGrossista in tmp) {
          for (var prodotto in prodottiGrossista) {
            prodottiTrovati.add(Ordine.fromJSON(prodotto));
          }
        }
      } else {
        return [];
      }

      return prodottiTrovati;
    } catch(e) {
      return [];
    }
  }




  dynamic ricercaPerNome(String nome) async  {
    try {
      List<Ordine> prodottiTrovati = List<Ordine>.empty(growable: true);
      List tmp = await Get.find<APIHelper>().dammiProdottiGrossisti(listaGrossisti);

      ultimaOperazione.value = 1;

      /// Filtro i risultati
      for (var tipoProdotto in tmp) {
        for (var prodotto in tipoProdotto) {
          if ((prodotto['codice'] == nome) || (prodotto['descrizione'].toLowerCase().contains(nome))) {
            prodottiTrovati.add(Ordine.fromJSON(prodotto));
          }
        }
      }

      return prodottiTrovati;
    } catch(e) {
      return [];
    }
  }







  void modificaCheckBox(int index, dynamic valore) {
    change([], status: RxStatus.loading());
    if (index == 0) {
      if (valore!) {
        grossistiSelezionati.clear();
        grossistiSelezionati.add('tutti');

        for (var grossista in listaGrossisti) {
          grossistiSelezionati.add(grossista);
        }

      } else {
        grossistiSelezionati.clear();
      }

    } else {
      if (valore!) {
        grossistiSelezionati.add(listaGrossisti[index - 1]);
      } else {
        grossistiSelezionati.remove(listaGrossisti[index - 1]);
      }
    }
    change([], status: RxStatus.success());
  }
}