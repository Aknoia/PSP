// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:percent_indicator/percent_indicator.dart';

// Project imports:
import '../defaultsWidgets/widget_dati_vendite.dart';
import '../defaultFunctions/prendi_numero.dart';
import '../defaultFunctions/controlla_valore_null.dart';


Widget percentuale (String descr, var vecchioValore, var valore, {double fsize = 14, bool confrontare = false}) {

  if (checkValoreNull(valore)) {
    valore = '0';
  }

  if (checkValoreNull(vecchioValore)) {
    vecchioValore = '0';
  }

  double num = prendiNumero(valore) - prendiNumero(vecchioValore);
  double perc, scritta;
  String segno = '';

  if (num > 0) {
    perc =  num / prendiNumero(valore);
    scritta = perc * 100;
    segno = '+ ';
  } else {
    if (prendiNumero(vecchioValore) > 0) {
      perc =  prendiNumero(valore) / prendiNumero(vecchioValore);
    } else {
      perc = 0;
    }
    scritta = (1 - perc)*-100;
  }

  if ((perc < 0 ) || (perc > 1)) {
    perc = 0 ;
  }

  if (confrontare) {
    scritta = 100;
  }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,

    children: <Widget>[
      CircularPercentIndicator(
        radius: 60.0,
        animationDuration: 1500,
        lineWidth: 10.0,

        percent: perc,
        animation: true,


        center: Text(
          '$segno${scritta.toStringAsFixed(2)}%',
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 20.0,
          ),
        ),

        circularStrokeCap: CircularStrokeCap.butt,
        backgroundColor : Colors.grey.shade400,
        progressColor : (num > 0) ? Colors.green : Colors.red,
      ) ,

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: <Widget>[

          Text(
            descr,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fsize * 0.9,
            ),
          ),

          WidgetDatiVendite(
            descrizione: 'Valore attuale: ',
            valore: valore,
            coloreDati: Colors.black,
            nonUsareEuro: descr.toLowerCase().contains('num') || descr.contains('%'),
            digits: descr.toLowerCase().contains('num') ? 0 : 2,
            fSize: fsize,
          ),

          (confrontare) ? const SizedBox() : WidgetDatiVendite(
            descrizione: 'Valore preced: ',
            valore: vecchioValore,
            coloreDati: Colors.black,
            nonUsareEuro: descr.toLowerCase().contains('num') || descr.contains('%'),
            digits: descr.toLowerCase().contains('num') ? 0 : 2,
            fSize: fsize,
          ),
        ],
      ),
    ],
  );
}