// Dart imports:
import 'dart:async';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../utils/periodo.dart';
import '../../utils/api_helper.dart';
import '../../modelli/statistica.dart';

class PaginaStatisticheController extends GetxController with StateMixin {
  PaginaStatisticheController({this.tipoStatistica, required this.periodo});


  Periodo periodo;

  var statistiche = RxList();
  var filtro = RxString('');
  var ordinaMargine = RxBool(false);

  late TextEditingController ctrlFiltro;

  /// per evitare errore a chi ha la predizione del testo nella tastiera
  // ignore: prefer_typing_uninitialized_variables
  var debounce;

  // ignore: prefer_typing_uninitialized_variables
  var tipoStatistica;

  bool stop = false;

  @override
  void onInit() {
    super.onInit();

    ctrlFiltro = TextEditingController();

    leggiStatistiche();

    ctrlFiltro.addListener(() {
      if (debounce?.isActive ?? false) debounce.cancel();

      debounce = Timer(const Duration(milliseconds: 600), () {
        debugPrint(filtro.value);
        filtro.value = ctrlFiltro.text;
        update();
        debugPrint(filtro.value);
      });
    });
  }


  @override
  void onClose() {
    ctrlFiltro.dispose();
    super.onClose();
  }




  Future leggiStatistiche() async {

    change([], status: RxStatus.loading());

    dynamic libera = await Get.find<APIHelper>().dammiStatisticheReport(tipoStatistica, int.parse(periodo.annoIn!), int.parse(periodo.getMeseIn()), int.parse(periodo.getMeseOut()));

    if (libera.runtimeType.toString() == '_InternalLinkedHashMap<String, dynamic>' || libera.length < 1) {
      change([], status: RxStatus.empty());
    } else {
      /// Il metodo "sort" non riconosce il tipo di input proveniente da "a['totvalvenduto'].compareTo(b['totvalvenduto'])"
      /// Per risolvere questo problema, paragono i due valore, trasformo il risultato in una stringa e poi lo trasformo in un Integer
      /// In questo modo il metodo "sort" riconosce l'input e funziona

      var tmp = List.generate(
          libera.length,
              (index) => Statistica.fromJSON(libera[index]),
      );

      tmp.sort((b, a) => double.parse(a.totaleVenduto).compareTo(double.parse(b.totaleVenduto)));

      statistiche.value = tmp;

      change(libera, status: RxStatus.success());
    }
  }


}