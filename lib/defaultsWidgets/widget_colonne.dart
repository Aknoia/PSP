// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../theme/dimensioni.dart';


class WidgetColonne extends StatelessWidget {
  const WidgetColonne({Key? key, required this.widgets, required this.larghezza}) : super(key: key);

  final List<Widget> widgets;
  final List<double> larghezza;

  @override
  Widget build(BuildContext context) {
    final double larghezzaDisplay =  larghezzaSchermo - 250;

    List<Widget> colonne = [];
    int n = 0;

    for (var element in larghezza) {
      colonne.add(
          SizedBox (
            width: element * larghezzaDisplay,
            child: widgets[n],
          )
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

// TODO
// Widget widgetColonne(List<Widget> widgets, List<double> larghezza, BuildContext context) {
//
//   final double larghezzaDisplay =  larghezzaSchermo - 250;
//
//   List<Widget> colonne = [];
//   int n = 0;
//
//   for (var element in larghezza) {
//     colonne.add(
//         SizedBox (
//           width: element * larghezzaDisplay,
//           child: widgets[n],
//         )
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
//       children: colonne,
//     ),
//   );
// }