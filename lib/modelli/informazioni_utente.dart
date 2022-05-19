

class InformazioniUtente {

  String utente;
  String descrizione;
  String tempoLavorato;

  double totaleVendite;
  double minuti;

  int numeroVendite;

  InformazioniUtente({
    required this.utente,
    required this.descrizione,
    required this.tempoLavorato,
    required this.totaleVendite,
    required this.minuti,
    required this.numeroVendite,
  });

  factory InformazioniUtente.fromJSON(Map<String, dynamic> json) {
    return InformazioniUtente(
      utente: json['utente'],
      descrizione: json['descrizione'],
      tempoLavorato: json['tempolavorato'],

      totaleVendite: json['totalevendite'],
      minuti: json['minuti'],

      numeroVendite: json['numevendite'],
    );
  }



  Map<String, dynamic> toJSON() {
    return {
      'utente' : utente,
      'descrizione' : descrizione,
      'tempolavorato' : tempoLavorato,
      'totaleVendite' : '$totaleVendite',
      'minuti' : '$minuti',
      'numevendite' : '$numeroVendite',
    };
  }
}