// Package imports:
import 'package:get/get.dart';
import 'package:enum_to_string/enum_to_string.dart';

// Project imports:
import '../../utils/periodo.dart';
import '../../utils/enums.dart';

class MenuStatisticheController extends GetxController {


  Rx<Periodo> dataSelezionata = Rx<Periodo>(Periodo());

  var tipoReport = TipoStatistica.degrasi.obs;

  var annoIn = DateTime.now().year.toString().obs;
  var annoOut = DateTime.now().year.toString().obs;

  var meseIn = Mese.gennaio.obs;
  var meseOut = Mese.febbraio.obs;

  void setAnnoInController(String nuovoAnno) {
    dataSelezionata.value.setAnnoIn(nuovoAnno);
    annoIn.value = nuovoAnno;
  }

  void setMeseInController(String nuovoMese) {
    dataSelezionata.value.setMeseIn(nuovoMese);
    meseIn.value = EnumToString.fromString(Mese.values, nuovoMese)!;
  }

  void setMeseOutController(String nuovoMese) {
    dataSelezionata.value.setMeseOut(nuovoMese);
    meseOut.value = EnumToString.fromString(Mese.values, nuovoMese)!;
  }

  void setTipoStatisticaController(String nuovoTipoReport) {
    tipoReport.value = EnumToString.fromString(TipoStatistica.values, nuovoTipoReport)!;
  }
}