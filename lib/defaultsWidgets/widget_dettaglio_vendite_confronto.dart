// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl.dart';

// Project imports:
import '../defaultFunctions/prendi_numero.dart';


class WidgetDatiVenditeConfronto extends StatelessWidget {
  const WidgetDatiVenditeConfronto({Key? key, required this.vecchioValore, required this.nuovoValore, this.nonUsareEuro = false, this.cifre = 2, this.fSize = 13, this.usaPercentuale = false}) : super(key: key);

  final dynamic vecchioValore;
  final dynamic nuovoValore;

  final bool usaPercentuale;
  final bool nonUsareEuro;

  final int cifre;

  final double fSize;

  @override
  Widget build(BuildContext context) {
    // Inizializzo variabili del widget
    double fontSize = fSize * 0.8;
    double numero = prendiNumero(nuovoValore ?? '0') - prendiNumero(vecchioValore ?? '0');

    Color coloreDati = Colors.black;
    String suffisso = '';

    if (numero > 0) {
      coloreDati = Colors.green;
      suffisso = '+';
    } else {
      coloreDati = Colors.red;
    }


    Widget widgetDaMostrare = const SizedBox();

    if (!nonUsareEuro) {
      widgetDaMostrare = SelectableText(
        suffisso + NumberFormat.currency(
            locale: 'it',
            decimalDigits: 2,
            symbol: '€' ).format(numero),

        style: TextStyle(
            color: coloreDati,
            fontSize: fontSize
        ),

        textAlign: TextAlign.right,
      );
    } else {
      widgetDaMostrare = SelectableText(
          suffisso + numero.toStringAsFixed(cifre) + ((usaPercentuale) ? '%' : ' '),
          style: TextStyle(
              color: coloreDati,
              fontSize: fontSize
          ),
          textAlign: TextAlign.left
      );
    }


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: <Widget>[

        const Text(
            '',
            textAlign: TextAlign.left
        ),

        Padding(
          padding: const EdgeInsets.only(right: 10.0),

          child: widgetDaMostrare,
        ),
      ],
    );
  }
}

// TODO
// Widget WidgetDatiVenditeConfronto(var vecchioValore, var valore, {bool percentuale = false, bool noEuro = false, int cifre = 2, double fsize = 13}) {
//
//   fsize *= 0.8;
//
//   if (checkValoreNull(valore)) {
//     valore = '0';
//   }
//
//   valore = valore.toString();
//
//   if (checkValoreNull(vecchioValore)) {
//     vecchioValore = '0';
//   }
//
//   vecchioValore = vecchioValore.toString();
//
//   double num = prendiNumero(valore) - prendiNumero(vecchioValore);
//
//   Color coloreDato = Colors.black;
//   String suffisso = '';
//
//   if (num > 0) {
//     coloreDato = Colors.green;
//     suffisso = '+';
//   } else {
//     coloreDato = Colors.red;
//   }
//
//
//   Widget widgetDaMostrare;
//   if (!noEuro) {
//     widgetDaMostrare = SelectableText(
//         suffisso + NumberFormat.currency(
//             locale: 'it',
//             decimalDigits: 2,
//             symbol: '€' ).format(num),
//
//         style: TextStyle(
//             color: coloreDato,
//             fontSize: fsize
//         ),
//
//         textAlign: TextAlign.right,
//     );
//   } else {
//     widgetDaMostrare = SelectableText(
//         suffisso + num.toStringAsFixed(cifre) + ((percentuale) ? '%' : ' '),
//         style: TextStyle(
//             color: coloreDato,
//             fontSize: fsize
//         ),
//         textAlign: TextAlign.left
//     );
//   }
//
//
//
//
//
//
//
//   return Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//     children: <Widget>[
//
//       const Text(
//         '',
//         textAlign: TextAlign.left
//       ),
//
//       Padding(
//         padding: const EdgeInsets.only(right: 10.0),
//
//         child: widgetDaMostrare,
//       ),
//     ],
//   );
// }