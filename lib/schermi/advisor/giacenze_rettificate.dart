// Flutter import:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';

// Project imports:
import 'widgets_giacienze/mostra_giacienze.dart';
import '../../controllers/advisor_controller/giacenze_rettificate_controller.dart';
import '../../defaultsWidgets/widget_in_caricamento.dart';
import '../../defaultsWidgets/widget_appbar_back.dart';


class AdvisorGiacenzeRettificate extends GetView<GiacenzeRettificateController> {
  const AdvisorGiacenzeRettificate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/immagini/scritta.png'),

        centerTitle: true ,

        leading: const AppbarBackButton(),
      ),

      body: controller.obx(
        (state) => MostraGiacienze(controller: controller),

        onLoading: const WidgetInCaricamento(),

        onEmpty: const Center(
          child: AutoSizeText(
            'NESSUNA GIACIENZA DA MOSTRARE',
            minFontSize: 15,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}