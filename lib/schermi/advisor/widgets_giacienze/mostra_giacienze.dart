// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '../../../controllers/advisor_controller/giacenze_rettificate_controller.dart';
import '../../../defaultFunctions/data_america_to_ita.dart';
import '../../../theme/shapes.dart';

class MostraGiacienze extends StatelessWidget {
  const MostraGiacienze({Key? key, required this.controller}) : super(key: key);

  final GiacenzeRettificateController controller;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 3,
      child: Column(
        children: <Widget>[
          const SizedBox(height: 15.0),

          const Text(
            'Giacenze rettificate:',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15.0),

          Expanded(
            child: ListView.builder(
                itemCount: controller.giacienze.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
                    padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),

                    child: Card(
                      shape: kCardShape,
                      elevation: 10.0,
                      child: ListTile(
                        title: Column(
                          children: <Text>[
                            Text("${controller.giacienze[index]['utente']}"),

                            Text("${dataAmericaToIta(controller.giacienze[index]['data'])} ${controller.giacienze[index]['orareg']}"),
                          ],
                        ),

                        subtitle: Column(
                          children: <Widget>[

                            Divider(
                              color: Colors.cyan.shade600,
                              thickness: 1,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text("Minsan: ${controller.giacienze[index]['minsan']}"),

                                if (controller.giacienze[index]['descrprodotto'] != null) Text("Prodotto: ${controller.giacienze[index]['descrprodotto']}") else const Text('prodotto sconosciuto'),

                                Text("Quantità: ${controller.giacienze[index]['qta']}pz."),

                                Text("Giac|Disp:  ${controller.giacienze[index]['giacenza']} | ${controller.giacienze[index]['disponibilita']}   [${controller.giacienze[index]['caumag']}]"),
                              ],
                            ),

                            const SizedBox(height: 20.0),
                          ],
                        ),
                      ),
                    ),
                  );
                }
            ),
          ),
        ],
      ),
    );
  }
}
