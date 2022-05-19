// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../../modelli/storico_vendite.dart';
import '../../../../defaultsWidgets/barra_colorata_orizzontale.dart';
import '../../../../defaultsWidgets/widget_dati_vendite.dart';

class EspandiVendite extends StatelessWidget {
  const EspandiVendite({Key? key, required this.vendite, required this.fontSize}) : super(key: key);

  final List<VenditaSingola> vendite;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    List<Widget> colonne = [];

    for (VenditaSingola vendita in vendite) {
      colonne.add(
        ListTile(
          title: Column(
              children: <Widget>[
                (identical(vendita, vendite.first)) ? BarraColorataOrizzontale(altezza: 2, colore: Colors.cyan.shade600, lunghezza: double.infinity) : const SizedBox(),

                const SizedBox(height: 5),

                Text(
                  '(${vendita.quantita}) - ${vendita.nomeProdotto}',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: fontSize * 0.8,
                  ),
                ),
              ]
          ),

          subtitle: Column(
            children: <Widget>[

              const SizedBox(height: 10.0),

              WidgetDatiVendite(
                  descrizione: 'Prz. Lordo:',
                  valore: vendita.prezzoLordo.toString(),
                  coloreDati: Colors.black,
                  nonUsareEuro: false,
                  fSize: fontSize * 0.8
              ),

              WidgetDatiVendite(
                descrizione: 'Sconto:',
                valore: vendita.valoreSconto.toString(),
                coloreDati: Colors.black,
                nonUsareEuro: false,
                fSize: fontSize * 0.8,
              ),

              WidgetDatiVendite(
                descrizione: 'Totale prodotti:',
                valore: '${vendita.totaleVendita + vendita.totaleRicetta}',
                coloreDati: Colors.black,
                nonUsareEuro: false,
                fSize: fontSize * 0.8,
              ),

              const SizedBox(height: 10.0),

              (vendite.length != 1 && !identical(vendita, vendite.last)) ? BarraColorataOrizzontale(altezza: 2, colore: Colors.cyan.shade600, lunghezza: double.infinity) : const SizedBox(),
            ],
          ),
        ),
      );
    }

    return Column(
      children: colonne
    );
  }
}

