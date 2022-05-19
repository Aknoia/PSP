// Project imports:
import 'modelli_cassa/cassa_libera.dart';
import 'modelli_cassa/cassa_medie.dart';
import 'modelli_cassa/cassa_mutualistica.dart';

class VenditeUtente {

  String nomeUtente;

  CassaLibera cassaLibera;

  CassaMutualistica cassaMutualistica;

  CassaMedie cassaMedie;

  VenditeUtente({
    required this.nomeUtente,
    required this.cassaLibera,
    required this.cassaMutualistica,
    required this.cassaMedie
  });

  factory VenditeUtente.fromJSON(String nomeUtente, Map<String, dynamic> json) {
    return VenditeUtente(
      nomeUtente: nomeUtente,
      cassaLibera: CassaLibera.fromJson(json['TotCassaLibera']),
      cassaMutualistica: CassaMutualistica.fromJSON(json['TotCassaMutualistica']),
      cassaMedie: CassaMedie.fromJSON(json['TotCassaMedie']),
    );
  }

  factory VenditeUtente.fromDEFAULT() {
    return VenditeUtente(
      nomeUtente: '',
      cassaLibera: CassaLibera.fromDEFAULT(),
      cassaMutualistica: CassaMutualistica.fromDEFAULT(),
      cassaMedie: CassaMedie.fromDEFAULT(),
    );
  }



  Map<String, dynamic> toJSON() {
    return {
      nomeUtente : {
        'TotCassaLibera' : cassaLibera.toJson(),

        'TotCassaMutualistica' : cassaMutualistica.toJSON(),

        'TotCassaMedie' : cassaMedie.toJSON(),
      }
    };
  }
}

