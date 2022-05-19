// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../utils/periodo.dart';
import '../../../utils/enums.dart';
import '../../../utils/api_helper.dart';
import '../../../modelli/vendita_utente.dart';
import '../../../modelli/informazioni_utente.dart';

class VenditeUtentiController extends GetxController with StateMixin {
  VenditeUtentiController(this.periodo);

  PeriodoData periodo;


  RxList<VenditeUtente> vendite = RxList([]);
  
  RxList<InformazioniUtente> infoUtenti = RxList([]);

  @override
  void onInit() {
    super.onInit();

    leggiStatistiche();
  }


  Future<void> leggiStatistiche() async {
    change([], status: RxStatus.loading());

    await leggiStatisticheTempo();


    var tmp = await Get.find<APIHelper>().dammiStatisticheCassa(
      TipoReport.statisticheDiCassaAllUsers,
      periodo.getDataIn(),
      periodo.getDataOut(),
    );

    /// Genero la lista serializzata
    serializzaVenditeUtenti(tmp);
  }



  void serializzaVenditeUtenti(var mapUtenti) {
    List<String> nomiUtenti = List.empty(growable: true);

    if (mapUtenti is Map) {
      nomiUtenti = mapUtenti.keys.toList() as List<String>;
    }


    var tmp = List.generate(
        nomiUtenti.length,
            (index) => VenditeUtente.fromJSON(nomiUtenti[index], mapUtenti[nomiUtenti[index]])
    );

    if (tmp.isNotEmpty) {
      vendite.value = tmp;
      change([], status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
    }
  }





  Future leggiStatisticheTempo() async {

    List<InformazioniUtente> generaliUtenti = List<InformazioniUtente>.empty(growable: true);

    var risultato = await Get.find<APIHelper>().dammiStatisticheCassa(
      TipoReport.storicoVendite,
      periodo.getDataIn(),
      periodo.getDataOut(),
    );

    if (risultato != null) {
      risultato.values.toList().forEach((element) {
        generaliUtenti.add(InformazioniUtente.fromJSON(element[0]['info'][0]));
      });
      
      infoUtenti.value = generaliUtenti;
    } else {
      change([], status: RxStatus.empty());
    }
  }
}