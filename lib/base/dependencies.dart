import 'package:flutter_udid/flutter_udid.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/base/api_service.dart';
import 'package:rcs_portal_eaze/base/preferences.dart';
import 'package:rcs_portal_eaze/ui/home/home_controller.dart';

class Dependencies {
  void initialize() async {
    Get.lazyPut(() => PortalEazeApiService());
    Get.lazyPut(() => PortalEazeHomeController());
    var deviceId = await Preferences().getUdid();
    if (deviceId.isEmpty) {
      String udid = await FlutterUdid.udid;
      Preferences().saveUdid(udid);
    }
  }
}
