class Generico {
  String codice;
  String descrizione;
  String codIVA;
  String classe1;
  String stupefacente;
  String dittaprod;
  String dittaRagSoc;
  String gestRobot;
  String inCommercio;
  String scadenza;

  double prezzoCalc;
  //double przPub;
  //double totOrdineProv;

  int ordine;
  int dispMagazzino;
  int giacRobot;

  Generico({
    required this.codice,
    required this.descrizione,
    required this.prezzoCalc,
    required this.codIVA,
    required this.classe1,
    required this.stupefacente,
    required this.dittaprod,
    required this.dittaRagSoc,
    required this.ordine,
    //required this.totOrdineProv,
    required this.dispMagazzino,
    required this.giacRobot,
    required this.gestRobot,
    required this.inCommercio,
    required this.scadenza,
    //required this.przPub
  });

  factory Generico.fromJson(Map<String, dynamic> json) {
    return Generico(
      codice: json['bd_codice'],
      descrizione: json['bd_descrizione'],
      prezzoCalc: json['bd_prz_calc'].toDouble() ?? 0.0,
      codIVA: json['bd_codiva'],
      classe1: json['bd_classe1'],
      stupefacente: json['bd_stupefacente'],
      dittaprod: json['bd_dittaprod1'],
      dittaRagSoc: json['bd_dittaprod1_ragsoc'],
      ordine:  json['o_ordine'] ?? 0,
      //totOrdineProv: json['o_tot_ordprov'].toDouble() ?? 0.0,
      dispMagazzino: json['o_disp_mag'] ?? 0,
      giacRobot: json['o_giac_robot'] ?? 0,
      gestRobot: json['o_gest_robot'],
      inCommercio: json['bd_commercio'],
      scadenza: json['o_scadenza'],
      //przPub: json['o_diff_przpub_przrimb'].toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic> {
      'bd_codice' : codice,
      'bd_descrizione' : descrizione,
      'bd_prz_calc' : prezzoCalc,
      'bd_codiva' : codIVA,
      'bd_classe1' : classe1,
      'bd_stupefacente' : stupefacente,
      'bd_dittaprod1' : dittaprod,
      'bd_dittaprod1_ragsoc' : dittaRagSoc,
      'o_ordine' : ordine,
      //'o_tot_ordprov' : totOrdineProv,
      'o_disp_mag' : dispMagazzino,
      'o_giac_robot' : giacRobot,
      'o_gest_robot' : gestRobot,
      'bd_commercio' : inCommercio,
      'o_scadenza' : scadenza,
      //'o_diff_przpub_przrimb' : przPub
    };
  }
}