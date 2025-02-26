import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/base/base_controller.dart';
import 'package:rcs_portal_eaze/model/request/postdata.dart';
import 'package:rcs_portal_eaze/model/response/response_transaction_track.dart';
import 'package:rcs_portal_eaze/model/transaction.dart';
import 'package:rcs_portal_eaze/ui/tracking/detail_tracking_screen.dart';
import 'package:rcs_portal_eaze/utils/util.dart';

class TrackingController extends PortalEazeBaseController {
  RxList<Transaction> data = <Transaction>[].obs;
  final loading = Rx(false);
  TextEditingController tfBillingController = TextEditingController();
  List<PaymentTransaction> listTransaction = [];
  RxList list = [].obs;

  @override
  void onInit() {
    getHistoryTracking();
    super.onInit();
  }

  deleteAllHistoryTracking() async {
    await sqlService.deleteAllHistoryTracking();
    getHistoryTracking();
  }

  deleteHistoryTracking(int id) async {
    await sqlService.deleteHistoryTracking(id);
    getHistoryTracking();
  }

  getHistoryTracking() async {
    var resultSql = await sqlService.getHistoryTracking();
    list.clear();
    list.addAll(resultSql);
    while (list.length > 3) {
      await sqlService.deleteHistoryTracking(resultSql.first['id']);
      list.removeAt(0);
    }
  }

  getTransactionTrack({String? billing}) async {
    if (tfBillingController.text.isEmpty && billing == null) {
      return sheetError(
        context: Get.context!,
        typeError: 400,
        msg: 'Billing harus diisi',
      );
    }
    PostData postData = PostData();
    postData.limit = '50';
    postData.page = '1';
    postData.billing = billing ?? tfBillingController.text;
    loading.value = true;
    // await service.cancelRequest();
    var result = await service.transactionTrack(postData);
    loading.value = false;
    if (result.code == 200) {
      await sqlService.createHistoryTracking(data: {
        'id_billing': billing ?? tfBillingController.text,
        'timestamp_second': DateTime.now().millisecondsSinceEpoch,
      });
      listTransaction.clear();
      listTransaction.addAll(result.data?.paymentTransaction ?? []);
      var track = await Get.to(() => DetailTrackingScreen(controller: this));
      if (track) {
        getHistoryTracking();
      }
    } else if ((result.code ?? 0) >= 400 && (result.code ?? 0) < 500) {
      sheetError(
        context: Get.context!,
        typeError: 400,
        msg: result.message,
      );
    } else {
      sheetError(
        context: Get.context!,
        typeError: 500,
        msg: result.message,
      );
    }
  }

  tracking() {
    Get.to(
      () => DetailTrackingScreen(
        controller: this,
      ),
    );
  }
}
