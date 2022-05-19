

class CassaMedie {

  String numeroPezzi;
  String numeroScontrini;
  String numeroRicette;
  String totaleImportoScontrini;
  String totaleImportoRicette;
  String mediaRicette;
  String mediaScontrini;
  String totaleImportoCaricoUSL;
  String totaleImportoIncassato;
  String numeroScontriniVenLibera;
  String numeroRicetteDEM;
  String numeroRicetteRosse;
  String numeroScontriniFIDCARD;
  String numeroGiorniLavorati;
  String numeroScontriniZero;
  String numeroStampeScontrini;

  CassaMedie({
    required this.numeroPezzi,
    required this.numeroScontrini,
    required this.numeroRicette,
    required this.totaleImportoScontrini,
    required this.totaleImportoRicette,
    required this.mediaRicette,
    required this.mediaScontrini,
    required this.totaleImportoCaricoUSL,
    required this.totaleImportoIncassato,
    required this.numeroScontriniVenLibera,
    required this.numeroRicetteDEM,
    required this.numeroRicetteRosse,
    required this.numeroScontriniFIDCARD,
    required this.numeroGiorniLavorati,
    required this.numeroScontriniZero,
    required this.numeroStampeScontrini
  });

  factory CassaMedie.fromJSON(Map<String ,dynamic> json) {
    return CassaMedie(
      numeroPezzi: json['NUMPEZZI'],
      numeroScontrini: json['NUMSCONTRINI'],
      numeroRicette: json['NUMERORICETTE'],
      totaleImportoScontrini: json['TOTIMPORTOSCONTRINI'],
      totaleImportoRicette: json['TOTIMPORTORICETTE'],
      mediaRicette: json['MEDIARICETTE'],
      mediaScontrini: json['MEDIASCONTRINI'],
      totaleImportoCaricoUSL: json['TOTIMPACARICOUSL'],
      totaleImportoIncassato: json['TOTIMPINCASSATOSCONTR'],
      numeroScontriniVenLibera: json['NUMSCONTRVENDLIBERA'],
      numeroRicetteDEM: json['NUMRICETTEDEM'],
      numeroRicetteRosse: json['NUMRICETTEROSSE'],
      numeroScontriniFIDCARD: json['NUMSCONTRFIDCARD'],
      numeroGiorniLavorati: json['NUMGIORNILAVORATI'],
      numeroScontriniZero: json['NUMSCONTRAZERO'],
      numeroStampeScontrini: json['NUMRISTAMPESCONTRINI'],
    );
  }



  factory CassaMedie.fromDEFAULT() {
    return CassaMedie(
      numeroPezzi: '',
      numeroScontrini: '',
      numeroRicette: '',
      totaleImportoScontrini: '',
      totaleImportoRicette: '',
      mediaRicette: '',
      mediaScontrini: '',
      totaleImportoCaricoUSL: '',
      totaleImportoIncassato: '',
      numeroScontriniVenLibera: '',
      numeroRicetteDEM: '',
      numeroRicetteRosse: '',
      numeroScontriniFIDCARD: '',
      numeroGiorniLavorati: '',
      numeroScontriniZero: '',
      numeroStampeScontrini: '',
    );
  }



  Map<String, dynamic> toJSON() {
    return {
      'NUMPEZZI': numeroPezzi,
      'NUMSCONTRINI': numeroScontrini,
      'NUMERORICETTE': numeroRicette,
      'TOTIMPORTOSCONTRINI': totaleImportoScontrini,
      'TOTIMPORTORICETTE': totaleImportoRicette,
      'MEDIARICETTE': mediaRicette,
      'MEDIASCONTRINI': mediaScontrini,
      'TOTIMPACARICOUSL': totaleImportoCaricoUSL,
      'TOTIMPINCASSATOSCONTR': totaleImportoIncassato,
      'NUMSCONTRVENDLIBERA': numeroScontriniVenLibera,
      'NUMRICETTEDEM': numeroRicetteDEM,
      'NUMRICETTEROSSE': numeroRicetteRosse,
      'NUMSCONTRFIDCARD': numeroScontriniFIDCARD,
      'NUMGIORNILAVORATI': numeroGiorniLavorati,
      'NUMSCONTRAZERO': numeroScontriniZero,
      'NUMRISTAMPESCONTRINI': numeroStampeScontrini
    };
  }

}