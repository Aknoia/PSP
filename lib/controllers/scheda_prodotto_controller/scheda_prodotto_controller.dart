// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../modelli/post_it.dart';
import '../../modelli/prodotto.dart';
import '../../utils/api_helper.dart';
import '../../utils/impostazioni.dart';
import '../../defaultFunctions/controlla_valore_null.dart';



class SchedaProdottoController extends GetxController with StateMixin {
  SchedaProdottoController(this.prodotto) {
    codiceProdotto = prodotto.minsan;
  }

  /// Variabili osservabili
  RxList infoProdotto = RxList([]);

  RxString immagineProdotto = RxString('');

  final _postItSelezionato = 0.obs;
  int get postItSelezionato => _postItSelezionato.value;
  set postItSelezionato(int nuovoPostItSelezionato) {
    _postItSelezionato.value = nuovoPostItSelezionato;
  }


  /// Variabili normali
  String codiceProdotto = '';
  Prodotto prodotto;

  @override
  void onInit() {
    super.onInit();

    leggiStatistiche();
  }





  Future<void> leggiImmagine() async {
    change([], status: RxStatus.loading());
    var libera = await Get.find<APIHelper>().dammiInfoProdotto(codiceProdotto);

    if (libera != null) {
      if (libera['img']['imgurl'] != '') {
        immagineProdotto.value = libera['img']['imgurl'];
      }
    }
  }




  Future<void> leggiStatistiche() async {
    change([], status: RxStatus.loading());

    var libera = await Get.find<APIHelper>().dammiInfoProdotto(codiceProdotto);

    switch(libera.runtimeType.toString()) {
      case 'List<dynamic>':
        if (libera.length > 0) {
          serializzaInfoProdotto(libera);
          leggiImmagine();
          change(infoProdotto, status: RxStatus.success());
        } else {
          infoProdotto.value = [{'': ''}];
          change(infoProdotto, status: RxStatus.empty());
        }
        break;


      case '_InternalLinkedHashMap<String, String>':
        if (!checkValoreNull(libera['errore'])) {
          change([], status: RxStatus.error("Errore server: ${libera['errore']} \nChiamata: ${DatiUtente.farmacia.url}/ricercaprodotti/$codiceProdotto/info"));
        } else {
          change([], status: RxStatus.success());
        }
        break;



      case '_InternalLinkedHashMap<String, dynamic>':
        if (!checkValoreNull(libera['errore'])) {
          change([], status: RxStatus.error("Errore server: funzione NON attiva \n${libera['errore']}"));
        } else {
          serializzaInfoProdotto(libera);
          leggiImmagine();
          change([], status: RxStatus.success());
        }
        break;

      default:
        change([], status: RxStatus.empty());
        if (libera != null) {
          infoProdotto.value = [
            {
              'bd_codice'             : '000000000',        'bd_ean'                     : '0',          'bd_descrizione'           : libera['Risultato'],           'bd_sostituito'             : '',
              'bd_dtinizesaur'        : '',                 'bd_commercio'               : 'N',          'bd_princatt_desc'         : 'NESSUN PRINCIPIO ATTIVO',  'bd_prz_calc'               : 0,
              'bd_unimis'             : 'Kg',               'bd_dataprz_calc'            : '',           'bd_dtinizditta1'          : null,                       'bd_dittaprod1'             : '',
              'bd_dittaprod1_ragsoc'  : '',                 'bd_dtinizssn_x_datalav'     : null,         'bd_ssn_x_datalav'         : '3',                        'o_disponibilita'           : 0,
              'bd_classe_x_datalav'   : '',                 'bd_noteprescriz_x_datalav'  : '',           'bd_codiva'                : '0',                        'o_gest_robot'              : 'N',
              'bd_tipoprodotto'       : 'P',                'bd_tiporic1_desc'           : null,         'bd_ssn_desc_x_datalav'    : 'NON CONCEDIBILE',          'o_ordine'                  : 0,
              'bd_degrassi'           : 0000,               'o_giac_robot'               : 0,            'bd_prescrivib_x_datalav'  : '',                         'o_qtaoff2'                 : 0,
              'bd_atcgmp'             : '',                 'bd_atcgmp_liv1_calc'        : '',           'bd_atcgmp_liv2_calc'      : '',                         'o_qtaoff1'                 : 0,
              'bd_atcgmp_liv5_calc'   : '',                 'bd_atcgmp_liv1_desc'        : '',           'bd_atcgmp_liv2_desc'      : '',                         'o_esauri'                  : 'ES',
              'bd_atcgmp_liv5_desc'   : '',                 'bd_atcgmp_liv3_calc'        : '',           'bd_princatt'              : '000000',                   'o_desc_ext_prod'           : 'Nessun prodotto',
              'bd_atcgmp_liv3_desc'   : '',                 'bd_atcgmp_liv4_desc'        : '',           'bd_przrimb'               : 0,                          'o_tot_ordprov'             : 0,
              'bd_divditta1'          : '',                 'bd_atcgmp_liv4_calc'        : '',
            }
          ];

          refresh();
          change(infoProdotto, status: RxStatus.success());
        }
    }
  }






  void serializzaInfoProdotto(dynamic libera) {
    infoProdotto.value = [
      List.generate(
        libera['postit'].length,
            (index) => PostIT.fromJSON(
          libera['postit'][index],
        ),
      ),

      List.generate(
        libera['generici'].length,
            (index) => Prodotto.fromJSON(
          libera['generici'][index],
        ),
      ),

      libera['img']['imgurl']
    ];
  }
}