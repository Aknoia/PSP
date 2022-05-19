// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../controllers/zoom_controller/inserisci_postit_controller.dart';

class InserisciPostITBinding implements Bindings {
  InserisciPostITBinding(this.minsan, this.descrizione);

  String minsan;
  String descrizione;

  @override
  void dependencies() {
    Get.put(InserisciPostITController(minsan, descrizione));
  }
}