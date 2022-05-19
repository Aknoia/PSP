

class Statistica {

  String descrizione;

  int pezziVendutiComplessivi;
  int pezziAcquistatiComplessivi;

  double valoreVendutoComplessivo;
  double valoreAcquistatoComplessivo;
  String totaleVenduto;
  double margine;
  double qtaIncidenza;
  double valoreIncidenza;


  Statistica({
    required this.descrizione,
    required this.valoreVendutoComplessivo,
    required this.valoreAcquistatoComplessivo,
    required this.pezziVendutiComplessivi,
    required this.pezziAcquistatiComplessivi,
    required this.totaleVenduto,
    required this.margine,
    required this.qtaIncidenza,
    required this.valoreIncidenza,
  });

  factory Statistica.fromJSON(Map<String, dynamic> json) {
    return Statistica(
      descrizione: json['descrizione'] ?? '',
      valoreVendutoComplessivo: json['tt_val_vend'] ?? 0.0,
      valoreAcquistatoComplessivo: json['tt_val_acq'] ?? 0.0,
      pezziVendutiComplessivi: json['tt_pezzi_vend'] ?? 0,
      pezziAcquistatiComplessivi: json['tt_pezzi_acq'] ?? 0,
      margine: json['mc'].toDouble() ?? 0.0,
      qtaIncidenza: json['incidenzaqta'].toDouble() ?? 0.0,
      totaleVenduto: json['totvalvenduto'].toString(),
      valoreIncidenza: double.parse(json['incidenzaval'].toString()),
    );
  }


  Map<String, dynamic> toJSON() {
    return {
      'descrizione' : descrizione,
      'tt_val_vend' : valoreVendutoComplessivo,
      'tt_val_acq' : valoreAcquistatoComplessivo,
      'tt_pezzi_vend' : pezziVendutiComplessivi,
      'tt_pezzi_acq' : pezziAcquistatiComplessivi,
      'mc' : margine,
      'incidenzaqta' : margine,
      'totvalvenduto' : totaleVenduto,
      'incidenzaval' : valoreIncidenza,
    };
  }
}
