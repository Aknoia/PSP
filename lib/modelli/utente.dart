

class Utente {

  String id;
  String descrizione;

  double totaleVendite;
  double totaleMinuti;

  int numeroVendite;

  String tempoLavorato;

  Utente({
    required this.id,
    required this.descrizione,
    required this.totaleVendite,
    required this.totaleMinuti,
    required this.numeroVendite,
    required this.tempoLavorato,
  });

  factory Utente.fromJSON(Map<String, dynamic> json) {
    return Utente(
      id: json['utente'],
      descrizione: json['descrizione'],
      totaleVendite: json['totalevendite'] as double,
      totaleMinuti: json['minuti'],
      numeroVendite: json['numevendite'],
      tempoLavorato: json['tempolavorato'],
    );
  }
}