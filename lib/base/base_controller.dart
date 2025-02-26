import 'package:get/get.dart';
import 'package:rcs_portal_eaze/base/api_service.dart';
import 'package:rcs_portal_eaze/base/sql_service.dart';

class PortalEazeBaseController extends GetxController {
  final PortalEazeApiService service = Get.find();
  final PortalEazeSqlService sqlService = Get.find();

  void showSnackbar({required String title, required String body}) {
    Get.snackbar(title, body);
  }
}
