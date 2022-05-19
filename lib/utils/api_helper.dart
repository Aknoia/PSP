// Dart imports:
import 'dart:async';
import 'dart:io';
import 'dart:convert';

// Flutter imports:
import 'package:flutter/foundation.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:retry/retry.dart';
import 'package:enum_to_string/enum_to_string.dart';


// Project imports:
import 'enums.dart';


class APIHelper extends GetConnect implements GetxService {
  APIHelper(this.urlFarmacia);

  final String username = "SITEAM";
  final String password = "SITEAMPWD";

  /// Indirizzo di base
  late final RxString urlFarmacia;

  /// Durata timeout richieste
  final Duration timeoutDuration = const Duration(seconds: 30);

  /// Token di sicurezza {RELEASE}
  RxString token = RxString('');
  final Duration durataToken = const Duration(minutes: 10); // 10 minuti


  /// Timer per refresh token
  late Timer tokenTimer;


  /// Headers http della richiesta
  Map<String, String> testata = {
    //"Connection" : "keep-alive",
    "Accept" : "*/*",
  };

  /// Parametri di query
  Map<String, dynamic> paramsQuery = {};

  @override
  void onInit() {
    super.onInit();

    timeout = timeoutDuration;
    httpClient.timeout = timeoutDuration;

    tokenTimer = Timer.periodic(
        durataToken,
            (timer) async {
          await prendiToken();
        });

    debugPrint("Token attivo: ${tokenTimer.isActive}");
  }



  Future prendiToken() async {
    paramsQuery.clear();
    paramsQuery.addAll({
      'username': username,
      'password': password,
    });


    final risultato = await post(
        '$urlFarmacia/login',
        '',
        query: paramsQuery,
        headers: testata
    ).timeout(timeoutDuration);


    if (risultato.statusCode == 201) {
      token.value = risultato.body as String;
    } else {
      if (kDebugMode) {
        print("ERRORE TOKEN: ${risultato.statusCode}  ${(risultato.body ?? '')}} ${risultato.statusText!}");
      }
    }
  }


  ///GROSSISTI
  ///RESTITUISCE TUTTI I GROSSISTI
  Future dammiGrossisti() async {
    await prendiToken();

    paramsQuery.clear();
    paramsQuery.addAll({
      'token': token.value,
    });

    final risultato = await retry(
          () async {
        return await get('$urlFarmacia/ordine/grossisti', query: paramsQuery,
            headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (risultato.statusCode == 200) {
      return risultato.body;
    }  else {
      throw Exception("Errore: ${risultato.statusCode.toString()} Dati: ${risultato.body}");
    }
  }


  /// Prende le statistiche di cassa
  Future dammiStatisticheCassa(TipoReport tipoReport, String dataIn, String dataOut) async {
    if (tipoReport != TipoReport.storicoVendite) {
      await prendiToken();
    }


    String tipoDiReport = EnumToString.convertToString(tipoReport);

    paramsQuery.clear();
    paramsQuery.addAll({
      'indata': dataIn,
      'outdata': dataOut,
      'token': token.value,
    });

    var statistiche =  await get(
      '$urlFarmacia/$tipoDiReport',
      query: paramsQuery,
      headers: testata,
    ).timeout(timeoutDuration);


    if (statistiche.statusCode == 200) {
      return statistiche.body;
    } else {
      Get.snackbar("Errore ricezione dati", statistiche.statusText!);
      return null;
    }
  }


  ///Legge le news dall'RSS
  Future leggiRssApi() async {
    var rss = await get(
        'http://www.siteamsrl.it' '/wp/feed/json', headers: testata);

    if (rss.statusCode == 200) {
      return rss.body;
    } else {
      throw Exception('Errore lettura Rss: ${rss.statusCode}');
    }
  }


  ///Restituisce tutti i prodotti invendibili
  Future dammiInvendibili() async {
    paramsQuery.clear();
    paramsQuery.addAll({
      'token': token.value,
    });

    var invendibili = await retry(
          () async {
        return await get(
            '$urlFarmacia/invendibili', query: paramsQuery, headers: testata)
            .timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (invendibili.statusCode == 200) {
      return invendibili.body;
    } else {
      throw Exception('Errore Invendibili: ${invendibili.statusCode}');
    }
  }


  ///Restituisce tutte le Dem in scadenza
  Future dammiDemInScadenza() async {
    paramsQuery.clear();
    paramsQuery.addAll({
      'token': token.value,
    });

    var demInScadenza = await retry(
          () async {
        return await get(
            '$urlFarmacia/deminscadenza', query: paramsQuery, headers: testata)
            .timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (demInScadenza.statusCode == 200) {
      return demInScadenza.body;
    } else {
      throw Exception('Errore Dem in Scad: ${demInScadenza.statusCode}');
    }
  }


  ///Restituisce tutti i prodotti in scadenza
  Future dammiScadProdotti() async {
    paramsQuery.clear();
    paramsQuery.addAll({
      'token': token.value,
    });

    var scadenzaProdotti = await retry(
          () async {
        return await get(
            '$urlFarmacia/scadprodotti', query: paramsQuery, headers: testata)
            .timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (scadenzaProdotti.statusCode == 200) {
      return scadenzaProdotti.body;
    } else {
      throw Exception('Errore Scad Prod: ${scadenzaProdotti.statusCode}');
    }
  }


  ///Restituisce tutte le scadenze contabili
  Future dammiScadContabili() async {
    paramsQuery.clear();
    paramsQuery.addAll({
      'token': token.value,
    });
    
    

    var scadenzeContabili = await retry(
          () async {
        return await get(
            '$urlFarmacia/scadcontabili', query: paramsQuery, headers: testata)
            .timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (scadenzeContabili.statusCode == 200) {
      return scadenzeContabili.body;
    } else {
      throw Exception('Errore Scad Cont: ${scadenzeContabili.statusCode}');
    }
  }


  ///Restituisce le giacienze rettificate
  Future dammiGiacienzeRettificate() async {
    paramsQuery.clear();
    paramsQuery.addAll({
      'token': token.value,
    });

    var giacienzeRettificate = await retry(
          () async {
        return await get(
            '$urlFarmacia/statistiche/giacenzerettificate', query: paramsQuery,
            headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (giacienzeRettificate.statusCode == 200) {
      return giacienzeRettificate.body;
    } else {
      throw Exception('Errore Giac Rett: ${giacienzeRettificate.statusCode}');
    }
  }


  ///Restituisce tutti i sospesi aperti
  Future dammiSospesiAperti() async {
    paramsQuery.clear();
    paramsQuery.addAll({'token': token.value});

    var sospesiAperti = await retry(
          () async {
        return await get(
            '$urlFarmacia/statistiche/sospesiaperti', query: paramsQuery,
            headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (sospesiAperti.statusCode == 200) {
      return sospesiAperti.body;
    } else {
      throw Exception('Errore Sospesi Aperti: ${sospesiAperti.statusCode}');
    }
  }


  ///Restituisce tutte le prenotazioni aperte
  Future dammiPrenotazioniAperte() async {
    paramsQuery.clear();
    paramsQuery.addAll({'token': token.value});

    var prenotazioniAperte = await retry(
          () async {
        return await get(
            '$urlFarmacia/statistiche/prenotazioniaperte', query: paramsQuery,
            headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (prenotazioniAperte.statusCode == 200) {
      return prenotazioniAperte.body;
    } else {
      throw Exception(
          'Errore Prenotazioni Aperte: ${prenotazioniAperte.statusCode}');
    }
  }


  ///Restituisce tutti i prodotti con codice uguale al codice inserito o descrizione simile
  Future dammiProdottoLista(String codice) async {
    if (codice == '') {
      codice = 'xxxxxxxxxx';
    }

    paramsQuery.clear();
    paramsQuery.addAll({
      'token': token.value,
      'codice_dacercare': codice.toUpperCase()
    });

    final risultato = await get(
        '$urlFarmacia/ricercaprodotti/listaprodotti',
        query: paramsQuery,
        headers: testata
    ).timeout(timeoutDuration);


    if (risultato.statusCode == 200) {
      return risultato.body;
    } else {
      throw Exception('Errore Prodotto Lista: ${risultato.statusCode}, ${risultato.statusText}');
    }
  }


  ///Restituisce le informazioni generali di un prodotto
  Future dammiInfoProdotto(String bdCodice) async {
    paramsQuery.clear();
    paramsQuery.addAll({
      'token': token.value,
    });

    var infoProdotto = await retry(
          () async {
        return await get(
            '$urlFarmacia/ricercaprodotti/$bdCodice/info', query: paramsQuery,
            headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (infoProdotto.statusCode == 200) {
      return infoProdotto.body;
    } else {
      throw Exception('Errore Info Prodotto: ${infoProdotto.statusCode}');
    }
  }


  ///Crea una prenotazione
  Future creaPrenotazione(String minsan, int qta, String cliente, String telefono, String codiceFiscale, String note) async {
    paramsQuery.clear();
    paramsQuery.addAll({
      "token" : token.value,
    });

    String dati = json.encode(
        <String, dynamic>{
          'minsan': minsan,
          'qta': qta,
          'cliente': cliente,
          'telefono': telefono,
          'codicefiscale': codiceFiscale,
          'note': note,
        }
    );

    var prenotazione = await retry(
          () async {
        return await post(
            '$urlFarmacia/prenotazioni/prenotazione', dati, query: paramsQuery, headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    ///restituisce ID Prenotazione
    if (prenotazione.statusCode == 201) {
      return prenotazione.body;
    } else {
      throw Exception(
          'Errore creazione prenotazione: ${prenotazione.statusCode}');
    }
  }


  Future inserisciArticoloInOrdine(int idPrenotazione) async {
    String dati = json.encode(
        <String, dynamic>{
          'idPren': idPrenotazione,
          'token': token.value
        }
    );

    var esito = await retry(
          () async {
        return await post(
            '$urlFarmacia/prenotazioni/mettiordine', dati, query: paramsQuery,
            headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (esito.statusCode == 201) {
      return 201;
    } else {
      throw Exception(
          'Errore inserimento prenotazioni in Ordine: ${esito.statusCode}');
    }
  }


  ///Invia un PostIt da salvare
  Future inviaPostIt(String minsan, String nota, String qta, String cliente,
      String sms) async {
    paramsQuery.clear();
    paramsQuery.addAll({'token': token.value});

    /// Preparazione body
    String dati = jsonEncode(<String, dynamic>{
      'minsan': minsan,
      'nota': nota,
      'qta': int.parse(qta),
      'cliente': cliente,
      'tel_sms': sms
    });

    var response = await retry(
          () async {
        return await post(
            '$urlFarmacia/ricercaprodotti/postit', dati, query: paramsQuery,
            headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    return response.statusCode;
  }


  Future dammiStatisticheReport(TipoStatistica tipoReport, int anno,
      int meseDal, int meseAl) async {
    paramsQuery.clear();
    paramsQuery.addAll(
        {
          'token': token.value,
          'anno': '$anno',
          'mesedal': '$meseDal',
          'meseal': '$meseAl',
        }
    );

    var statisticheReport = await retry(
          () async {
        return await get('$urlFarmacia/statistiche/${EnumToString.convertToString(tipoReport)
                .toLowerCase()}', query: paramsQuery,
            headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (statisticheReport.statusCode == 200) {
      return statisticheReport.body;
    } else {
      throw Exception(
          'Errore Statistiche Report: ${statisticheReport.statusCode}');
    }
  }


  ///restituisce tutti i prodotti dei grossisti
  Future dammiProdottiGrossisti(List grossisti) async {
    dynamic prodottiGrossisti;

    ///lista con tutti i prodotti
    List listaCompletaProdotti = List.empty(growable: true);

    paramsQuery.clear();
    paramsQuery.addAll({
      'token': token.value,
    });

    for (int i = 0; i < grossisti.length; i++) {
      prodottiGrossisti = await retry(
            () async {
          return await get(
              '$urlFarmacia/ordine/prodotti/${grossisti[i]}', query: paramsQuery,
              headers: testata).timeout(timeoutDuration);
        },

        retryIf: (eccezione) =>
        eccezione is SocketException || eccezione is TimeoutException,
      );

      if (prodottiGrossisti.statusCode == 200) {
        listaCompletaProdotti.add(prodottiGrossisti.body['righe_ordine']);
      }
    }

    if (grossisti.isEmpty) {
      return [];
    } else if (listaCompletaProdotti.isNotEmpty) {
      return listaCompletaProdotti;
    } else {
      return [];
    }
  }


  Future dammiDisponibilita(String minsan) async {
    paramsQuery.clear();
    paramsQuery.addAll({
      "token" : token.value,
    });

    final disponibilita = await get('$urlFarmacia/giacenza/$minsan', query: paramsQuery, headers: testata);

    if (disponibilita.statusCode == 200) {
      return disponibilita.body[0]['o_disponibilita'] ?? 0;
    } else {
      return 0;
    }
  }


  Future dammiOfferteMinsan(String minsan) async {
    paramsQuery.clear();
    paramsQuery.addAll({'token': token.value});

    final offerte = await get(
      '$urlFarmacia/ricercaprodotti/$minsan/offertegrossisti',
      query: paramsQuery,
      headers: testata,
    ).timeout(timeoutDuration);


    if (offerte.statusCode == 200) {
      return offerte.body;
    } else {
      debugPrint(offerte.statusText);
      throw Exception('Errore Ricezione Offerte: ${offerte.statusCode}');
    }
  }


  Future dammiGenerici(String minsan) async {
    paramsQuery.clear();
    paramsQuery.addAll({
      'token': token.value,
    });

    final generici = await retry(
          () async {
        return await get('$urlFarmacia/ricercaprodotti/$minsan/generici', query: paramsQuery, headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (generici.statusCode == 200) {
      debugPrint(generici.body.toString());
      return generici.body;
    } else {
      throw Exception('Errore ricezione generici: ${generici.statusCode} ${generici.body}');
    }
  }


  Future dammiStatisticheProdottoPeriodo(String minsan, int anno, {required int mesedal, required int meseal}) async {

    paramsQuery.clear();
    paramsQuery.addAll({
      'anno': '$anno',
      'mesedal': '$mesedal',
      'meseal': '$meseal',
      'Token': token.value,
    });

    final statistiche = await retry(
          () async {
        return await get('$urlFarmacia/statistiche/prodotto/$minsan', query: paramsQuery, headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (statistiche.statusCode == 200) {
      return statistiche.body;
    } else {
      throw Exception('Errore ricezione statistiche: ${statistiche.statusCode}');
    }
  }


  ///Crea una riga in ordine provvisorio
  Future creaRigaOrdine(String grossista, String minsan, int quantita) async {
    String dati = json.encode(
        <String, dynamic>{
          'codicefornitore': grossista,
          'minsan': minsan,
          'quantita': quantita,
          'token': token.value,
        }
    );

    var risultato = await retry(
          () async {
        return await post(
            '$urlFarmacia/ordine/provvisorio/addriga', dati, query: paramsQuery,
            headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (risultato.statusCode == 201) {
      return 201;
    } else {
      return json.decode(risultato.statusCode.toString());
    }
  }


  ///Elimina una riga in ordine provvisorio
  Future eliminaRigaOrdine(String grossista, String minsan) async {
    String dati = json.encode(
        <String, dynamic>{
          'codicefornitore': grossista,
          'minsan': minsan,
          'quantita': 0,
        }
    );
    
    paramsQuery.clear();
    paramsQuery.addAll({"token": token.value});

    var risultato = await retry(
          () async {
        return await post('$urlFarmacia/ordine/provvisorio/addriga', dati,
            query: paramsQuery, headers: testata).timeout(timeoutDuration);
      },

      retryIf: (eccezione) =>
      eccezione is SocketException || eccezione is TimeoutException,
    );

    if (risultato.statusCode == 201) {
      return 201;
    } else {
      return json.decode(risultato.statusCode.toString());
    }
  }
}