


class Offerta {

  String minsan;

  String codiceFornitore;
  String fornitore;

  double costo;

  int quantita;


  Offerta({
    required this.minsan,
    required this.codiceFornitore,
    required this.fornitore,
    required this.costo,
    required this.quantita
  });


  factory Offerta.fromJSON(Map<String, dynamic> json) {
    return Offerta(
        minsan: json['minsan'],
        codiceFornitore: json['codforn'],
        fornitore: json['fornitore'],
        costo: json['costo'].toDouble(),
        quantita: json['quantita'],
    );
  }

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'codforn' : codiceFornitore,
      'fornitore' : fornitore,
      'quantita' : quantita,
      'costo' : costo,
      'minsan' : minsan,
    };
  }

}