// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';


class AppbarBackButton extends StatelessWidget {
  const AppbarBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/defaultIcons/freccia_indietro.png',
        scale: 2,
      ),

      onPressed: () => Get.back(),
    );
  }
}
