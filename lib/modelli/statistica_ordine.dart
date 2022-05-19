/// Modello per le statistiche inerenti agli ordini in Ordine provvisorio
class StatisticaOrdine {

  String minsan;

  int anno;
  int mese;

  int venduto;
  int totaleAcquisti;

  StatisticaOrdine({
    required this.minsan,
    required this.anno,
    required this.mese,
    required this.venduto,
    required this.totaleAcquisti,
  });

  factory StatisticaOrdine.fromJSON(Map<String, dynamic> json) {
    return StatisticaOrdine(
      minsan: json['minsan'],
      anno: json['anno'],
      mese: json['mese'],
      venduto: json['venduto'],
      totaleAcquisti: json['acq_totale'],
    );
  }

  Map<String, dynamic> toJSON() {
    return {
      'minsan' : minsan,
      'anno': anno,
      'mese': mese,
      'venduto': venduto,
      'acq_totale': totaleAcquisti,
    };
  }

  static List<StatisticaOrdine> defaultList(String minsan) {
    return List.generate(
        12,
            (index) => StatisticaOrdine(
                minsan: minsan,
                anno: DateTime.now().year,
                mese: index+1,
                venduto: 0,
                totaleAcquisti: 0,
            )
    );
  }
}