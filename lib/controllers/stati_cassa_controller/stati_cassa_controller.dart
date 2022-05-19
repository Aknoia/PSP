// Package imports:
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

// Project imports:
import '../../utils/enums.dart';
import '../../utils/periodo.dart';
import '../../utils/api_helper.dart';

class StatiCassaController extends GetxController with StateMixin{

  final _tempoReport = TempoReport.giorno.obs;
  final _indiceSelezionato = 0.obs;

  var offsetPeriodo = 0.obs;
  var vendite = [].obs;
  var giorniPeriodo = [PeriodoData(), PeriodoData()].obs;


  late var venditePrecedenti = [].obs;

  List<DateTime> intervallo = [DateTime.now(), DateTime.now()];


  int get indiceSelezionato => _indiceSelezionato.value;
  set indiceSelezionato(int nuovoIndice) {
    _indiceSelezionato.value = nuovoIndice;
  }

  TempoReport get tempoReport => _tempoReport.value;
  set tempoReport(TempoReport nuovoTempoReport) {
    _tempoReport.value = nuovoTempoReport;
  }



  @override
  void onInit() {
    super.onInit();
    leggiStatistiche();
  }




  Future leggiStatistiche() async {

    change([], status: RxStatus.loading());

    giorniPeriodo.value = _getPeriodo();

    venditePrecedenti.value = await Get.find<APIHelper>().dammiStatisticheCassa(
      TipoReport.statisticheDiCassa,
      giorniPeriodo[1].getDataIn(),
      giorniPeriodo[1].getDataOut(),
    );

    if (tempoReport == TempoReport.intervallo) {
      vendite.value = venditePrecedenti;
    } else {
      vendite.value = await Get.find<APIHelper>().dammiStatisticheCassa(
        TipoReport.statisticheDiCassa,
        giorniPeriodo[0].getDataIn(),
        giorniPeriodo[0].getDataOut(),
      );
    }

    change(vendite, status: RxStatus.success());
  }





  List <PeriodoData> _getPeriodo() {

    PeriodoData periodo1, periodo2;

    dynamic adesso = DateTime.now();

    switch(tempoReport) {
      case TempoReport.intervallo:
      /// Considera l'intervallo selezionato e lo confronta con nulla
        periodo1 = PeriodoData(
          giornoData1: intervallo[0].day,
          meseData1: intervallo[0].month,
          annoData1: intervallo[0].year,
          giornoData2: intervallo[1].day,
          meseData2: intervallo[1].month,
          annoData2: intervallo[1].year,
        );

        /// dal primo all'ultimo del mese precedente
        periodo2 = PeriodoData(
          giornoData1: intervallo[0].day,
          meseData1: intervallo[0].month,
          annoData1: intervallo[0].year,
          giornoData2: intervallo[1].day,
          meseData2: intervallo[1].month,
          annoData2: intervallo[1].year,
        );

        /// FEDERICO MUSCO 29/12/2021
        /// Modifica l'intervallo secondo l'offset
        periodo1.dataIn = periodo1.dataIn?.add(Duration(days: offsetPeriodo.value));
        periodo1.dataOut = periodo1.dataOut?.add(Duration(days: offsetPeriodo.value));
        periodo2.dataIn = periodo2.dataIn?.add(Duration(days: offsetPeriodo.value));
        periodo2.dataOut = periodo2.dataOut?.add(Duration(days: offsetPeriodo.value));

        break;

      case TempoReport.giorno:
        Duration durata = const Duration(days: 7);

        adesso = adesso.add(Duration(days: offsetPeriodo.value));

        periodo1 = PeriodoData(
          giornoData1: adesso.day,
          meseData1: adesso.month,
          annoData1: adesso.year,
          giornoData2: adesso.day,
          meseData2: adesso.month,
          annoData2: adesso.year,
        );

        periodo2 = PeriodoData(
          giornoData1: adesso.subtract(durata).day,
          meseData1: adesso.subtract(durata).month,
          annoData1: adesso.subtract(durata).year,
          giornoData2: adesso.subtract(durata).day,
          meseData2: adesso.subtract(durata).month,
          annoData2: adesso.subtract(durata).year,
        );

        break;

      case TempoReport.mese:
        adesso = Jiffy(adesso).add(days: offsetPeriodo.value);

        periodo1 = PeriodoData(
          giornoData1: 1,
          meseData1: adesso.month,
          annoData1: adesso.year,
          giornoData2: adesso.day,
          meseData2: adesso.month,
          annoData2: adesso.year,
        );

        // Dal primo all'ultimo del mese precedente
        periodo2 = PeriodoData(
          giornoData1: 1,
          meseData1: adesso.month-1,
          annoData1: adesso.year,
          giornoData2: 0,
          meseData2: adesso.month,
          annoData2: adesso.year,
        );
        break;

      case TempoReport.anno:
        adesso = Jiffy().add(years: offsetPeriodo.value);

        periodo1 = PeriodoData(
          giornoData1: 1,
          meseData1: 1,
          annoData1: adesso.year,
          giornoData2: adesso.day,
          meseData2: adesso.month,
          annoData2: adesso.year,
        );

        // Controllo anno bisestile
        if ((adesso.day == 29) &&(adesso.month == 2)) {
          periodo2 = PeriodoData(
            giornoData1: 1,
            meseData1: 1,
            annoData1: adesso.year-1,
            giornoData2: adesso.day-1,
            meseData2: adesso.month,
            annoData2: adesso.year-1,
          );
        } else {
          periodo2 = PeriodoData(
            giornoData1: 1,
            meseData1: 1,
            annoData1: adesso.year-1,
            giornoData2: adesso.day,
            meseData2: adesso.month,
            annoData2: adesso.year-1,
          );
        }
        break;

      case TempoReport.meseAnnoPrec:
        adesso = Jiffy().add(months: offsetPeriodo.value);

        periodo1 = PeriodoData(
          giornoData1: 1,
          meseData1: adesso.month,
          annoData1: adesso.year,
          giornoData2: adesso.day,
          meseData2: adesso.month,
          annoData2: adesso.year,
        );
        // controlla anno bisestile
        if ((adesso.day == 29) && (adesso.month == 2)) {
          periodo2 = PeriodoData(
            giornoData1: 1,
            meseData1: adesso.month,
            annoData1: adesso.year-1,
            giornoData2: adesso.day-1,
            meseData2: adesso.month,
            annoData2: adesso.year-1,
          );
        } else {
          periodo2 = PeriodoData(
            giornoData1: 1,
            meseData1: adesso.month,
            annoData1: adesso.year-1,
            giornoData2: adesso.day,
            meseData2: adesso.month,
            annoData2: adesso.year-1,
          );
        }
        break;
    }

    return [periodo1,periodo2];
  }
}