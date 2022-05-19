
// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../utils/api_helper.dart';
import '../../defaultFunctions/estrai_numeri_stringa.dart';

class PromemoriaController extends GetxController with StateMixin {

  final _invendibili = RxInt(-1);
  int get invendibili => _invendibili.value;
  set invendibili(int nInvendibili) {
    _invendibili.value = nInvendibili;
  }

  final _demInScadenza = RxInt(-1);
  int get demInScadenza => _demInScadenza.value;
  set demInScadenza(int nDEM) {
    _demInScadenza.value = nDEM;
  }

  final _prodottiInScadenza = RxInt(-1);
  int get prodottiInScadenza => _prodottiInScadenza.value;
  set prodottiInScadenza(int nProdotti) {
    _prodottiInScadenza.value = nProdotti;
  }

  final _contabiliInScadenza = RxInt(-1);
  int get contabiliInScadenza => _contabiliInScadenza.value;
  set contabiliInScadenza(int nContabili) {
    _contabiliInScadenza.value = nContabili;
  }

  @override
  void onInit() {
    super.onInit();
    leggiStatistiche();
  }


  Future<void> leggiStatistiche() async {
    change([], status: RxStatus.loading());

    var risultato = await Future.wait([
      Get.find<APIHelper>().dammiInvendibili(),
      Get.find<APIHelper>().dammiDemInScadenza(),
      Get.find<APIHelper>().dammiScadProdotti(),
      Get.find<APIHelper>().dammiScadContabili()
    ]);

    invendibili = estraiNumeriStringa(risultato[0]['Risultato']);
    demInScadenza = estraiNumeriStringa(risultato[1]['Risultato']);
    prodottiInScadenza = estraiNumeriStringa(risultato[2]['Risultato']);
    contabiliInScadenza = estraiNumeriStringa(risultato[3]['Risultato']);

    change([], status: RxStatus.success());
  }
}