// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../controllers/ordine_provvisorio_controller/aggiungi_ordine_controller.dart';

class AggiungiOrdineBinding implements Bindings {
  AggiungiOrdineBinding(this.listaGrossisti);

  List listaGrossisti;

  @override
  void dependencies() {
    Get.put(AggiungiOrdineController(listaGrossisti));
  }
}