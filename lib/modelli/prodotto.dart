class Prodotto {

  String minsan;
  String codiceEAN;

  String descrizione;
  String descrizioneEstesa;

  String ragioneSociale;

  double? prezzoCalc;
  double prezzoBancaDati;

  String  dataCalcoloPrezzoFarm;
  String  dataCalcoloBD;

  int disponibilita;
  int giacenzaRobot;
  int qtaMagazzino;

  String codiceFarmaco1;
  String codiceFarmaco2;
  String codiceFarmaco3;
  String codiceFarmaco4;
  String codiceFarmaco5;

  /// Variabili zoom
  int codIVA;
  bool inCommercio;
  bool esaurito;


  Prodotto({
    required this.minsan,
    required this.descrizione,
    required this.descrizioneEstesa,
    required this.codiceEAN,
    required this.ragioneSociale,
    required this.prezzoCalc,
    required this.disponibilita,
    required this.dataCalcoloBD,
    required this.dataCalcoloPrezzoFarm,
    required this.prezzoBancaDati,
    required this.giacenzaRobot,
    required this.qtaMagazzino,
    required this.codiceFarmaco1,
    required this.codiceFarmaco2,
    required this.codiceFarmaco3,
    required this.codiceFarmaco4,
    required this.codiceFarmaco5,
    required this.codIVA,
    required this.inCommercio,
    required this.esaurito,
  });

  factory Prodotto.fromJSON(Map<String, dynamic> json) {
    return Prodotto(
      minsan: json['bd_codice'] ?? 'Minsan non disponibile',
      descrizione: json['bd_descrizione'] ?? 'Descrizione non disponibile',
      descrizioneEstesa: json['o_desc_ext_prod'] ?? '',
      codiceEAN: ((json['bd_ean'] == '') || json['bd_ean'] == null)  ? 'Non disponibile' : json['bd_ean'],
      ragioneSociale: json['bd_dittaprod1_ragsoc'] ?? '',
      dataCalcoloBD: json['bd_dtinizditta1'] ?? '',
      dataCalcoloPrezzoFarm: json['bd_dataprz_calc'] ?? '',
      disponibilita: json['o_disponibilita'] ?? 0,
      prezzoBancaDati: json['bd_prz_bancadati'] ?? 0.0,
      prezzoCalc:  double.tryParse(json['bd_prz_calc'].toString()) ?? 0.0,
      giacenzaRobot: json['o_giac_robot'] ?? 0,
      qtaMagazzino : json['o_disp_mag'] ?? 0,
      codiceFarmaco1: json['bd_atcgmp_liv1_desc'] ?? '',
      codiceFarmaco2: json['bd_atcgmp_liv2_desc'] ?? '',
      codiceFarmaco3: json['bd_atcgmp_liv3_desc'] ?? '',
      codiceFarmaco4: json['bd_atcgmp_liv4_desc'] ?? '',
      codiceFarmaco5: json['bd_atcgmp_liv5_desc'] ?? '',
      codIVA: int.tryParse(json['bd_codiva']) ?? 0,
      inCommercio: json['bd_commercio'] == 'S' ? true : false,
      esaurito: json['o_esauri'] == 'S' ? true : false,
    );
  }


  factory Prodotto.fromDefault() {
    return Prodotto(
      minsan: '',
      descrizione: '',
      descrizioneEstesa: '',
      codiceEAN: '',
      ragioneSociale: '',
      prezzoCalc: 0.00,
      disponibilita: 0,
      dataCalcoloBD: '00/00/0000',
      dataCalcoloPrezzoFarm: '00/00/0000',
      prezzoBancaDati: 0.00,
      giacenzaRobot: 0,
      qtaMagazzino: 0,
      codiceFarmaco1: '',
      codiceFarmaco2: '',
      codiceFarmaco3: '',
      codiceFarmaco4: '',
      codiceFarmaco5: '',
      codIVA: 0,
      inCommercio: false,
      esaurito: false,
    );
  }
}