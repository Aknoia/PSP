// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../theme/dimensioni.dart';


Widget widgetTitoloStatistica(String descrizione) {
  Widget titoloDaMostrare;

  if (descrizione.length > 4) {
    titoloDaMostrare = Text(
      descrizione,
      style: TextStyle(
        fontSize: fontSizeGrande,
        color: Colors.black,
      ),
    );
  } else {
    titoloDaMostrare = Text(
        'Nessuna descrizione',
        style: TextStyle(
          fontSize: fontSizeGrande - 4,
          color: Colors.black,
        ),
    );
  }



  return Container(
    margin: const EdgeInsets.only(top: 5.0, bottom: 5.0),
    alignment: Alignment.center,
    child: titoloDaMostrare,
  );
}
