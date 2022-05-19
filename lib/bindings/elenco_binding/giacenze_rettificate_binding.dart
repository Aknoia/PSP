// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../controllers/advisor_controller/giacenze_rettificate_controller.dart';

class GiacenzeRettBinding implements Bindings {

  @override
  void dependencies() {
    Get.put(GiacenzeRettificateController());
  }
}