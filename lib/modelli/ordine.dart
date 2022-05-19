


class Ordine {

  String minsan;
  String descrizione;

  int quantita;
  int qtaTotale;
  int iva;

  double prezzo;
  double totale;

  String flag;
  String ditta;


  Ordine({
    required this.minsan,
    required this.descrizione,
    required this.quantita,
    required this.qtaTotale,
    required this.prezzo,
    required this.iva,
    required this.totale,
    required this.flag,
    required this.ditta
  });

  factory Ordine.fromJSON(Map<String, dynamic> json) {
    return Ordine(
      minsan: json['codice'],
      descrizione: json['descrizione'],
      quantita: json['quantita'],
      qtaTotale: json['qta_tot'],
      prezzo: json['prezzo'].toDouble(),
      iva: json['iva'],
      totale: json['totale'].toDouble(),
      flag: json['flag'],
      ditta: json['ditta'],
    );
  }


}