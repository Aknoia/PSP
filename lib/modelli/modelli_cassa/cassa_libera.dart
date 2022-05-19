
class CassaLibera {
  String numeroPezzi;
  String totaleSconti;
  String totaleVenditaLibera;
  String totaleSospesi;
  String totaleAcconti;
  String numeroSospesi;
  String importoTotaleAcconti;
  String totaleAccontiRimborsati;
  String totaleScontiVenditaLibera;
  String valoreVenditaAlCosto;
  String totaleLiberaDeivato;
  String totaleAccontiPrenotazioni;
  String valorePrenotazioniConsegnate;
  String totaleVenditeAccredito;
  String totalePrenotazioni;
  String totaleVenditaVaria;
  String totaleScontiFineVendita;
  String numeroVenditeLibera;
  String totaleCassa;

  CassaLibera({
    required this.numeroPezzi,
    required this.totaleSconti,
    required this.totaleVenditaLibera,
    required this.totaleSospesi,
    required this.totaleAcconti,
    required this.numeroSospesi,
    required this.importoTotaleAcconti,
    required this.totaleAccontiRimborsati,
    required this.totaleScontiVenditaLibera,
    required this.valoreVenditaAlCosto,
    required this.totaleLiberaDeivato,
    required this.totaleAccontiPrenotazioni,
    required this.valorePrenotazioniConsegnate,
    required this.totaleVenditeAccredito,
    required this.totalePrenotazioni,
    required this.totaleVenditaVaria,
    required this.totaleScontiFineVendita,
    required this.numeroVenditeLibera,
    required this.totaleCassa,
  });

  factory CassaLibera.fromJson(Map<String, dynamic> json) {
    return CassaLibera(
      numeroPezzi: json['NUMPEZZI'],
      totaleSconti: json['TOTALESCONTI'],
      totaleVenditaLibera: json['TOTVENDLIBERA'],
      totaleSospesi: json['TOTSOSPESI'],
      totaleAcconti: json['TOTACCONTI'],
      numeroSospesi: json['NUMEROSOSPESI'],
      importoTotaleAcconti: json['IMPTOTACCONTI'],
      totaleAccontiRimborsati:  json['TOTACCRIMBORSATI'],
      totaleScontiVenditaLibera: json['TOTALISCONTIVENDLIBERA'],
      valoreVenditaAlCosto:  json['VALOREVENDITAALCOSTO'],
      totaleLiberaDeivato: json['TOTLIBERADEIVATO'],
      totaleAccontiPrenotazioni: json['TOTACCONTIPRENOTAZIONI'] ,
      valorePrenotazioniConsegnate: json['VALPRENOTAZIONICONSEGNATE'],
      totaleVenditeAccredito: json['TOTACCVENDITEACREDITO'],
      totalePrenotazioni:  json['TOTPRENOTAZIONI'],
      totaleVenditaVaria:  json['TOTVENDVARIA'],
      totaleScontiFineVendita: json['TOTSCONTIFINEVENDITA'],
      numeroVenditeLibera:  json['NUMVENDITELIBERA'],
      totaleCassa: json['TOTCASSA'],
    );
  }


  factory CassaLibera.fromDEFAULT() {
    return CassaLibera(
      numeroPezzi: '',
      totaleSconti: '',
      totaleVenditaLibera: '',
      totaleSospesi: '',
      totaleAcconti: '',
      numeroSospesi: '',
      importoTotaleAcconti: '',
      totaleAccontiRimborsati: '',
      totaleScontiVenditaLibera: '',
      valoreVenditaAlCosto: '',
      totaleLiberaDeivato: '',
      totaleAccontiPrenotazioni: '',
      valorePrenotazioniConsegnate: '',
      totaleVenditeAccredito: '',
      totalePrenotazioni: '',
      totaleVenditaVaria: '',
      totaleScontiFineVendita: '',
      numeroVenditeLibera: '',
      totaleCassa: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'NUMPEZZI' : numeroPezzi,
      'TOTALESCONTI' : totaleSconti,
      'TOTVENDLIBERA' : totaleVenditaLibera,
      'TOTSOSPESI' : totaleSospesi,
      'TOTACCONTI' : totaleAcconti,
      'NUMEROSOSPESI' : numeroSospesi,
      'IMPTOTACCONTI' : importoTotaleAcconti,
      'TOTACCRIMBORSATI' : totaleAccontiRimborsati,
      'TOTALISCONTIVENDLIBERA' : totaleScontiVenditaLibera,
      'VALOREVENDITAALCOSTO' : valoreVenditaAlCosto,
      'TOTLIBERADEIVATO' : totaleLiberaDeivato,
      'TOTACCONTIPRENOTAZIONI' : totaleAccontiPrenotazioni,
      'VALPRENOTAZIONICONSEGNATE' : valorePrenotazioniConsegnate,
      'TOTACCVENDITEACREDITO' : totaleVenditeAccredito,
      'TOTPRENOTAZIONI' : totalePrenotazioni,
      'TOTVENDVARIA' : totaleVenditaVaria,
      'TOTSCONTIFINEVENDITA' : totaleScontiFineVendita,
      'NUMVENDITELIBERA' : numeroVenditeLibera,
      'TOTCASSA' : totaleCassa,
    };
  }
}