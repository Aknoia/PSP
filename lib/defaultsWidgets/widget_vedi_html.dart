// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_html/flutter_html.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:intl/intl.dart';

// Project imports:
import '../defaultsWidgets/widget_appbar_back.dart';
import '../modelli/notizia.dart';

class Vedihtml extends StatelessWidget {
  const Vedihtml({Key? key, required this.notizia}) : super(key: key);

  final Notizia notizia;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true ,

        leading: const AppbarBackButton(),

        title: Image.asset('assets/immagini/scritta.png'),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            const SizedBox(height: 40.0),

            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: AutoSizeText(
                notizia.titolo,
                maxLines: 2,
                minFontSize: 20.0,
                maxFontSize: 25.0,

                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 40.0),

            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Html(
                data: notizia.contenutoHTML,


                style: {
                  'strong' : Style(
                    color: Colors.red,
                  ),

                  'div' : Style(
                    backgroundColor: Colors.grey.shade100,
                  ),

                  'a' : Style(
                    color: Colors.green.shade800,
                  ),

                  '*' : Style(
                    fontSize: FontSize.large,
                  ),
                },
              ),
            ),

            const SizedBox(height: 10.0),

            Container(
              margin: const EdgeInsets.only(left: 15.0, right: 10.0),

              alignment: Alignment.centerLeft,
              child: const AutoSizeText(
                'Data: ',
                minFontSize: 5.0,
                maxFontSize: 14.0,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),

            Container(
              margin: const EdgeInsets.only(left: 15.0, right: 10.0),

              alignment: Alignment.centerLeft,
              child: AutoSizeText(
                DateFormat('dd/MM/yyyy HH:mm').format(notizia.dataPubblicazione),
                maxLines: 2,
                minFontSize: 5.0,
                maxFontSize: 12.0,
                textAlign: TextAlign.start,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}