// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../utils/api_helper.dart';

class GiacenzeRettificateController extends GetxController with StateMixin {

  var giacienze = [].obs;

  @override
  void onInit() {
    super.onInit();
    leggiStatistiche();
  }


  Future leggiStatistiche() async {
    change([], status: RxStatus.loading());

    var tmp = await Get.find<APIHelper>().dammiGiacienzeRettificate();

    if (tmp.runtimeType.toString() == 'List<dynamic>' || tmp.runtimeType.toString() == '_GrowableList<dynamic>') {
      giacienze.value = tmp;
    }

    (giacienze.isNotEmpty)
    ? change([], status: RxStatus.success())
    : change([], status: RxStatus.empty());

  }
}