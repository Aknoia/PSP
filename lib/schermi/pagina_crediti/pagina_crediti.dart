// Flutter imports:
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

// Package imports:
import '../../defaultsWidgets/widget_appbar_back.dart';

// Project imports:
import '../../theme/shapes.dart';

class PaginaCrediti extends StatelessWidget {
  const PaginaCrediti({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        leading: const AppbarBackButton(),

        title: Image.asset('assets/immagini/scritta.png'),
      ),

      body: Column(
        children: <Widget> [

          const SizedBox(height: 25.0),

          const Text(
            'CONTATTI',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 25.0),

          Card(
            elevation: 1.0,
            shape: kCardShape,
            margin: const EdgeInsets.all(10.0),

            child: ListTile(
              title: const AutoSizeText(
                'Telefono',
                maxLines: 1,
                minFontSize: 15.0,
                maxFontSize: 25.0,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              leading: Image.asset(
                'assets/defaultIcons/telefono.png',
                color: Colors.green.shade800,
              ),


              subtitle: const AutoSizeText(
                '0931/491246',
                maxLines: 1,
                minFontSize: 15.0,
                maxFontSize: 20.0,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),

          Card(
            elevation: 1.0,
            shape: kCardShape,
            margin: const EdgeInsets.all(10.0),

            child: ListTile(
              title: const AutoSizeText(
                'Mail pubblica:',
                maxLines: 1,
                minFontSize: 15.0,
                maxFontSize: 25.0,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              leading: Image.asset(
                'assets/defaultIcons/email.png',
                color: Colors.green.shade800,
              ),

              subtitle: const AutoSizeText(
                'mail@siteam.it',
                maxLines: 1,
                minFontSize: 15.0,
                maxFontSize: 20.0,
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),

          Card(
            elevation: 1.0,
            shape: kCardShape,
            margin: const EdgeInsets.all(10.0),

            child: Container(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: ListTile(
                title: const AutoSizeText(
                  'Lunedì - Venerdì',
                  maxLines: 1,
                  minFontSize: 15.0,
                  maxFontSize: 25.0,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),

                leading: Image.asset(
                  'assets/defaultIcons/orologio.png',
                  color: Colors.green.shade800,
                ),

                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <AutoSizeText>[

                    AutoSizeText(
                      '09.00 – 13.00',
                      maxLines: 1,
                      minFontSize: 15.0,
                      maxFontSize: 20.0,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),

                   AutoSizeText(
                     '15.30 – 19.00',
                     maxLines: 1,
                     minFontSize: 15.0,
                     maxFontSize: 20.0,
                     style: TextStyle(fontWeight: FontWeight.w600),
                   ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
