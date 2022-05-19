class CassaMutualistica {

  String importoCaricoUSLDeivato;
  String totaleTicket;
  String totaleQuote;
  String tipoVendita;
  String descrizioneTipoVendita;
  String totaliRicette;
  String totali;
  String totaleVenditaCosto;
  String totaleRicetteDeivato;
  String totaleCaricoUSLDeivato;

  CassaMutualistica({
    required this.importoCaricoUSLDeivato,
    required this.totaleTicket,
    required this.totaleQuote,
    required this.descrizioneTipoVendita,
    required this.tipoVendita,
    required this.totaleCaricoUSLDeivato,
    required this.totaleRicetteDeivato,
    required this.totaleVenditaCosto,
    required this.totali,
    required this.totaliRicette,
  });

  factory CassaMutualistica.fromJSON(Map<String, dynamic> json){
    return CassaMutualistica(
      importoCaricoUSLDeivato: json['IMPACARICOUSLDEIVATO'],
      totaleTicket: json['TOTALETICKET'],
      totaleQuote: json['TOTALEQUOTE'],
      descrizioneTipoVendita: json['DESCRTIPOVEND'],
      tipoVendita: json['TIPOVENDITA'],
      totaleCaricoUSLDeivato: json['TOTACARICOUSLDEIVATO'],
      totaleRicetteDeivato: json['TOTRICETTEDEIVATO'],
      totaleVenditaCosto: json['TOTVENDALCOSTO'],
      totali: json['TOTALI'],
      totaliRicette: json['TOTALIRICETTE'],
    );
  }

  factory CassaMutualistica.fromDEFAULT() {
    return CassaMutualistica(
      importoCaricoUSLDeivato: '',
      totaleTicket: '',
      totaleQuote: '',
      descrizioneTipoVendita: '',
      tipoVendita: '',
      totaleCaricoUSLDeivato: '',
      totaleRicetteDeivato: '',
      totaleVenditaCosto: '',
      totali: '',
      totaliRicette: '',
    );
  }


  Map<String, dynamic> toJSON() {
    return {
      'IMPACARICOUSLDEIVATO': importoCaricoUSLDeivato,
      'TOTALETICKET': totaleTicket,
      'TOTALEQUOTE': totaleQuote,
      'TIPOVENDITA': tipoVendita,
      'DESCRTIPOVEND': descrizioneTipoVendita,
      'TOTALIRICETTE': totaliRicette,
      'TOTALI': totali,
      'TOTVENDALCOSTO': totaleVenditaCosto,
      'TOTRICETTEDEIVATO': totaleRicetteDeivato,
      'TOTACARICOUSLDEIVATO': totaleCaricoUSLDeivato
    };
  }

}