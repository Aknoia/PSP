// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import 'prendi_numero.dart';

String varToEuro(var variabile) {
  return NumberFormat.currency(
    locale: 'it',
    decimalDigits: 2,
    symbol: '€',
  ).format(prendiNumero(variabile));
}