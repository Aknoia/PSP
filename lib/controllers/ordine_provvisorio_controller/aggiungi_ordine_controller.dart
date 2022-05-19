// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

// Project imports:
import '../../modelli/prodotto.dart';
import '../../theme/shapes.dart';
import '../../theme/dimensioni.dart';
import '../../utils/impostazioni.dart';
import '../../utils/api_helper.dart';
import '../../defaultsWidgets/widget_in_caricamento.dart';

class AggiungiOrdineController extends GetxController with StateMixin {
  AggiungiOrdineController(this.listaGrossisti);

  /// Controllers
  var ctrlGrossista     = TextEditingController(text: '');
  var ctrlQta           = TextEditingController(text: '1');
  var ctrlRicerca       = TextEditingController();

  /// Responsive variables
  RxList<Prodotto> listaProdotti = RxList();

  Rx<Prodotto> prodottoSelezionato = Rx<Prodotto>(Prodotto.fromDefault());

  RxString testoErrore = RxString('');

  RxDouble prezzoTotale = RxDouble(0.0);

  /// Non responsive
  final chiaveFormOrdini = GlobalKey<FormState>();

  List<dynamic> listaGrossisti;


  @override
  void onClose() {
    ctrlGrossista.dispose();
    ctrlRicerca.dispose();
    ctrlQta.dispose();

    super.onClose();
  }

  @override
  Future<void> onReady() async {

    /// Chiedo che prodotto cercare
    bool operazione =  await _mostraBarraRicerca();

    /// Controllo se l'operazione è stata annullata
    if (operazione) {
      Get.offNamed(
        '/homepage',
        arguments: [3],
      );
    } else {
      operazione = await _mostraProdotti();

      /// Controllo se si vuole riprovare la ricerca
      if (operazione) {
        
        _mostraBarraRicerca();
      }
    }

    try {
      ctrlGrossista.text = await DatiUtente.recuperaFornitoreDefault();
    } catch(e) {
      ctrlGrossista.text = 'X';
    }

    super.onReady();
  }




  void cercaProdotto(String? codice) async {
    change([], status: RxStatus.loading());

    /// Se codice è vuoto, allora assume il valore della ricerca
    codice ??= ctrlRicerca.text;


    List tmp = await Get.find<APIHelper>().dammiProdottoLista(codice);

    if (tmp.isEmpty) {
      change([], status: RxStatus.empty());
    } else {
      change([], status: RxStatus.success());
      listaProdotti.value = List.generate(tmp.length, (index) => Prodotto.fromJSON(tmp[index]));
    }
  }






  Future<bool> _mostraBarraRicerca() async {
    return await Get.dialog(
      AlertDialog(
        elevation: 10.0,
        shape: kShapeAlertDialog,

        title: const Center(
          child: Text(
            'Cerca prodotto',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        content: Column(
          mainAxisSize: MainAxisSize.min,

          children: <Widget>[
            const SizedBox(height: 10.0),

            SizedBox(
              width: larghezzaSchermo,
              height: 60.0,

              child: Form(
                key: chiaveFormOrdini,

                child: TextFormField(
                  controller: ctrlRicerca,
                  autofocus: true,

                  style: const TextStyle(
                    fontSize: 10.0,
                  ),

                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Get.theme.selectedRowColor,
                      ),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        width: 1.0,
                        color: Get.theme.selectedRowColor,
                      ),
                    ),

                    hintText: 'Inserisci nome prodotto',
                    hintStyle: const TextStyle(fontSize: 12.0),

                    prefixIcon: IconButton(
                      icon: Image.asset(
                        'assets/defaultIcons/fotocamera.png',
                        color: Colors.green,
                        semanticLabel: 'Cerca Prodotto',
                        scale: 1.2,
                      ),

                      onPressed: () async {

                        try {
                          var risultato = await BarcodeScanner.scan(
                            options: const ScanOptions(
                              restrictFormat: [
                                BarcodeFormat.code39,
                                BarcodeFormat.ean8,
                                BarcodeFormat.ean13
                              ],
                            ),
                          );

                          String codice = risultato.rawContent;

                          if (codice.length > 16) {
                            codice = codice.substring(0, 16);
                          }

                          if (codice.length > 5) {
                            cercaProdotto(codice);
                            Get.back(result: false);
                          }

                        } catch(e) {
                          Get.snackbar(
                            'Descrizione errore:',
                            '$e',
                            backgroundColor: Colors.red,
                            colorText: Colors.black,
                          );
                        }
                      },
                    ),

                    suffixIcon: Image.asset(
                      'assets/defaultIcons/cerca.png',
                      color: Colors.green,
                      scale: 1.4,
                    ),
                  ),

                 validator: (prodottoCercato) => (prodottoCercato == '') ? 'Inserire un prodotto' : null,

                  onFieldSubmitted: (_) {
                    if (chiaveFormOrdini.currentState!.validate()) {
                      cercaProdotto(null);
                      Get.back(result: false);
                    }
                  },
                ),
              ),
            ),
          ],
        ),

        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 5.0,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          width: 1.0,
                          color: Get.theme.selectedRowColor,
                        ),
                      )
                  ),

                  onPressed: () => Get.back(result: true),
                  child: Text(
                    'Annulla',
                    style: TextStyle(color: Colors.red.shade800),
                  ),
              ),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5.0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      side: BorderSide(
                        width: 1.0,
                        color: Get.theme.selectedRowColor,
                      ),
                    )
                ),

                onPressed: () {
                  cercaProdotto(null);
                  Get.back(result: false);
                },
                child: Text(
                  'Conferma',
                  style: TextStyle(color: Colors.green.shade800),
                ),
              ),
            ],
          ),
        ],
      ),

      barrierDismissible: false,
      barrierColor: Colors.grey.shade600,
    ) ?? true;
  }






  Future<bool> _mostraProdotti() async {
    return await Get.dialog(
      AlertDialog(
        elevation: 10.0,
        shape: kShapeOrdineProv,

        title: const Center(
          child: Text(
            'Seleziona Prodotto',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        content: SizedBox(
          width: larghezzaSchermo,

          child: obx(
            (state) => ListView.builder(
              itemCount: listaProdotti.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 5.0,
                  margin: const EdgeInsets.all(10.0),
                  shape: kCardShape,

                  child: ListTile(
                    title: AutoSizeText(
                      listaProdotti[index].descrizione,
                      textAlign: TextAlign.center,
                      minFontSize: 14.0,
                    ),

                    subtitle: Column(
                      children: <Widget>[
                        AutoSizeText(
                          'Minsan: ${listaProdotti[index].minsan}',
                          textAlign: TextAlign.center,
                          minFontSize: 12.0,
                        ),

                        AutoSizeText(
                          'Prezzo: ${listaProdotti[index].prezzoCalc}€',
                          textAlign: TextAlign.center,
                          minFontSize: 12.0,
                        ),

                        AutoSizeText(
                          'Quantità: ${listaProdotti[index].disponibilita}',
                          textAlign: TextAlign.center,
                          minFontSize: 12.0,
                        ),
                      ],
                    ),


                    onTap: () {
                      prezzoTotale.value = listaProdotti[index].prezzoCalc!;
                      prodottoSelezionato.value = listaProdotti[index];

                      Get.back(result: false);
                    },
                  ),
                );
              }
            ),

            onLoading: const WidgetInCaricamento(),
            onEmpty: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  const Text(
                    'Nessun Prodotto Trovato',
                    style: TextStyle(fontSize: 16.0),
                  ),

                  const SizedBox(height: 25),

                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 5.0,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          side: BorderSide(
                            width: 1.0,
                            color: Get.theme.selectedRowColor,
                          ),
                        )
                    ),

                    onPressed: () => Get.back(result: true),
                    child: Text(
                      'Riprova',
                      style: TextStyle(color: Colors.red.shade900),
                    ),
                  ),
                ]
            ),
          ),
        ),

        actionsAlignment: MainAxisAlignment.start,
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  elevation: 5.0,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(
                      width: 1.0,
                      color: Get.theme.selectedRowColor,
                    ),
                  )
              ),

              onPressed: () {
                Get.back();
                Get.offAndToNamed('/homepage', arguments: [3]);
              },
              child: Text(
                'Annulla',
                style: TextStyle(color: Colors.red.shade900),
              )
          ),
        ],
      ),

      barrierDismissible: false,
      barrierColor: Colors.grey.shade600,
    ) ?? false;
  }






  void mostraGrossisti() {
    Get.dialog(
      AlertDialog(
        elevation: 10.0,
        shape: kShapeOrdineProv,

        title: const Center(
          child: Text(
            'Seleziona Grossista',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),

        content: SizedBox(
            width: larghezzaSchermo,

            child: ListView.builder(
              shrinkWrap: true,
              itemCount: listaGrossisti.length,
              itemBuilder: (context, index) => Card(
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
                    listaGrossisti[index],
                    textAlign: TextAlign.center,
                    maxLines: 1,

                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),



                  onTap: () {
                    ctrlGrossista.text = listaGrossisti[index];

                    Get.back();
                  },
                ),
              ),
            )
        ),

        actionsAlignment: MainAxisAlignment.start,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5.0,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  width: 1.0,
                  color: Get.theme.selectedRowColor,
                ),
              ),
            ),

            onPressed: () => Get.back(),
            child: Text(
              'Annulla',
              style: TextStyle(color: Colors.red.shade900),
            ),
          ),
        ],
      ),

      barrierDismissible: false,
    );
  }


}