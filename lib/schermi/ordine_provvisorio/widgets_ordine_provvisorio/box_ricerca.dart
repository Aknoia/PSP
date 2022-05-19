// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import '../../../controllers/ordine_provvisorio_controller/ordine_provvisorio_controller.dart';

class BoxRicerca extends StatelessWidget {
  const BoxRicerca({Key? key, required this.controller}) : super(key: key);

  final OrdineProvController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),

      child: TextField(
        controller: controller.ctrlRicerca,
        focusNode: controller.ctrlFocus,

        decoration: InputDecoration(
          hintText: 'Cerca in ordine provvisorio: ',
          labelText: 'Ordine Provvisorio',
          labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 1.0,
              color: Get.theme.selectedRowColor,
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              width: 1.0,
              color: Get.theme.selectedRowColor,
            ),
          ),
        ),

        onTap: () => controller.ctrlRicerca.clear(),

        onSubmitted: (valore) {
          if (controller.ctrlFocus.hasFocus) {
            controller.ctrlFocus.unfocus();
          }
        },
      ),
    );
  }
}
