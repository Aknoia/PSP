// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/scheda_prodotto_controller/scheda_prodotto_controller.dart';
import '../../../modelli/prodotto.dart';

class SchedaProdottoBinding implements Bindings {
  SchedaProdottoBinding(this.prodotto);

  Prodotto prodotto;

  @override
  void dependencies() {
    Get.put(SchedaProdottoController(prodotto));
  }
}