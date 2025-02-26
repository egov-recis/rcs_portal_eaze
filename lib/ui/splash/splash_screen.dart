import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/base/dependencies.dart';
import 'package:rcs_portal_eaze/common/text.dart';
import 'package:rcs_portal_eaze/ui/home/home_screen.dart';

class PortalEazeSplashScreen extends StatelessWidget {
  final String uniqueCode;
  const PortalEazeSplashScreen({super.key, required this.uniqueCode});

  @override
  Widget build(BuildContext context) {
    Dependencies().initialize();
    Timer(const Duration(seconds: 2), () async {
      Get.to(() => PortalEazeHomeScreen(uniqueCode: uniqueCode));
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
