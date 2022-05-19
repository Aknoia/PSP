// Flutter imports:
import 'package:flutter/material.dart';


class WidgetInCaricamento extends StatelessWidget {
  const WidgetInCaricamento({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Stack(
          children: <Widget>[

          Image.asset('assets/immagini/wait.png'),


          SizedBox(
            width: 50.0,
            height: 50.0,
            child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade900)),
          ),
        ],
      )
    );
  }
}

/// TODO
/*Widget widgetInCaricamento() => Center(
  child: Stack(
    children: <Widget>[

      Image.asset('assets/immagini/wait.png'),

      SizedBox(
        width: 50.0,
        height: 50.0,
        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.red.shade900)),
      ),
    ],
  ),
);*/