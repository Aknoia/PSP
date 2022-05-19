// Flutter imports:
import 'package:flutter/material.dart';


class BarraColorataOrizzontale extends StatelessWidget {
  const BarraColorataOrizzontale({Key? key, required this.altezza, required this.lunghezza, required this.colore, this.bordi = EdgeInsets.zero}) : super(key: key);

  final double altezza;
  final double lunghezza;
  final Color colore;
  final EdgeInsets bordi;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: altezza,
      color: colore,
      margin: bordi,
      child: SizedBox(
        height: 5.0,
        width: lunghezza,
      ),
    );
  }

}

//TODO
// Widget barraColorataOrizzontale({required double altezza, required double lunghezza, required Color colore, EdgeInsets bordi = EdgeInsets.zero}) {
//   return Container(
//     height: altezza,
//     color: colore,
//     margin: bordi,
//     child: SizedBox(
//       height: 5.0,
//       width: lunghezza,
//     ),
//   );
// }
