// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/rss_controller/rss_controller.dart';

class RSSBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RSSController());
  }
}