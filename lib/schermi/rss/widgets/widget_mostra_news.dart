// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import '../../../controllers/rss_controller/rss_controller.dart';
import '../../../utils/impostazioni.dart';

class MostraNews extends StatelessWidget {
  const MostraNews({Key? key, required this.controller}) : super(key: key);

  final RSSController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 40.0),

          const AutoSizeText(
            'NOTIZIE',
            maxFontSize: 35.0,
            minFontSize: 25.0,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20.0),

          Expanded(
            child: Scrollbar(
              thickness: 3,
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: controller.datiRSS.length,

                  itemBuilder: (context, index) {
                    return Obx(
                          () => Card(
                            elevation: 2.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: BorderSide(
                                width: 2.0,
                                color: (controller.listaNewsLette[index])
                                    ? Colors.green.shade400
                                    : Get.theme.highlightColor,
                              ),
                            ),

                            child: ListTile(
                              title: Text(controller.datiRSS[index].titolo),

                              subtitle: Text(
                                DateFormat('dd/MM/yyyy HH:mm:ss').format(controller.datiRSS[index].dataPubblicazione),
                              ),

                              leading: Image.asset(
                                'assets/defaultIcons/news.png',
                                scale: 1.5,
                                color: (controller.datiRSS[index].notiziaLetta)
                                    ? Colors.blue.shade600
                                    : Colors.redAccent,
                              ),

                              onTap: () {
                                controller.datiRSS[index].notiziaLetta = true;
                                controller.listaNewsLette[index] = true;

                                controller.newsLette.add(controller.datiRSS[index].dataModifica.millisecondsSinceEpoch);

                                DatiUtente.salvaNewsLetter(controller.newsLette);

                                Get.toNamed(
                                  '/vedihtml',
                                  arguments: controller.datiRSS[index],
                                );
                                },
                            ),
                      ),
                    );
                  }
              ),
            ),
          ),
        ],
      ),
    );
  }
}