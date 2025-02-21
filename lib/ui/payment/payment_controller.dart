import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/base/api_service.dart';
import 'package:rcs_portal_eaze/base/preferences.dart';
import 'package:rcs_portal_eaze/model/payment_group.dart';
import 'package:rcs_portal_eaze/model/payment_type_group.dart';
import 'package:rcs_portal_eaze/model/response/response_denom.dart';
import 'package:rcs_portal_eaze/utils/util.dart';

class PaymentController extends GetxController {
  var service = Get.find<ApiService>();
  TextEditingController tfPaymentTypeController = TextEditingController();
  TextEditingController tfIdBillingController = TextEditingController();
  TextEditingController tfTotalController = TextEditingController();
  var data = ItemPaymentGroup();
  List<PaymentTypeGroup> listPaymentTypeGroup = [];
  List<Denom> listDenom = [];

  var selectedRecommend = Rx(999);
  var selectedPaymentTypeGroupIndex = Rx(999);
  var selectedPaymentMethodIndex = Rx(999);
  var selectedIndexPulse = Rx(999);

  final loading = Rx(false);
  final loadingPayment = Rx(false);
  final loadingDenom = Rx(false);

  final listRecommendation = [
    {"title": "5.000"},
    {"title": "10.000"},
    {"title": "15.000"},
    {"title": "20.000"},
    {"title": "25.000"},
  ];

  @override
  void onInit() {
    super.onInit();
    data = Get.arguments;
    getPaymentTypeGroup();
  }

  Future<void> getDenom() async {
    loadingDenom.value = true;
    listDenom.clear();
    // await service.cancelRequest();
    var result = await service.getDenom(
      listPaymentTypeGroup[selectedPaymentTypeGroupIndex.value].code ?? "",
    );
    loadingDenom.value = false;
    if (result.code == 200) {
      listDenom.addAll(result.data?.denom ?? []);
    } else {
      showSnackbar(title: "Informasi", body: result.message ?? "");
    }
  }

  Future<void> getPaymentTypeGroup() async {
    loading.value = true;
    listPaymentTypeGroup.clear();
    // await service.cancelRequest();
    var result = await service.getPaymentTypeGroup(data.id ?? "");
    loading.value = false;
    if (result.code == 200) {
      result.data?.forEach((element) {
        listPaymentTypeGroup.add(element);
      });
    } else {}
  }

  Future<String?> postPayment(BuildContext context) async {
    if (selectedPaymentTypeGroupIndex.value == 999) {
      showSnackbar(
        title: "Informasi",
        body: "Silakan Pilih Pembayaran.",
      );
      return null;
    } else if (tfIdBillingController.text == "") {
      showSnackbar(
        title: "Informasi",
        body:
            "Silakan Masukkan ${listPaymentTypeGroup[selectedPaymentTypeGroupIndex.value].label}",
      );
      return null;
    }
    PaymentTypeGroup data =
        listPaymentTypeGroup[selectedPaymentTypeGroupIndex.value];
    var total = 0;
    if (data.isManualInput == "1" || data.isManualInput == "2") {
      if (tfTotalController.text == "") {
        showSnackbar(
          title: "Informasi",
          body: "Silakan Masukkan Nominal.",
        );
        return null;
      } else {
        var totalText = "";
        var splits = tfTotalController.text.split('.');
        for (var split in splits) {
          totalText = "$totalText$split";
        }
        total = int.parse(totalText);
      }
    }
    if (selectedPaymentMethodIndex.value == 999) {
      showSnackbar(
        title: "Informasi",
        body: "Silakan Pilih Metode Pembayaran.",
      );
      return null;
    }

    loadingPayment.value = true;
    // await service.cancelRequest();
    var result = await service.payment({
      "id_billing": tfIdBillingController.text,
      "payment_type": data.code,
      "payment_method":
          data.bankCategory?[selectedPaymentMethodIndex.value].methodId,
      "trx_amount": total,
      "payment_category":
          data.bankCategory?[selectedPaymentMethodIndex.value].code,
      "platform_type": "MOBILE",
      'partner_id': await Preferences().getUdid(),
    });
    loadingPayment.value = false;
    if (result.code == 200) {
      // Get.to(() => VirtualAccountScreen(clientRefnum: result.data?.clientRefnum ?? ''), arguments:result.data?.clientRefnum );
      // Get.toNamed(
      //   Strings.virtualAccountRoute,
      //   arguments: result.data?.clientRefnum,
      // );
      return result.data?.clientRefnum;
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
    return null;
  }
}
