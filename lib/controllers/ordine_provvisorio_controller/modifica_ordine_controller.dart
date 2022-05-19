// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import '../../theme/shapes.dart';
import '../../theme/dimensioni.dart';
import '../../utils/api_helper.dart';
import '../../modelli/ordine.dart';
import '../../modelli/statistica_ordine.dart';
import '../../modelli/offerta.dart';
import '../../modelli/generico.dart';


class ModificaOrdineController extends GetxController with StateMixin {
  ModificaOrdineController(this.minsan, this.listaProdotti, this.indice, this.listaGrossisti, this.grossistaOriginale);

  /// Controller attivi nella pagina
  ScrollController ctrlScroll      = ScrollController();
  TextEditingController ctrlDescrizione = TextEditingController();
  TextEditingController ctrlGrossista   = TextEditingController();
  TextEditingController ctrlDisp        = TextEditingController();
  TextEditingController ctrlQtaVenduta  = TextEditingController();
  TextEditingController ctrlQtaTot      = TextEditingController();
  FocusNode ctrlFocusQtaVen = FocusNode();

  /// Variabili Reactive
  RxInt genericiTotali = RxInt(0);
  RxInt offerteTotali = RxInt(0);
  RxInt indice = RxInt(0);

  RxString minsan = RxString('');
  RxString grossistaOriginale = RxString('');
  RxString grossistaAttuale = RxString('');

  RxList infoOrdine = RxList([]);
  RxList listaStatistiche = RxList([]);

  RxBool toccato = RxBool(false);

  /// Variabili di lavoro
  List<Ordine> listaProdotti;
  List listaGrossisti = [];

  @override
  void onInit() {
    super.onInit();

    grossistaAttuale.value = grossistaOriginale.value;


    /// Inizializzo la lista delle statistiche
    listaStatistiche.addAll(StatisticaOrdine.defaultList(minsan.value));

    cambiaOrdineInMostra(listaProdotti[indice.value], 0);
  }


  Future<void> prendiInformazioni() async {
    change([], status: RxStatus.loading());

    var tmp = await Future.wait([
      Get.find<APIHelper>().dammiDisponibilita(minsan.value),
      Get.find<APIHelper>().dammiOfferteMinsan(minsan.value),
      Get.find<APIHelper>().dammiGenerici(minsan.value),
      Get.find<APIHelper>().dammiStatisticheProdottoPeriodo(minsan.value, DateTime.now().year, mesedal: 1, meseal: 12),
    ]);

    genericiTotali.value = tmp[2].length;
    offerteTotali.value = tmp[1].length;
    ctrlDisp.text = (tmp[0] == -1) ? '0' : tmp[0].toString();

    infoOrdine.value = serializzaInformazioni(tmp);

    change(tmp, status: RxStatus.success());
  }

  List serializzaInformazioni (var tmp) {
    for (var placeHolder in listaStatistiche) {
      for (var statistica in tmp[3]['Statistiche']) {
        if (placeHolder.mese == statistica['mese']) {
          listaStatistiche[listaStatistiche.indexOf(placeHolder)] = StatisticaOrdine.fromJSON(statistica);
        }
      }
    }

    return [
      tmp[0],

      List.generate(tmp[1].length, (index) => Offerta.fromJSON(tmp[1][index])),

      List.generate(tmp[2].length, (index) => Generico.fromJson(tmp[2][index])),

      listaStatistiche,
    ];
  }






  void cambiaOrdineInMostra(Ordine ordineAttuale, int disponibilita) {
    minsan.value = ordineAttuale.minsan;

    prendiInformazioni();

    ctrlDisp.text         = disponibilita.toString();
    ctrlQtaTot.text       = ordineAttuale.qtaTotale.toString();
    ctrlQtaVenduta.text   = ordineAttuale.qtaTotale.toString();
    ctrlDescrizione.text  = ordineAttuale.descrizione;
    ctrlGrossista.text    = ordineAttuale.ditta;
  }


  Future<void> cambiaGrossista() async {
    await Get.dialog(
      AlertDialog(
        shape: kShapeAlertDialog,

        title: const Text(
          'Scegli un nuovo grossista',
          textAlign: TextAlign.center,
        ),

        content: SizedBox(
          height: altezzaSchermo,
          width: larghezzaSchermo - 200,

          child: ListView.builder(
            shrinkWrap: true,
            itemCount: listaGrossisti.length,

            itemBuilder: (context, index) {
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.all(10.0),
                shape: kCardShape,

                child: ListTile(
                  title: const AutoSizeText(
                    'Grossista',
                    textAlign: TextAlign.center,
                    minFontSize: 18.0,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  subtitle: Text(
                    '${listaGrossisti[index]}',
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),

                  onTap: () {
                    grossistaOriginale.value = grossistaAttuale.value;

                    grossistaAttuale.value = listaGrossisti[index];

                    ctrlGrossista.text = grossistaAttuale.value;

                    Get.back();
                  },
                ),
              );
            },
          ),
        ),

        actionsAlignment: MainAxisAlignment.start,
        actions: [
          Container(
            padding: const EdgeInsets.all(5.0),
            width: larghezzaSchermo / 4.0,

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    side: BorderSide(
                      width: 1.0,
                      color: Get.theme.selectedRowColor,
                    ),
                  )
              ),

              onPressed: () => Get.back(),
              child: Text(
                'Annulla',
                style: TextStyle(
                  color: Colors.red.shade900,
                ),
              ),
            ),
          ),
        ],
      ),

      barrierDismissible: false,
    );
  }






  Future<void> confermaOrdine() async {
    /// Elimino la riga per modificarla
    int esito = await Get.find<APIHelper>().eliminaRigaOrdine(grossistaOriginale.value, minsan.value);

    /// Controllo se il record è stato eliminato
    try {
      if (esito == 201) {
        esito = await Get.find<APIHelper>().creaRigaOrdine(grossistaAttuale.value, minsan.value, int.parse(ctrlQtaVenduta.text));

        /// Se il nuovo ordine è stato inserito
        if (esito == 201) {
          Get.closeAllSnackbars();

          Get.snackbar(
            'MODIFICA AVVENUTA',
            'Ordine modificato con successo',
            backgroundColor: Colors.green.shade600,
          );

          Get.offNamed(
            '/modificaordine',
            arguments: [listaProdotti, listaGrossisti, indice.value, 'L'],
            preventDuplicates: false,
          );
        }
      }
    } catch (e) {
      Get.snackbar(
        'ERRORE MODIFICA',
        'Errore: $e',
      );
    }
  }




  Future<void> eliminaOrdine(int indiceAttuale) async {
    bool elimina = await Get.dialog(
      AlertDialog(
        shape: kShapeAlertDialog,

        title: const Text(
          'ATTENZIONE',
          textAlign: TextAlign.center,

        ),

        content: const Text(
          "Conferma per eliminare l'ordine",
          textAlign: TextAlign.center,
        ),

        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),

                child: const Text(
                  'Annulla',
                  style: TextStyle(color: Colors.black),
                ),


                onPressed: () => Get.back(result: false),
              ),

              TextButton(
                  style: TextButton.styleFrom(backgroundColor: Colors.green),

                  child: const Text(
                    'Conferma',
                    style: TextStyle(color: Colors.black),
                  ),

                  onPressed: () => Get.back(result: true),
              ),
            ],
          ),
        ],
      ),
    );

   if (elimina) {
     int esito = await Get.find<APIHelper>().eliminaRigaOrdine(grossistaAttuale.value, minsan.value);

     if (esito == 201) {
       listaProdotti[indiceAttuale].quantita = 0;

       Get.back();

       Get.snackbar(
         'ESITO OPERAZIONE',
         'Riga ordine eliminata correttamente',
         backgroundColor: Colors.green,
       );

     } else {
       Get.snackbar(
         'ESITO OPERAZIONE',
         'Errore eliminazione ordine: $esito',
         backgroundColor: Colors.red,
       );
     }
   }
  }


  ///Mostra i generici del prodotto dell'ordine
  void mostraGenerici() {
    List<Generico> generici = infoOrdine[2];

    Get.dialog(
      AlertDialog(
        shape: kShapeAlertDialog,

        title: const Text(
          'Generici',
          textAlign: TextAlign.center,
        ),

        content: SizedBox(
          width: larghezzaSchermo - 50,
          child: Scrollbar(
            thickness: 5,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: genericiTotali.value,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),

                  child: Card(
                    elevation: 5.0,
                    shape: kShapeOrdineProv,

                    child: InkWell(
                      onTap: () => impostaGenerico(generici[index]),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: <Widget>[
                          const SizedBox(height: 5.0),

                          AutoSizeText(generici[index].descrizione, textAlign: TextAlign.left, style: const TextStyle(fontWeight: FontWeight.bold),),

                          const SizedBox(height: 5.0),

                          AutoSizeText('Minsan: ${generici[index].codice}', maxLines: 1, textAlign: TextAlign.left),

                          const SizedBox(height: 5.0),

                          AutoSizeText('Prezzo: ${generici[index].prezzoCalc}€', textAlign: TextAlign.left),

                          const SizedBox(height: 5.0),

                         AutoSizeText.rich(
                           TextSpan(
                             text: 'Disponibilità: ',
                             children: [TextSpan(text: '${generici[index].dispMagazzino}', style: TextStyle(color: generici[index].dispMagazzino > 0 ? Colors.green : Colors.red))]
                           ),
                         ),

                          const SizedBox(height: 5.0),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        actionsAlignment: MainAxisAlignment.start,
        actions: [
          TextButton(
              onPressed: () => Get.back(),

              style: ElevatedButton.styleFrom(
                shape: kShapeOrdineProv,
              ),

              child: const Text(
                'Esci',
                style: TextStyle(color: Colors.red),
              ),
          )
        ],
      ),

      barrierDismissible: false,
    );
  }

  /// Mostra l'offerta selezionata prima di confermarla
  Future mostraOffertaScelta(int indiceOfferta) async {
    Offerta offertaSelezionata = infoOrdine[1][indiceOfferta];

    return Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 3.0, color: Get.theme.selectedRowColor),
          borderRadius: BorderRadius.circular(10.0),
        ),

        title: const Text(
          'OFFERTA SELEZIONATA',
          textAlign: TextAlign.center,

        ),

        content: SizedBox(
          height: 120,
          width: larghezzaSchermo - 200,

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: <AutoSizeText>[
              AutoSizeText(
                'Fornitore: ${offertaSelezionata.fornitore}',
                maxLines: 1,
                minFontSize: 16,
                textAlign: TextAlign.center,
              ),

              AutoSizeText(
                'Codice: ${offertaSelezionata.codiceFornitore}',
              ),

              AutoSizeText(
                'Quantità: ${offertaSelezionata.quantita} Pz.',
              ),

              AutoSizeText(
                'Costo: ${offertaSelezionata.costo}€',
              ),
            ],
          ),
        ),

        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              TextButton(
                style: TextButton.styleFrom(shape: kShapeOrdineProv),

                child: const Text(
                  'Annulla',
                  style: TextStyle(color: Colors.red),
                ),


                onPressed: () => Get.back(result: false),
              ),

              TextButton(
                  style: TextButton.styleFrom(shape: kShapeOrdineProv),

                  child: const Text(
                    'Conferma',
                    style: TextStyle(color: Colors.green),
                  ),

                  onPressed: () => Get.back(result: true),
              ),
            ],
          ),
        ],
      ),
    );
  }






  /// Gestione degli swipe
  void swipeSinistro() {

    /// Controllo se devo eliminare l'ordine o meno
    if (ctrlQtaVenduta.text == '0') {
      eliminaOrdine(indice.value);
    } else {
      if ((indice.value + 1) >= listaProdotti.length) {
        Get.snackbar(
          'Errore cambio pagina',
          'Nessun ordine successivo',
          backgroundColor: Colors.red,
        );

      } else {
        indice.value++;

        confermaOrdine();
      }
    }
  }

  void swipeDestro() {
    if (indice.value == 0) {
      Get.snackbar(
        'Errore cambio pagina',
        'Nessun ordine precedente',
        backgroundColor: Colors.red,
      );
    } else {
      indice.value--;

      Get.offNamed(
        '/modificaordine',
        arguments: [listaProdotti, listaGrossisti, indice.value, 'R'],
        preventDuplicates: false,

      );
    }
  }


  void impostaGenerico(Generico generico) {
    minsan.value = generico.codice;

    prendiInformazioni();

    ctrlDisp.text         = generico.dispMagazzino.toString();
    ctrlQtaTot.text       = generico.dispMagazzino.toString();
    ctrlQtaVenduta.text   = '1';
    ctrlDescrizione.text  = generico.descrizione;
    ctrlGrossista.text    = grossistaAttuale.value;

    // Chiude dialog
    Get.back();
  }
}




