// Package imports:
import 'package:intl/intl.dart';

class TotaleStorico {

  double importo;

  List<VenditaSingola> dettaglio;

  DateTime dataStorico;

  TotaleStorico({
    required this.importo,
    required this.dettaglio,
    required this.dataStorico,
  });

  factory TotaleStorico.format(double imp, List<VenditaSingola> dett, String data) {
    return TotaleStorico(
      importo: imp,
      dettaglio: dett,
      dataStorico: DateFormat('dd-MM-yyyy hh:mm:ss').parse(data),
    );
  }
}


class VenditaSingola {
  String tipoVendita;
  String nomeProdotto;
  int quantita;
  String concessione;
  double prezzoLordo;
  double sconto;
  double prezzoScontato;
  double ticket;
  double quota;
  double totaleVendita;
  double valoreSconto;
  double totaleRicetta;
  int numeroVendita;
  DateTime dataVendita;
  String utente;

  VenditaSingola({
    required this.tipoVendita,
    required this.nomeProdotto,
    required this.quantita,
    required this.concessione,
    required this.prezzoLordo,
    required this.sconto,
    required this.prezzoScontato,
    required this.ticket,
    required this.quota,
    required this.totaleVendita,
    required this.valoreSconto,
    required this.totaleRicetta,
    required this.numeroVendita,
    required this.dataVendita,
    required this.utente,
  });


  factory VenditaSingola.fromJSON(Map<String, dynamic> json) {
    return VenditaSingola(
      tipoVendita: json['tipovendita'],
      nomeProdotto: json['prodotto'],
      quantita: json['qta'],
      concessione: json['concessione'] ?? '',
      prezzoLordo: json['prz_lordo'].toDouble(),
      sconto: json['sconto'].toDouble(),
      prezzoScontato: json['prezzoscontato'].toDouble(),
      ticket: json['ticket'].toDouble(),
      quota: json['quota'].toDouble(),
      totaleVendita: json['totprodotti'].toDouble(),
      valoreSconto: json['valoresconto'].toDouble(),
      totaleRicetta: json['totalericetta'].toDouble(),
      numeroVendita: json['numvend'],
      dataVendita: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['datavend'] + ' ' + json['oraconferma']),
      utente: json['utente'],
    );
  }
}