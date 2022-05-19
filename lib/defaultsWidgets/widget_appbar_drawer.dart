// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:badges/badges.dart';

// Project imports:
import '../controllers/elenco_controller/elenco_controller.dart';


class AppBarDrawer extends StatelessWidget {
  const AppBarDrawer({Key? key, required this.controller}) : super(key: key);

  final ElencoController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => IconButton(
              icon: (controller.numeroNotifiche > 0) ? Badge(
                badgeColor: Get.theme.highlightColor,
                shape: BadgeShape.circle,
                toAnimate: true,

                borderRadius: BorderRadius.circular(20.0),

                badgeContent: Text(
                  controller.numeroNotifiche.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),

                child: Image.asset(

                  'assets/defaultIcons/hamburger_menu.png',
                  scale: 2,
                ),

              ) : Image.asset(
                'assets/defaultIcons/hamburger_menu.png',
                scale: 2,
              ),

              onPressed: () {
                controller.scaffoldKey.currentState!.openDrawer();
              }
          ),
    );
  }
}

/// TODO
// Widget drawerAppBar(ElencoController controller) {
//   return Obx(
//       () => IconButton(
//         icon: (controller.numeroNotifiche > 0) ? Badge(
//           badgeColor: Get.theme.highlightColor,
//           shape: BadgeShape.circle,
//           toAnimate: true,
//
//           borderRadius: BorderRadius.circular(20.0),
//
//           badgeContent: Text(
//             controller.numeroNotifiche.toString(),
//             style: const TextStyle(
//               color: Colors.white,
//             ),
//           ),
//
//           child: Image.asset(
//
//             'assets/defaultIcons/hamburger_menu.png',
//             scale: 2,
//           ),
//
//         ) : Image.asset(
//           'assets/defaultIcons/hamburger_menu.png',
//           scale: 2,
//         ),
//
//         onPressed: () {
//           controller.scaffoldKey.currentState!.openDrawer();
//         }
//       ),
//   );
// }