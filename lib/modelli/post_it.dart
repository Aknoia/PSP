

class PostIT {


  int progressivo;

  String data;
  String utente;
  String nota;
  String riferimento;
  String cliente;
  String telefono;

  bool attiva;
  bool prenotato;
  bool sospeso;
  bool mancataVendita;

  PostIT({
    required this.progressivo,
    required this.data,
    required this.utente,
    required this.nota,
    required this.riferimento,
    required this.cliente,
    required this.telefono,
    required this.attiva,
    required this.prenotato,
    required this.sospeso,
    required this.mancataVendita,
  });


  factory PostIT.fromJSON(Map<String, dynamic> json) {
    return PostIT(
        progressivo: json['progr'] ?? -1,
        data: json['data'].replaceAll(RegExp(r'-'), '/') ?? '',
        utente: json['utente'] ?? '',
        nota: json['nota'] ?? '',
        riferimento: json['riferimento'] ?? '',
        cliente: json['descli'] ?? '',
        telefono: json['tel_sms'] ?? '',
        attiva: (json['attiva'] == 'S') ? true : false,
        prenotato: (json['prenotato'] == 'S') ? true : false,
        sospeso: (json['sospeso'] == 'S') ? true : false,
        mancataVendita: (json['mancataVendita'] == 'S') ? true : false,
    );
  }


}