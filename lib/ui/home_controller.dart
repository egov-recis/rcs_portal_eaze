import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rcs_portal_eaze/base/api_service.dart';
import 'package:rcs_portal_eaze/base/preferences.dart';
import 'package:rcs_portal_eaze/model/news.dart';
import 'package:rcs_portal_eaze/model/payment_group.dart';
import 'package:rcs_portal_eaze/model/payment_type.dart';
import 'package:rcs_portal_eaze/model/qris.dart';
import 'package:rcs_portal_eaze/model/response/response_payment_history.dart';
import 'package:rcs_portal_eaze/model/transaction.dart';
import 'package:rcs_portal_eaze/model/virtual_account.dart';

class PortalEazeHomeController extends GetxController {
  var service = Get.find<PortalEazeApiService>();

  RxBool loadingNews = false.obs;
  RxBool loadingPaymentType = false.obs;
  RxBool loadingPaymentGroup = false.obs;
  List<News> listNews = <News>[];
  List<PaymentType> listPaymentType = [];
  RxList<Transaction> listTracking = <Transaction>[].obs;

  RxBool loadingPaymentCategory = false.obs;
  // RxBool loadingPaymentType = false.obs;
  RxBool isLoading = false.obs;
  RxBool isVA = true.obs;
  RxBool isWebPaid = false.obs;
  RxBool isWebQR = false.obs;
  RxBool isCreatedPayment = false.obs;
  RxBool isQris = false.obs;
  RxBool isPayment = true.obs;
  RxBool isDoneTracking = false.obs;

  VirtualAccount va = VirtualAccount();
  Qris qris = Qris();

  RxInt totalCategory = 0.obs;
  RxString paymentType = "".obs;
  RxString paymentTypeSpec = "".obs;
  final lastUpdateHistory = Rx('-');

  // final localCaptchaController = LocalCaptchaController();
  // final configFormData = ConfigFormData();

  final trxAmountController = TextEditingController();
  final idBillingController = TextEditingController();
  final idBillingTrackingController = TextEditingController();
  final paymentCategoryController = TextEditingController();
  final paymentTypeController = TextEditingController();
  final tfCaptchaController = TextEditingController();

  // RxList listPaymentType = [].obs;
  RxList listPaymentCategory = [].obs;
  RxList<ItemPaymentGroup> listPaymentGroup = <ItemPaymentGroup>[].obs;
  RxList<ItemPaymentGroup> listPaymentGroupFilter = <ItemPaymentGroup>[].obs;
  RxList<PaymentHistory> listHistory = <PaymentHistory>[].obs;
  // List<DropDownValueModel> listPaymentTypeDropdown = [];
  // List<DropDownValueModel> listPaymentCategoryDropdown = [];

  String paymentTypeCode = "";
  String paymentTypeTemp = "";
  String paymentTypeCodeTemp = "";
  String paymentCategoryCode = "";

  @override
  void onInit() {
    // service.login().then((value) {
    //   getPaymentGroup();
    // });
    super.onInit();
  }

  getHistory() async {
    // await service.cancelRequest();
    var partnerId = await Preferences().getUdid();
    listHistory.clear();
    var result = await service.getHistory(partnerId, limit: '3');
    if (result.code == 200) {
      lastUpdateHistory.value = result.timestamp ?? '-';
      listHistory.addAll(result.data?.paymentHistory ?? []);
    }
  }

  void getPaymentType() async {
    loadingPaymentType.value = true;
    var result = await service.getPaymentType();
    if (result.code == 200) {
      listPaymentType.clear();
      for (var element in result.data!.paymentType!) {
        listPaymentType.add(element);
      }
    }
    loadingPaymentType.value = false;
    getHistory();
  }

  void getNews() async {
    loadingNews.value = true;
    var result = await service.getNews();
    if (result.code == 200) {
      listNews.clear();
      for (var element in result.data!.news!) {
        listNews.add(element);
      }
    }
    loadingNews.value = false;
    getPaymentType();
  }

  void getPaymentGroup() async {
    loadingPaymentGroup.value = true;
    var result = await service.paymentGroup();
    print('payment_group: ${result.code}');
    if (result.code == 200) {
      listPaymentGroup.clear();
      listPaymentGroupFilter.clear();
      for (var element in result.data?.paymentGroup ?? <ItemPaymentGroup>[]) {
        listPaymentGroup.add(element);
      }
      listPaymentGroupFilter.addAll(listPaymentGroup);
    }
    loadingPaymentGroup.value = false;
    getNews();
  }

  void changePaymentGroupFilter(String search) {
    if (search.isNotEmpty) {
      listPaymentGroupFilter.clear();
      for (var element in listPaymentGroup) {
        if ((element.name ?? "").toLowerCase().contains(search.toLowerCase())) {
          listPaymentGroupFilter.add(element);
        }
      }
    } else {
      resetPaymentGroupFilter();
    }
  }

  void resetPaymentGroupFilter() {
    listPaymentGroupFilter.clear();
    listPaymentGroupFilter.addAll(listPaymentGroup);
  }
}
