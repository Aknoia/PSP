// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../controllers/stati_cassa_controller/vendite_controller/vendite_utenti_controller.dart';
import '../../utils/periodo.dart';

class VenditeUtentiBinding implements Bindings {
  VenditeUtentiBinding({required this.periodo});

  PeriodoData periodo;

  @override
  void dependencies() {
    Get.put(VenditeUtentiController(periodo));
  }
}