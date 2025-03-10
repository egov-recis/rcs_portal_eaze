import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/base/dependencies.dart';
import 'package:rcs_portal_eaze/common/text.dart';
import 'package:rcs_portal_eaze/ui/home/home_controller.dart';
import 'package:rcs_portal_eaze/ui/home/home_screen.dart';

class PortalEazeSplashScreen extends StatelessWidget {
  final String uniqueCode;
  final bool? linearMenu;
  const PortalEazeSplashScreen({
    super.key,
    required this.uniqueCode,
    this.linearMenu,
  });

  @override
  Widget build(BuildContext context) {
    Dependencies().initialize();
    var controller = Get.find<PortalEazeHomeController>();
    controller.service.platform().then((value) {
      controller.getPaymentGroup();
      controller.setPrimaryColor();
      Timer(const Duration(seconds: 2), () async {
        Get.off(
          () => PortalEazeHomeScreen(
            uniqueCode: uniqueCode,
            isLinearMenu: linearMenu,
          ),
        );
      });
    });
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://github.com/egov-recis/rcs_portal_eaze/blob/main/assets/images/eaze.png?raw=true",
              width: 200,
              errorBuilder: (context, error, stackTrace) => Container(),
            ),
            Text(
              "Selamat Datang",
              style: textH6(),
            )
          ],
        ),
      ),
    );
  }
}
