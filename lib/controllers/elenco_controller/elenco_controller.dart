// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';

// Project imports:
import '../../utils/impostazioni.dart';
import '../../theme/dimensioni.dart';
import '../../theme/shapes.dart';
import '../../utils/api_helper.dart';

class ElencoController extends GetxController {
  ElencoController(this.numeroPagina);

  /// Chiave per utilizzo drawer
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'Drawer Key');

  /// Controller per cambio di pagina
  late PageController controllerPagina;

  /// Valore news ricevute da PLANETRSS
  final _numeroNotifiche = 0.obs;
  int get numeroNotifiche => _numeroNotifiche.value;
  set numeroNotifiche(int qtaNotifiche) {
    _numeroNotifiche.value = qtaNotifiche;
  }

  /// Pagina da mostrare
  final _funzione = 1.obs;
  int get funzione => _funzione.value;
  set funzione(int nFunzione) {
    _funzione.value = nFunzione;
  }
  int numeroPagina;

  /// Variabili per il controllo delle news
  // ignore: prefer_typing_uninitialized_variables
  var timer;

  bool stopNews = false;
  bool loadingNews = false;
  bool caricaNews = false;


  @override
  void onInit() async {
    super.onInit();
    controllerPagina = PageController();
  }


  @override
  void onReady() {
    cambiaPaginaSchermo(numeroPagina);

    getFornitore();
  }


  /// Prende il fornitore di default
  Future getFornitore() async {
    dynamic fornitore = await Get.find<APIHelper>().dammiGrossisti();

    if (fornitore.isEmpty) {
      DatiUtente.salvaFornitoreDefault('Nessun fornitore trovato');
    } else {
      DatiUtente.salvaFornitoreDefault(fornitore['grossisti'][0]['grossista']);
    }
  }



  void cambiaPaginaSchermo(int numeroSchermo) {
    /// Cambio pagina
    funzione = numeroSchermo;
    controllerPagina.jumpToPage(numeroSchermo);
    avviaTimer();

    /// Chiudo drawer
    if (scaffoldKey.currentState!.isDrawerOpen) {
      Get.back();
    }
  }


  /// NEWS
  /// Avvia il timer per la ricerca delle news
  void avviaTimer() {
    stopNews = false;
    loadingNews = false;

    if (timer != null) {
      timer!.cancel();
    }

    Timer.periodic(const Duration(seconds: 30), (tm) {
      timer = tm;
      controllaNews();
    });
  }

  /// Controlla se ci sono news presenti
  Future controllaNews() async {
    if (loadingNews) {
      return Future.value('');
    }

    if (stopNews) {
      timer!.cancel();
      if (numeroNotifiche > 0) {
        numeroNotifiche = 0;
      }
      return Future.value('');
    }

    loadingNews = true;
    var libera = await Get.find<APIHelper>().leggiRssApi();

    await sistemaNews(libera);
    loadingNews = false;
  }


  /// Ordina le news
  Future sistemaNews(Map<String, dynamic> libera) async {

    List <dynamic> newsPerShuttle = List<dynamic>.empty(growable: true);
    List<int?> newsLette = await DatiUtente.recuperaNewsLetter();

    numeroNotifiche = 0;

    for (var pagina in libera['items']) {
      if (pagina['tags'].contains('Planet shuttle')) {
        newsPerShuttle.add(pagina);
      }
    }

    for (var elemento in newsPerShuttle) {
      if (newsLette.contains(DateTime.parse(elemento['date_modified']).millisecondsSinceEpoch)) {
        elemento['read'] = true;
      } else {
        elemento['read'] = false;
        numeroNotifiche++;
      }
    }

    return newsPerShuttle;
  }






  /// Modifica il QRCode generato dal planet shuttle
  Future<String> modificaQRCode() async {
    TextEditingController ctrlNomeFarmacia = TextEditingController();

    String farmaciaEncoded = jsonEncode(DatiUtente.farmacia.toJson());

    await Get.dialog(
      AlertDialog(
        shape: kShapeAlertDialog,

        title: IconButton(
          alignment: Alignment.centerLeft,
          highlightColor: Colors.transparent,
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,

          icon: Image.asset('assets/defaultIcons/chiudi.png'),

          onPressed: () => Get.back(),
        ),

        content: SizedBox(
          width: 300,
          height: altezzaSchermo - 200,
          child: QrImage(
            data: farmaciaEncoded,
            version: QrVersions.auto,
            size: 200,
          ),
        ),

        actionsPadding: const EdgeInsets.only(
          bottom: 10.0,
          left: 5.0,
          right: 5.0,
        ),

        actions: <Row>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              SizedBox(
                width: 200,
                child: TextField(

                  controller: ctrlNomeFarmacia,

                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Get.theme.selectedRowColor),
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Get.theme.selectedRowColor,
                          width: 1.0
                      ),
                    ),

                    labelText: 'Rinomina farmacia:',
                    hintText: DatiUtente.farmacia.nome,

                    prefixText: ' ',
                  ),
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
                onPressed: () async {
                  if (ctrlNomeFarmacia.text.length > 4) {
                    DatiUtente.farmacia.nome = ctrlNomeFarmacia.text;
                    DatiUtente.aggiornaFarmacia(DatiUtente.farmacia.toJson());

                    Get.back();
                    Get.snackbar('Nome Aggiornato', "Fermare e Riavviare l'app");

                    farmaciaEncoded = json.encode( DatiUtente.farmacia);

                  } else {
                    Get.snackbar('Errore', 'Nome troppo corto!');
                  }
                },
                child: Text(
                  'Salva',
                  style: TextStyle(color: Colors.green.shade800),
                ),
              ),
            ],
          ),
        ],
      ),
      barrierDismissible: false,
    );

    return farmaciaEncoded;
  }
}