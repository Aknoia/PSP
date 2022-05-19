// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../controllers/stati_cassa_controller/vendite_controller/storico_vendite_controller.dart';

class StoricoVenditeBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(StoricoVenditeController());
  }
}