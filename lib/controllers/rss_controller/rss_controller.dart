// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../utils/api_helper.dart';
import '../../utils/impostazioni.dart';
import '../../modelli/notizia.dart';


class RSSController extends GetxController with StateMixin {

  RxList newsLette = RxList([]);
  RxList datiRSS = RxList([]);
  RxList listaNewsLette = RxList([]);

  @override
  void onInit() {
    super.onInit();
    leggiRSS();
  }

  Future<void> leggiRSS() async {

    change([], status: RxStatus.loading());

    var tmp = await Get.find<APIHelper>().leggiRssApi();

    datiRSS.value = await sistemaNews(tmp);
  }

  Future sistemaNews(var newsDaRSS) async {

    List<dynamic> risultato = List<dynamic>.empty(growable: true);
    List<int> newsNuove = List<int>.empty(growable: true);

    /// Prendo le news lette
    newsLette.value = await DatiUtente.recuperaNewsLetter();

    /// Conserva solo le notizie uscite meno di due anni prima della data odierna
    for (var notizia in newsLette) {
      if (DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(notizia)).inDays < (365 * 2)) {
        newsNuove.add(notizia);
      }
    }

    /// Resetto le news lette
    newsLette.clear();
    newsLette.value = newsNuove;


    /// Filtro le notizie per il planet shuttle tra le nuove notizie trovate
    /// Serializzo le notizie
    newsDaRSS['items'].forEach((elemento) {
      if (elemento['tags'].contains('Planet shuttle')) {
        risultato.add(Notizia.fromJSON(elemento));
      }
    });

    /// Controllo se la notizia è stata letta
    for (var notizia in risultato) {
      if (newsLette.contains(notizia.dataModifica.millisecondsSinceEpoch)) {
        notizia.notiziaLetta = true;
      } else {
        notizia.notiziaLetta = false;
      }

      listaNewsLette.add(notizia.notiziaLetta);
    }


    change([], status: RxStatus.success());
    return risultato;
  }
}