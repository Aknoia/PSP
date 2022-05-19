// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../stati_cassa_controller.dart';
import '../../../utils/api_helper.dart';
import '../../../utils/enums.dart';
import '../../../utils/periodo.dart';
import '../../../defaultFunctions/controlla_valore_null.dart';
import '../../../modelli/utente.dart';
import '../../../modelli/storico_vendite.dart';

class StoricoVenditeController extends GetxController with StateMixin {

  RxList<Utente> listaTotaliUtenti = RxList();
  RxList<List<TotaleStorico>> storicoVenditeUtenti = RxList();
  RxInt indiceElementoCliccato = RxInt(0);


  late final _periodo = PeriodoData().obs;
  PeriodoData get periodo => _periodo.value;
  set periodo(PeriodoData nuovoStato) {
    _periodo.value = nuovoStato;
  }

  @override
  void onInit() {
    super.onInit();
    Get.put(StatiCassaController());

    StatiCassaController istanza = Get.find();
    periodo = istanza.giorniPeriodo[0];

    leggiStatistiche();
  }


  Future<void> leggiStatistiche() async {
    change([], status: RxStatus.loading());

    var dati = await Get.find<APIHelper>().dammiStatisticheCassa(
      TipoReport.storicoVendite,
      periodo.getDataIn(),
      periodo.getDataOut(),
    );

    if (!checkValoreNull(dati)) {
      _sistemaStatistiche(dati);
    } else {
      change([], status: RxStatus.empty());
    }
  }

  void _sistemaStatistiche(dynamic dati) {
    TotaleStorico totale = TotaleStorico.format(
      0,
      [],
      '00-00-0000 00:00:00',
    );

    List<Utente> listaUtenti = [];
    List<TotaleStorico> storicoVendite = [];

    /// Converto l'oggetto in lista per poterlo gestire meglio
    dati.values.toList().forEach((elemento) {
      /// Serializzo l'utente e lo aggiungo alla lista
      listaUtenti.add(Utente.fromJSON(elemento[0]['info'][0]));

      int tmpNumVen = -1;
      int contatore = 0;
      int numeroVendite = elemento[0]['vendite'].length;

      bool datiSalvati = false;

      /// Controllo se ho almeno una vendita
      if (numeroVendite > 0) {
        elemento[0]['vendite'].forEach((vendita) {
          VenditaSingola venditaAttuale = VenditaSingola.fromJSON(vendita);

          contatore++;
          datiSalvati = false;

          /// Controllo se è una vendita diversa, altrimenti aggiungo alla vendita precedente
          if (tmpNumVen != venditaAttuale.numeroVendita) {

            /// Se non ho ancora aggiunto niente
            /// creo una nuovo totale altrimenti inserisco nello stesso totale
            if (totale.importo > 0) {
              /// Aggiungo il totale precedente allo storico vendite
              storicoVendite.add(totale);

              /// Se è l'ultimo elemento allora salvo il totale
              if (contatore < numeroVendite) {
                datiSalvati = true;
              }

              /// Creo un nuovo totale vuoto
              totale = TotaleStorico.format(
                0,
                [],
                '00-00-0000 00:00:00',
              );

              /// Cambio il numero della vendita
              tmpNumVen = venditaAttuale.numeroVendita;

              /// Aggiungo nuova vendita al totale
              totale.dataStorico = venditaAttuale.dataVendita;
              totale.importo = totale.importo + venditaAttuale.totaleRicetta + venditaAttuale.totaleVendita;

              totale.dettaglio.add(venditaAttuale);
            } else {
             /// Aggiunge la vendita ad una lista totali vuota
              tmpNumVen = venditaAttuale.numeroVendita;

              totale.dataStorico = venditaAttuale.dataVendita;
              totale.importo = totale.importo + venditaAttuale.totaleVendita + venditaAttuale.totaleRicetta;

              totale.dettaglio.add(venditaAttuale);
            }

          } else {

            /// Continua ad aggiungere articoli stessa vendita
            totale.dataStorico = venditaAttuale.dataVendita;
            totale.importo = totale.importo + venditaAttuale.totaleRicetta + venditaAttuale.totaleVendita;
            totale.dettaglio.add(venditaAttuale);
          }
        });

        if (!datiSalvati) {
          storicoVendite.add(totale);
          storicoVenditeUtenti.add(storicoVendite);
          storicoVendite = [];
        }
      }
    });


    // Sort sulla base della data dello storico
    for (List<TotaleStorico> listaTotali in storicoVenditeUtenti) {
      var indice = storicoVenditeUtenti.indexOf(listaTotali);

      listaTotali.sort((a, b) => a.dataStorico.compareTo(b.dataStorico));

      storicoVenditeUtenti[indice] = listaTotali;
    }

    if (listaUtenti.isNotEmpty) {
      listaTotaliUtenti.value = listaUtenti;
      change([], status: RxStatus.success());
    } else {
      change([], status: RxStatus.empty());
    }
  }
}