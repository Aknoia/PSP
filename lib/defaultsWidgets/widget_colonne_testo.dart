// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_size_text/auto_size_text.dart';


// Project imports:
import '../theme/dimensioni.dart';

class WidgetColonneTesto extends StatelessWidget {
  const WidgetColonneTesto({Key? key, required this.descrizioneColonne, required this.larghezza, required this.allinea, required this.stileTesto, this.colori = const [], this.fSize = const []}) : super(key: key);

  final List<String> descrizioneColonne;
  final List<double> larghezza;
  final List<TextAlign> allinea;
  final List<FontWeight> stileTesto;
  final List<Color> colori;
  final List<double> fSize;

  @override
  Widget build(BuildContext context) {
    final double larghezzaDisplay =  larghezzaSchermo - 15;

    if (descrizioneColonne.length != larghezza.length) {
      return const Text('descrizione colonne deve avere stessi elementi di larghezza');
    }

    int n = 0;
    List<Widget> colonne = [];

    for (var element in larghezza) {
      colonne.add(
        SizedBox (
          width: element * larghezzaDisplay,

          child: AutoSizeText(
            descrizioneColonne[n],

            softWrap: false,
            textAlign: allinea[n],

            style: TextStyle(
              color: colori[n],
              fontSize: fSize[n],
              fontWeight: stileTesto[n],
            ),

            maxLines: 1,
          ),
        ),
      );

      n++;
    }

    return Padding(
      padding: const EdgeInsets.all(0.0),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: colonne,
      ),
    );
  }

}

//TODO
// Widget widgetColonneTesto(List<String> descrizioneColonne, List<double> larghezza, List<TextAlign> allinea, List<FontWeight> stileTesto, {List<Color> colori = const [], List<double> fSize = const []}) {
//   final double larghezzaDisplay =  larghezzaSchermo - 15;
//
//   if (descrizioneColonne.length != larghezza.length) {
//     return const Text('descrizione colonne deve avere stessi elementi di larghezza');
//   }
//
//   int n = 0;
//   List<Widget> colonne = [];
//
//   for (var element in larghezza) {
//     colonne.add(
//       SizedBox (
//         width: element * larghezzaDisplay,
//
//         child: AutoSizeText(
//           descrizioneColonne[n],
//
//           softWrap: false,
//           textAlign: allinea[n],
//
//           style: TextStyle(
//             color: colori[n],
//             fontSize: fSize[n],
//             fontWeight: stileTesto[n],
//           ),
//
//           maxLines: 1,
//         ),
//       ),
//     );
//
//     n++;
//   }
//
//   return Padding(
//     padding: const EdgeInsets.all(0.0),
//
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//
//       children: colonne,
//     ),
//   );
//
// }