// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../utils/api_helper.dart';

class AdvisorController extends GetxController with StateMixin {

  RxString sospesi = RxString('-1');

  RxString prenotazioni = RxString('-1');


  @override
  void onInit() {
    super.onInit();
    leggiStatistiche();
  }


  Future leggiStatistiche() async {
    change([], status: RxStatus.loading());

    List statistiche = await Future.wait([
      Get.find<APIHelper>().dammiSospesiAperti(),
      Get.find<APIHelper>().dammiPrenotazioniAperte()
    ]);

    if ((statistiche[0]['Risultato'] != null) && (statistiche[1]['Risultato'] != null)) {
      sospesi.value       = statistiche[0]['Risultato'].toString();
      prenotazioni.value  = statistiche[1]['Risultato'].toString();
    }

    change([], status: RxStatus.success());
  }
}