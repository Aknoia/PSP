// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

// Project imports:
import '../defaultFunctions/prendi_numero.dart';


class WidgetDatiVendite extends StatelessWidget {
  const WidgetDatiVendite({Key? key, required this.descrizione, this.coloreDati = Colors.black, this.valore = '', this.nonUsareEuro = false, this.soloStringhe = false, this.wait = false, this.fSize = 15, this.digits = 0}) : super(key: key);

  final String valore;

  final Color coloreDati;

  final String descrizione;

  final bool nonUsareEuro;
  final bool wait;
  final bool soloStringhe;

  final int digits;
  final double fSize;


  @override
  Widget build(BuildContext context) {
    double fSizeDescrizione   = fSize;
    int digitsDaMostrare      = digits;
    dynamic valoreDaMostrare  = '';




    /// Se non sono tutte stringhe
    if (!soloStringhe) {
      if (valore == '') {
        valoreDaMostrare = '0';
      }

      valoreDaMostrare = valore.toString();
    }



    /// In caso debba aspettare a mostrare i dati
    if (wait) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[
          AutoSizeText(
            descrizione,
            textAlign: TextAlign.left,
            maxLines: 2,

            style: TextStyle(
              fontSize: fSizeDescrizione,
              fontWeight: FontWeight.bold,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 10.0),

            child: SizedBox(
              width: 16.0,
              height: 16.0,

              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade900),
                strokeWidth: 2.0,
              ),
            ),
          ),
        ],
      );
    }



    /// Se sto costruendo le testate e non le righe
    if (descrizione.contains('descrizione') || descrizione.contains('codice') || descrizione.contains('ore:min') || (soloStringhe)) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: <Widget>[

          AutoSizeText(
            descrizione,
            textAlign: TextAlign.left,
            maxLines: 2,
            style: TextStyle(
              fontSize: fSizeDescrizione,
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(right: 10.0),

            child: SelectableText(
              valore,
              style: TextStyle(
                  color: coloreDati,
                  fontSize: fSize
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      );
    }



    /// In caso si stia trattando una percentuale
    if (descrizione.contains('%')) {
      digitsDaMostrare = 2;
    }





    /// Costruisco le righe
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[

        Text(
          descrizione,
          textAlign: TextAlign.left,
          maxLines: 2,
          style: TextStyle(
            fontSize: fSizeDescrizione,
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 10.0),

          child:

          (!nonUsareEuro) ?
            SelectableText(
                NumberFormat.currency(
                    locale: 'it',
                    decimalDigits: 2,
                    symbol: '€',
                ).format(prendiNumero(valoreDaMostrare)),

                style: TextStyle(
                  color: coloreDati,
                  fontSize: fSize,
                ),

                textAlign: TextAlign.right,
            )

          : (descrizione.contains('%')) ?
            SelectableText('${prendiNumero(valoreDaMostrare).toStringAsFixed(digitsDaMostrare)}%',
                style: TextStyle(
                    color: coloreDati,
                    fontSize: fSize,
                ),

                textAlign: TextAlign.right
            ) : SelectableText(
              NumberFormat.currency(locale: 'it', decimalDigits: 0, symbol: '').format(prendiNumero(valoreDaMostrare)),

              style: TextStyle(
                  color: coloreDati,
                  fontSize: fSize,
              ),

              textAlign: TextAlign.right
          ),
        ),
      ],
    );
  }
}




/*Widget widgetDatiVendite({required String descrizione, var valore, required Color coloreDato, bool noEuro = false, int digits = 0, double fsize = 15, bool wait = false, bool soloStringhe = false}) {

  double fSizeDescr = fsize;
  fsize *= 0.8;

  if (!soloStringhe) {
    if (checkValoreNull(valore)) {
      valore = '0';
    }

    valore = valore.toString();
  }

  if (wait) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: <Widget>[
        AutoSizeText(
          descrizione,
          textAlign: TextAlign.left,
          maxLines: 2,

          style: TextStyle(
            fontSize: fSizeDescr,
            fontWeight: FontWeight.bold,
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 10.0),

          child: SizedBox(
            width: 16.0,
            height: 16.0,

            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade900),
              strokeWidth: 2.0,
            ),
          ),
        ),
      ],
    );
  }


  if (descrizione.toLowerCase().contains('descrizione') || descrizione.toLowerCase().contains('codice') || descrizione.toLowerCase().contains('ore:min') || (soloStringhe)) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,

      children: <Widget>[

        AutoSizeText(
          descrizione,
          textAlign: TextAlign.left,
          maxLines: 2,
          style: TextStyle(
            fontSize: fSizeDescr,
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(right: 10.0),

          child: SelectableText(
            '$valore',
            style: TextStyle(
                color: coloreDato,
                fontSize: fsize
            ),
            textAlign: TextAlign.left,
          ),
        ),
      ],
    );
  }

  if (descrizione.contains('%')) {
    digits = 2;
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[

      Text(
        descrizione,
        textAlign: TextAlign.left,
        maxLines: 2,
        style: TextStyle(
          fontSize: fSizeDescr,
        ),
      ),

      Padding(
        padding: const EdgeInsets.only(right: 10.0),

        child: (!noEuro) ?
        SelectableText(  NumberFormat.currency(
            locale: 'it',
            decimalDigits: 2,
            symbol: '€').format(prendiNumero(valore)),
            style: TextStyle(
              color: coloreDato,
              fontSize: fsize,
            ),

            textAlign: TextAlign.right
        ) : (descrizione.contains('%'))
             ? SelectableText('${prendiNumero(valore).toStringAsFixed(digits)}%',
            style: TextStyle(
                color: coloreDato,
                fontSize: fsize
            ),

            textAlign: TextAlign.right
        ) : SelectableText(
            NumberFormat.currency(locale: 'it', decimalDigits: 0, symbol: '').format(prendiNumero(valore)),

            style: TextStyle(
                color: coloreDato,
                fontSize: fsize
            ),

            textAlign: TextAlign.right
        ),
      ),
    ],
  );
}
*/