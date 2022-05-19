// Project imports:
import 'controlla_valore_null.dart';
import 'controlla_numero.dart';

int? prendiInt(var variabile) {

  if (controllaNumero(variabile)) {
    int? risultatoParse = int.tryParse(variabile);

    if (checkValoreNull(risultatoParse)) {
      risultatoParse = 0;
    }

    return risultatoParse;

  } else {

    if (checkValoreNull(variabile)) {
      variabile = '0';
    }
    return int.parse(variabile);
  }
}