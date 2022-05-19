// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'widget_colonne_testo.dart';
import '../theme/shapes.dart';

class RicercaVuota extends StatelessWidget {
  const RicercaVuota({Key? key, required this.messaggio}) : super(key: key);

  final String messaggio;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,

      child: Card(
        elevation: 5.0,
        shape: kCardShape,

        child: ListTile(
          title: WidgetColonneTesto(
            descrizioneColonne: [messaggio, '0'],
            larghezza: const [0.5, 0.4],
            allinea: const [TextAlign.left, TextAlign.right],
            stileTesto: const [FontWeight.bold, FontWeight.bold],
            colori: const [Colors.black, Colors.black],
            fSize: const [14, 14],
          ),

          subtitle: const Text(
            '0,00€',
            textAlign: TextAlign.right,
          ),
        ),
      ),
    );
  }
}