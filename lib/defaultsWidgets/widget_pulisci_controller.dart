// Flutter imports:
import 'package:flutter/material.dart';


class IconaPulisciController extends StatelessWidget {
  const IconaPulisciController({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'assets/defaultIcons/cestino.png',
        color: Colors.red.shade800,
        scale: 1.2,
      ),

      onPressed: () => controller.clear(),
    );
  }

}

// TODO
// Widget iconaPulisciController({required TextEditingController controller}) => IconButton(
//   icon: Image.asset(
//     'assets/defaultIcons/cestino.png',
//     color: Colors.red.shade800,
//     scale: 1.2,
//   ),
//
//   onPressed: () => controller.clear(),
// );