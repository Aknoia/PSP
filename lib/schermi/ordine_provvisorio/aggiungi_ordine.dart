// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';


// Project imports:
import '../pagina_crediti/pagina_crediti.dart';
import '../../utils/api_helper.dart';
import '../../utils/impostazioni.dart';
import '../../theme/shapes.dart';
import '../../controllers/ordine_provvisorio_controller/aggiungi_ordine_controller.dart';
import '../../defaultsWidgets/widget_appbar_back.dart';



class AggiungiOrdine extends GetView<AggiungiOrdineController> {
  const AggiungiOrdine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true ,

        leading: const AppbarBackButton(),

        title: GestureDetector(
          child: Image.asset('assets/immagini/scritta.png'),

          onTap: () => Get.to(() => const PaginaCrediti()),

        ),
      ),

      body: Column(
        children: <Widget>[
          const SizedBox(height: 25.0),

          const Center(
            child: AutoSizeText(
              "COMPILARE L'ORDINE",
              minFontSize: 25.0,
              maxFontSize: 30.0,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25.0),

          Card(
            margin: const EdgeInsets.fromLTRB(
              10.0,
              0.0,
              10.0,
              10.0,
            ),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                width: 1.0,
                color: Colors.cyan.shade600,
              ),
            ),

            child: ListTile(
              title: Obx(
                () => AutoSizeText(
                  controller.prodottoSelezionato.value.descrizione,
                  maxLines: 1,
                  minFontSize: 20.0,
                  maxFontSize: 25.0,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              subtitle: Column(
                children: <Widget>[
                  const SizedBox(height: 10.0),

                  Obx(
                    () => AutoSizeText(
                      'Minsan: ${controller.prodottoSelezionato.value.minsan}',
                      maxLines: 1,
                      minFontSize: 15.0,
                      maxFontSize: 20.0,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),

                  const SizedBox(height: 10.0),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Obx(
                        () => AutoSizeText(
                          'Prezzo unitario: ${controller.prodottoSelezionato.value.prezzoCalc!.toStringAsFixed(2)}€',
                          minFontSize: 15.0,
                          maxFontSize: 20.0,
                          maxLines: 1,
                        ),
                      ),

                      Obx(
                        () => AutoSizeText(
                          'Prezzo totale: ${controller.prezzoTotale.toStringAsFixed(2)}€',
                          maxLines: 1,
                          minFontSize: 15.0,
                          maxFontSize: 20.0,
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),

          const SizedBox(height: 15.0),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(10.0),
                decoration: kBoxDecV2,

                width: 150.0,

                child: ListTile(
                  title: const Text(
                    'Grossista',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: IgnorePointer(
                    ignoring: true,
                    child: AutoSizeTextField(
                      controller: controller.ctrlGrossista,
                      maxFontSize: 15.0,
                      minFontSize: 14.0,
                      textAlign: TextAlign.center,

                      style: const TextStyle(
                        fontSize: 12.0,
                      ),

                      onTap: () => controller.ctrlGrossista.clear(),

                      onSubmitted: (grossista) async {
                        if (grossista.isEmpty || grossista == '') {
                          String fornitore = '';

                          try {
                            fornitore = await DatiUtente.recuperaFornitoreDefault();
                          } catch(e) {
                            fornitore = 'X';
                          } finally {
                            controller.ctrlGrossista.text = fornitore;
                          }
                        }
                      },
                    ),
                  ),

                  onTap: () => controller.mostraGrossisti(),
                ),
              ),

              Container(
                margin: const EdgeInsets.all(10.0),
                decoration: kBoxDecV2,

                width: 150.0,

                child: ListTile(

                  title: const Text(
                    'Quantità',
                    textAlign: TextAlign.center,

                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: AutoSizeTextField(
                    controller: controller.ctrlQta,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,


                    maxFontSize: 16.0,
                    minFontSize: 14.0,
                    textAlign: TextAlign.center,

                    style: const TextStyle(
                      fontSize: 10.0,
                    ),

                    onTap: () => controller.ctrlQta.clear(),

                    onSubmitted: (qta) {

                      if (qta.isEmpty || int.parse(qta) <= 0) {
                        controller.ctrlQta.text = '1';
                      }

                      controller.prezzoTotale.value = controller.prodottoSelezionato.value.prezzoCalc! * double.parse(controller.ctrlQta.text);

                      },
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 20.0),

          SizedBox(
            width: 170.0,
            height: 40.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    width: 1.0,
                    color: Get.theme.selectedRowColor,
                  ),
                ),
              ),

              onPressed: () async {
                try {
                  int risultato = await Get.find<APIHelper>().creaRigaOrdine(
                    controller.ctrlGrossista.text,
                    controller.prodottoSelezionato.value.minsan,
                    int.parse(controller.ctrlQta.text)
                  );

                  if (risultato == 201) {
                    Get.offNamed('/homepage', arguments: [3]);

                    Get.snackbar(
                      'Esito Ordine: ',
                      'Ordine effettuato con successo',
                      backgroundColor: Colors.green,
                      colorText: Colors.black,
                      animationDuration: const Duration(seconds: 4),
                    );

                  } else {
                    throw Exception('Errore creazione ordine');
                  }
                } catch(e) {
                  Get.snackbar(
                    'Esito Ordine: ',
                    'Errore: $e \nTra poco tornerai alla schermata precedente',
                    backgroundColor: Colors.red,
                    colorText: Colors.black,
                  );

                  await Future.delayed(const Duration(seconds: 5));

                  Get.offNamed('/homepage');
                }
              },
              child: Text(
                'Conferma Ordine',
                maxLines: 1,

                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.green.shade800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}