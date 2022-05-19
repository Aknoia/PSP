// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:enum_to_string/enum_to_string.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import '../../defaultsWidgets/widget_dati_vendite.dart';
import '../../defaultsWidgets/widget_appbar_back.dart';
import '../../modelli/statistica.dart';
import '../../utils/enums.dart';
import '../../theme/dimensioni.dart';
import '../../theme/shapes.dart';


class DettaglioStatistica extends StatelessWidget {
  const DettaglioStatistica({Key? key, required this.dati, required this.tipoReport}) : super(key: key);

  final Statistica dati;

  final TipoStatistica tipoReport;

  @override
  Widget build(BuildContext context) {
    var datiJSON = dati.toJSON();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        leading: const AppbarBackButton(),

        title: Image.asset('assets/immagini/scritta.png'),
      ),

      body: Column(
        children: <Widget> [
          Card(
            elevation: 5.0,
            color: Get.theme.scaffoldBackgroundColor,
            shape: kShapeOrdineProv,

            child: Column (
              children: <Widget> [

                const SizedBox(
                  height: 15.0,
                  width: 400.0,
                ),

                AutoSizeText(
                  'Dettaglio ${EnumToString.convertToString(tipoReport)}'.toUpperCase(),
                  minFontSize: 20.0,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                Text(
                  dati.descrizione,
                  style: const TextStyle(fontSize: 15),
                ),

                const SizedBox(
                  height: 15.0,
                  width: 400.0,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20.0),

          Expanded(
            child: ListView.builder(
                itemCount: datiJSON.length,
                itemBuilder: (context, index) {
                  String chiave = traduci(datiJSON.keys.toList()[index]);

                  if (chiave.contains('TOT.GENERALE') || chiave == 'Descrizione') {
                    return Container();
                  } else {
                    return Card(
                      elevation: 2.0,
                      shape: kShapeOrdineProv,

                      child: Column(
                        children: <Widget>[

                          const SizedBox(height: 10.0),

                          WidgetDatiVendite(
                            descrizione: ' $chiave',
                            valore: (datiJSON.values.toList()[index].toString() == ' ') ? 'Nessuna descrizione': datiJSON.values.toList()[index].toString(),
                            coloreDati: Colors.black,
                            nonUsareEuro: (chiave.toLowerCase().contains('num') || (chiave == 'codice') ||  chiave.contains('%')) ? true : false,
                            fSize: fontSizePiccolo,
                          ),


                          const SizedBox(height: 10.0),
                        ],
                      ),
                    );
                  }
                }
            ),
          ),
        ],
      ),
    );
  }

  String traduci(String valore) {
    switch (valore) {
      case 'codice':
        return 'Codice ${EnumToString.convertToString(tipoReport)}';

      case 'descrizione':
        return 'Descrizione';

      case 'totqtavenduta':
        return 'Numero pezzi venduti';

      case 'totacqditta':
        return 'Numero acquisti diretti';

      case 'totacqgross':
        return 'Numero acquisti grossista';

      case 'totacquisti':
        return 'Numero totale acquisti';

      case 'totresi':
        return 'Numero pz. resi';

      case 'totvalvenduto':
        return 'Valore venduto';

      case 'totvalacqditta':
        return 'Valore acquisti diretti';

      case 'totvalacqgross':
        return 'Valore acquisti grossista';

      case 'totvalacquisti':
        return 'Valore totale acquisti';

      case 'totvalresi':
        return 'Valore totale resi';

      case 'prezzo_medio':
        return 'Prezzo medio';

      case 'tt_pezzi_vend':
        return 'TOT.GENERALE: num pezzi venduti';

      case 'tt_val_vend':
        return 'TOT.GENERALE: venduto';

      case 'incidenzaval':
        return '% Incidenza valore';

      case 'incidenzaqta':
        return '% incidenza quantità';

      case 'tt_pezzi_acq':
        return 'TOT.GENERALE: num. acquisti';

      case 'tt_val_acq':
        return 'TOT.GENERALE: acquisti';

      case 'mc':
        return '% Margine';

      case 'mc_gruppo':
        return 'TOT.GENERALE: % Margine periodo';

      case 'tt_val_vend_ivato':
        return 'Valore venduto ivato';

      case 'o_totvalvenduto_netto':
        return 'Totale valore venduto netto';

      default:
        return valore;
    }
  }
}
