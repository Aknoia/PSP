// Flutter imports:
import 'dart:convert';

// Package imports:
import 'package:get_storage/get_storage.dart';

// Project imports:
import '../../modelli/farmacia.dart';

class DatiUtente {

   static final GetStorage _storage = GetStorage();

   static late Farmacia farmacia;

   static final Future<bool> _esitoPositivo = Future.value(true);
   static final Future<bool> _esitoNegativo = Future.value(false);

   ///Salva il token in memoria e controlla il corretto inserimento
   static Future<bool> salvaToken(String token) async {
      if (token.isNotEmpty) {
         
         _storage.write('token', token);
         return _esitoPositivo;
      }
      return _esitoNegativo;
   }


   ///Recupera il token dalla memoria
   ///Restituisce un errore in caso il token non sia stato salvato
   static Future<String> recuperaToken() async {
      return _storage.read('token') ?? 'Nessun Token';
   }


   ///Salva il fornitore di default
   static Future<bool> salvaFornitoreDefault(String fornitoreDefault) async {
      if (fornitoreDefault.isNotEmpty) {

         _storage.write('fornitoreDefault', fornitoreDefault);

         return _esitoPositivo;
      }
      return _esitoNegativo;
   }


   ///Recupera il fornitore di default dalla memoria
   ///Restituisce un errore in caso il fornitore non sia stato salvato
   static Future<String> recuperaFornitoreDefault() async {
      return _storage.read('fornitoreDefault') ?? 'Nessun fornitore';
   }


   ///Salva la porta del server REST in memoria
   static Future<bool> salvaPortaAPI(int numeroPorta) async {
      if ((numeroPorta > 0) && (numeroPorta < 65535)) {
         _storage.write('porta', numeroPorta);
         return _esitoPositivo;

      }
      return _esitoNegativo;
   }


   ///Recupera la porta del server REST dalla memoria
   ///Restituisce un errore in caso la porta non sia stata salvata
   static Future<int> recuperaPorta() async {
      return _storage.read('porta') ?? -1;
   }


   ///Salva l'url del server REST in memoria
   static Future<bool> salvaUrl(String url) async {
      if (url.isNotEmpty) {
         _storage.write('url', url);
         return _esitoPositivo;
      }
      return _esitoNegativo;
   }


   ///Recupera l'Url del server REST dalla memoria
   ///Restituisce un errore in caso l'Url non sia stato salvato
   static Future<String> recuperaUrl() async {
      return _storage.read('url') ?? 'Nessun url';
   }


   ///Salva le news in memoria
   static Future<bool> salvaNewsLetter(List<dynamic> newsLetter) async {
      if (newsLetter.isNotEmpty) {
         List<String> newsLetter = List<String>.empty(growable: true);

         for (var news in newsLetter) {
            newsLetter.add(news.toString());
         }

         _storage.remove('_newslette');
         _storage.write('_newslette', newsLetter);
         return _esitoPositivo;
      }
      return _esitoNegativo;
   }


   ///Recupera le news dalla memoria
   ///Restituisce un errore in caso le news non siano state salvate
   static Future<List<int?>> recuperaNewsLetter() async {
      List<dynamic>   stringNewsLetter = _storage.read('_newslette') ?? ['0'] ;
      List<int?>     newsLetter       = List<int?>.empty(growable: true);

      for (var news in stringNewsLetter) {
         newsLetter.add(int.tryParse(news));
      }

      return newsLetter;
   }


   ///Salva la configurazione in memoria
   static Future<bool>  salvaConfigPlanet(Map<String, dynamic> configurazione) async {
      var config = configurazione;

      if (configurazione.isNotEmpty) {

         String configurazione = json.encode(config);

         if (configurazione.isNotEmpty) {
            _storage.write('_planetconfig', configurazione);
            return _esitoPositivo;
         }
      }
      return _esitoNegativo;
   }


   ///Recupera la configurazione dalla memoria
   ///Restituisce un errore in caso la configurazione non sia stata salvata
   static Future<String> recuperaConfigPlanet() async {
      return _storage.read('_planetconfig') ?? '''{"farmacie":[],"url":""}''';
   }


   ///Aggiorna la farmacia salvata in memoria
   static Future<bool> aggiornaFarmacia(Map nuovaFarmacia) async {
      if (nuovaFarmacia.isNotEmpty) {

         bool farmaciaAggiunta = false;

         var config = json.decode(await DatiUtente.recuperaConfigPlanet());

         //Controlla se la farmacia è già stata aggiunta
         for (Map f in config['farmacie']) {
            if (f['url'] == nuovaFarmacia['url']) {
               config['farmacie'].remove(f);
               config['farmacie'].add(nuovaFarmacia);
               farmaciaAggiunta = true;
               break;
            }
         }

         // aggiunge farmacia non esistente
         if (farmaciaAggiunta == false) {
            config['farmacie'].add(nuovaFarmacia);
         }

         return DatiUtente.salvaConfigPlanet(config);
      }
      return _esitoNegativo;
   }
}