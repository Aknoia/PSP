// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../controllers/elenco_controller/elenco_controller.dart';
import '../../utils/impostazioni.dart';
import '../../utils/api_helper.dart';

class ElencoBindings implements Bindings {
  ElencoBindings(this.numeroPagina);

  int numeroPagina;

  @override
  void dependencies() async {
    if (Get.isRegistered<APIHelper>()) {
      Get.find<APIHelper>().urlFarmacia.value = 'http://${DatiUtente.farmacia.url}/api';
      Get.find<APIHelper>().prendiToken();
    }

    Get.lazyPut(() => APIHelper(RxString('http://${DatiUtente.farmacia.url}/api')));
    Get.lazyPut(() => ElencoController(numeroPagina));
  }
}