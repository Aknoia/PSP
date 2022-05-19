// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';



// Project imports
import 'widgets/widget_configura_farmacie.dart';
import '../../controllers/login_controller/pagina_login_controller.dart';
import '../../theme/dimensioni.dart';
import '../../defaultsWidgets/widget_in_caricamento.dart';

class PaginaLogin extends GetView<LoginController> {
  const PaginaLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    larghezzaSchermo  = Get.mediaQuery.size.width;
    altezzaSchermo    = Get.mediaQuery.size.height;

    fontSizePiccolo = 30 * larghezzaSchermo / 614.0;
    fontSizeMedio   = 30 * larghezzaSchermo / 590.0;
    fontSizeGrande  = 30 * larghezzaSchermo / 544.0;

    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,

          /// Rimuove tasto appBar
          automaticallyImplyLeading: false,

          title: GestureDetector(
            child: Image.asset('assets/immagini/scritta.png'),

            onTap: () => Get.toNamed('/crediti'),
          ),
        ),
      body: Center(
          child: controller.obx(
              (state) => WidgetConfiguraFarmacie(controller: controller),
              onLoading: const WidgetInCaricamento(),
              onError: (errore) => Text(errore.toString())),
      ),
    );
  }
}