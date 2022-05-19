// Dart imports:
import 'dart:async';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:barcode_scan2/barcode_scan2.dart';

// Project imports:
import '../../modelli/prodotto.dart';
import '../../utils/api_helper.dart';

class ZoomController extends GetxController with StateMixin {

  var ctrlRicerca = TextEditingController(text: 'Inserire descrizione o minsan');

  RxList<Prodotto> vendite = RxList([]);

  final _indiceSelezione = RxInt(-1);
  int get indiceSelezione => _indiceSelezione.value;
  set indiceSelezione(int nuovoIndice) {
    _indiceSelezione.value = nuovoIndice;
  }


  var vecchiaRicerca = '';

  // ignore: prefer_typing_uninitialized_variables
  var _debounce;

  var stop = false;


  @override
  void onInit() {
    super.onInit();
    attivaTimer();

    leggiStatistiche();
    stop = false;
  }



  Future<void> scannerizzaProdotto() async {
    var scanResult = await BarcodeScanner.scan(
      options: const ScanOptions(
        restrictFormat: [
          BarcodeFormat.code39,
          BarcodeFormat.ean8,
          BarcodeFormat.ean13,
        ],
      ),
    );

    String codice = scanResult.rawContent;

    if (codice.length > 16) {
      codice = codice.substring(0, 16);
    }

    if (codice.length > 5) {
      vecchiaRicerca = codice;
      leggiStatistiche();
    }
  }



  void attivaTimer() {


    ctrlRicerca.addListener(() {
      if (_debounce?.isActive ?? false) {
        _debounce.cancel();
      }

      _debounce = Timer(const Duration(milliseconds: 600), () {
        if (!stop) {
          if ((ctrlRicerca.text.length > 4) && (ctrlRicerca.text != vecchiaRicerca)) {
              vecchiaRicerca = ctrlRicerca.text;
              leggiStatistiche();

              stop = false;
          }
        }
      });
    });
  }



  List<Prodotto> serializzaProdottiZoom(List<dynamic> json) {
    return List.generate(
        json.length,
            (index) => Prodotto.fromJSON(json[index])
    );
  }




  Future<void> leggiStatistiche() async {
    stop = true;
    change([], status: RxStatus.loading());

    var listaProdotti = await Get.find<APIHelper>().dammiProdottoLista(const HtmlEscape().convert(vecchiaRicerca));


    switch(listaProdotti.runtimeType.toString()) {
      case 'List<dynamic>':
        if (listaProdotti.length > 0) {
          change(vendite, status: RxStatus.success());

          vendite.value = serializzaProdottiZoom(listaProdotti);
        } else {
          change([], status: RxStatus.empty());
        }

        break;


      case '_GrowableList<dynamic>':
        if (listaProdotti.length > 0) {
          change(vendite, status: RxStatus.success());

          vendite.value = serializzaProdottiZoom(listaProdotti);
        } else {
          change([], status: RxStatus.empty());
        }
        break;


      case '_InternalLinkedHashMap<String, dynamic>':
        if (listaProdotti['errore'] != null) {
          change([], status: RxStatus.error("Errore server: funzione NON attiva \n${listaProdotti['errore']}"));
        }
        break;

      case '_InternalLinkedHashMap<String, String>':
        if (listaProdotti['errore'] != null) {
          change([], status: RxStatus.error("Errore server: funzione NON attiva \n${listaProdotti['err<,''ore']}"));
        }
        break;

      default:
        change([], status: RxStatus.empty());
        if (listaProdotti != null) {
          vendite.value = serializzaProdottiZoom([
            {
              'bd_codice'           : '000000000',  'bd_ean'                    : '0',    'bd_descrizione'      : 'Nessun Prodotto',           'bd_sostituito'           : '',
              'bd_dtinizesaur'      : '',           'bd_commercio'              : 'N',    'bd_princatt_desc'    : 'NESSUN PRINCIPIO ATTIVO',   'bd_prz_calc'             : 0,
              'bd_unimis'           : 'Kg',         'bd_dataprz_calc'           : '',     'bd_dtinizditta1'     : null,                        'bd_dittaprod1'           : '',
              'bd_dittaprod1_ragsoc': '',           'bd_dtinizssn_x_datalav'    : null,   'bd_ssn_x_datalav'    : '3',                         'bd_ssn_desc_x_datalav'   : 'NON CONCEDIBILE',
              'bd_classe_x_datalav' : '',           'bd_noteprescriz_x_datalav' : '',     'bd_codiva'           : '0',                         'bd_prescrivib_x_datalav' : '',
              'bd_tipoprodotto'     : 'P',          'bd_tiporic1_desc'          : null,   'o_disponibilita'     : 0,                           'o_ordine'                : 0,
              'bd_degrassi'         : 0000,         'o_giac_robot'              : 0,      'o_gest_robot'        : 'N',                         'bd_princatt'             : '000000',
              'bd_atcgmp'           : '',           'bd_atcgmp_liv1_calc'       : '',     'bd_atcgmp_liv2_calc' : '',                          'bd_atcgmp_liv3_calc'     : '',
              'bd_atcgmp_liv5_calc' : '',           'bd_atcgmp_liv1_desc'       : '',     'bd_atcgmp_liv2_desc' : '',                          'bd_atcgmp_liv3_desc'     : '',
              'bd_atcgmp_liv5_desc' : '',           'o_qtaoff1'                 : 0,      'o_qtaoff2'           : 0,                           'bd_divditta1'            : '',
              'o_esauri'            : 'ES',         'bd_przrimb'                : 0,      'o_tot_ordprov'       : 0,                           'o_desc_ext_prod'         : 'Nessun prodotto',
              'bd_atcgmp_liv4_calc' : '',           'bd_atcgmp_liv4_desc': ''
          }]);
        } else {
          vendite.value = serializzaProdottiZoom([{
              'bd_codice'               : '000000000', 'bd_ean'                 : '0',                'bd_descrizione'            : 'Nessun prodotto',          'bd_sostituito'         : '',
              'bd_dtinizesaur'          : '',          'bd_commercio'           : 'N',                'bd_princatt_desc'          : 'NESSUN PRINCIPIO ATTIVO',  'bd_prz_calc'           : 0,
              'bd_unimis'               : 'Kg',        'bd_dataprz_calc'        : '',                 'bd_dtinizditta1'           : null,                       'bd_dittaprod1'         : '',
              'bd_dittaprod1_ragsoc'    : '',          'bd_dtinizssn_x_datalav' : null,               'bd_ssn_x_datalav'          : '3',                        'bd_ssn_desc_x_datalav' : 'NON CONCEDIBILE',
              'o_esauri'                : 'ES',        'bd_classe_x_datalav'    : '',                 'bd_noteprescriz_x_datalav' : '',                         'bd_codiva'             : '0',
              'bd_prescrivib_x_datalav' : '',          'bd_przrimb'             : 0,                  'bd_tipoprodotto'           : 'P',                        'bd_tiporic1_desc'      : null,
              'o_ordine'                : 0,           'o_tot_ordprov'          : 0,                  'bd_degrassi'               : 0000,                       'o_giac_robot'          : 0,
              'bd_princatt'             : '000000',    'o_desc_ext_prod'        : 'Nessun prodotto',  'bd_atcgmp'                 : '',                         'bd_atcgmp_liv1_calc'   : '',
              'bd_atcgmp_liv2_calc'     : '',          'bd_atcgmp_liv3_calc'    : '',                 'bd_atcgmp_liv4_calc'       : '',                         'bd_atcgmp_liv5_calc'   : '',
              'bd_atcgmp_liv1_desc'     : '',          'bd_atcgmp_liv2_desc'    : '',                 'bd_atcgmp_liv3_desc'       : '',                         'bd_atcgmp_liv4_desc'   : '',
              'bd_atcgmp_liv5_desc'     : '',          'o_qtaoff1'              : 0,                  'o_qtaoff2'                 : 0 ,                         'bd_divditta1'          : '',
              'o_disponibilita'         : 0,           'o_gest_robot'           : 'N',
          }]);
        }
    }
  }
}