// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'widgets/widget_mostra_news.dart';
import '../../controllers/rss_controller/rss_controller.dart';
import '../../defaultsWidgets/widget_in_caricamento.dart';


class RSS extends GetView<RSSController> {
  const RSS({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RSSController());

    return controller.obx(
          (state) => MostraNews(controller: controller),

      onLoading: const WidgetInCaricamento(),
      onEmpty: const Text('Nessuna notizia da mostrare'),
    );
  }
}