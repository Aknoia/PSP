// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../controllers/ordine_provvisorio_controller/modifica_ordine_controller.dart';
import '../../modelli/ordine.dart';

class ModificaOrdineBinding implements Bindings {
  ModificaOrdineBinding(this.prodotti, this.grossisti, this.indice);

  final List<Ordine> prodotti;

  final List grossisti;

  final int indice;

  @override
  void dependencies() {
    Get.put(
        ModificaOrdineController(
          RxString(prodotti[indice].minsan),
          prodotti,
          RxInt(indice),
          grossisti,
          RxString(prodotti[indice].ditta)
        ),
    );
  }

}