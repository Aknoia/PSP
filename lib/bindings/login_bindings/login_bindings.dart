// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../controllers/login_controller/pagina_login_controller.dart';

class LoginBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}