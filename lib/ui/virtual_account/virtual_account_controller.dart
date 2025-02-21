import 'package:firebase_database/firebase_database.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/base/api_service.dart';
import 'package:rcs_portal_eaze/model/request/postdata.dart';
import 'package:rcs_portal_eaze/model/tracking.dart';
import 'package:rcs_portal_eaze/model/virtual_account.dart';
import 'package:rcs_portal_eaze/utils/util.dart';

class VirtualAccountController extends GetxController {
  var service = Get.find<ApiService>();
  String ref = "";
  String clientRef = "";
  RxString timer = "3600".obs;
  Tracking tracking = Tracking();
  VirtualAccount virtualAccount = VirtualAccount();
  final status = Rx(999);
  final loading = Rx(false);

  @override
  void onInit() {
    super.onInit();
    clientRef = Get.arguments;
    getTracking();
  }

  getTracking() async {
    PostData postData = PostData();
    postData.clientRefnum = clientRef;
    loading.value = true;
    // await service.cancelRequest();
    var result = await service.tracking(postData);
    tracking = result.data ?? Tracking();
    loading.value = false;
  }

  Query reference() {
    ref = "payment/";
    return RealtimeFirebase().reference(ref);
  }

  deleteRef() {
    RealtimeFirebase().removeRef(ref);
  }
}
