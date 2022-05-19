// Project imports:
import 'controlla_numero.dart';
import 'controlla_valore_null.dart';

double prendiNumero(dynamic variabile) {

  if (controllaNumero(variabile)) {
    double risultatoParse = double.tryParse(variabile) as double;

    if (checkValoreNull(risultatoParse)) {
      risultatoParse = 0;
    }

    return risultatoParse;
  } else {

    if (checkValoreNull(variabile)) {
      variabile = '0';
    }

    return double.parse(variabile.replaceAll(RegExp(r'\.'), '').replaceAll(RegExp(r'\,'), '.'));
  }
}