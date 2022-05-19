// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../controllers/qr_controller/qr_code_scan_controller.dart';

class QRCodeBindings implements Bindings {

  @override
  void dependencies() {
    Get.put(QRCodeController());
  }
}