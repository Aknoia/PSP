// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import '../../utils/impostazioni.dart';
import '../../theme/shapes.dart';
import '../../controllers/qr_controller/qr_code_scan_controller.dart';

class QRCodeScan extends GetView<QRCodeController> {
  const QRCodeScan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Future.value(false),

      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,

          title: const Text(
            'Leggi Codice QR',
            style: TextStyle(color: Colors.black),
          ),

          leading: IconButton(
            icon: Image.asset(
              'assets/defaultIcons/freccia_indietro.png',
              scale: 2,
            ),

            onPressed: () => Get.offNamed('/'),
          ),
        ),

        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

              Card(
                margin: const EdgeInsets.all(20.0),
                shape: kCardShape,

                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "L'app deve essere associata al\nqrcode fornito da Siteam per funzionare.\nLEGGI QR CODE",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),

                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: kCardShape,
                  ),

                  onPressed: ()  async {
                    await controller.leggiQRCode();
                    Get.offNamed('/');
                  } ,

                  child: AutoSizeText(
                    'Leggi Codice QR',
                    maxLines: 1,
                    style: TextStyle(color: Colors.green.shade800),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),

                child: ElevatedButton(

                  style: ElevatedButton.styleFrom(
                    shape: kCardShape,
                  ),

                  onPressed: () => Get.offNamed('/'),

                  child: AutoSizeText(
                    'Esci',
                    style: TextStyle(color: Colors.red.shade900),
                  ),
                ),
              ),

              const SizedBox(height: 25.0),

              (controller.inErrore.value) ? Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  border: Border.all(
                    width: 1.0,
                    color: Colors.red.shade900,
                  ),
                ),

                child: AutoSizeText(
                  '${DatiUtente.recuperaToken()}',
                  maxLines: 1,
                ),
              )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
