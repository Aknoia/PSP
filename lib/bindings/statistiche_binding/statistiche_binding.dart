// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../controllers/menu_statistiche_controller/pagina_statistiche_controller.dart';
import '../../utils/periodo.dart';
import '../../utils/enums.dart';

class StatisticheBinding implements Bindings {
  StatisticheBinding(this.periodo, this.tipoStatistica);

  Periodo periodo;

  TipoStatistica tipoStatistica;

  @override
  void dependencies() {
    Get.put(PaginaStatisticheController(periodo: periodo, tipoStatistica: tipoStatistica));
  }
}