class PaymentHistoryResponse {
  List<PaymentHistory>? paymentHistory;
  int? total;
  dynamic perPage;
  int? currentPage;
  String? nextPageUrl;
  String? previousPageUrl;

  PaymentHistoryResponse(
      {this.paymentHistory,
      this.total,
      this.perPage,
      this.currentPage,
      this.nextPageUrl,
      this.previousPageUrl});

  PaymentHistoryResponse.fromJson(Map<String, dynamic> json) {
    if (json['payment_history'] != null) {
      paymentHistory = <PaymentHistory>[];
      json['payment_history'].forEach((v) {
        paymentHistory!.add(PaymentHistory.fromJson(v));
      });
    }
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    nextPageUrl = json['next_page_url'];
    previousPageUrl = json['previous_page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentHistory != null) {
      data['payment_history'] = paymentHistory!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['next_page_url'] = nextPageUrl;
    data['previous_page_url'] = previousPageUrl;
    return data;
  }
}

class PaymentHistory {
  String? id;
  String? idBilling;
  dynamic billingData;
  String? generatedDate;
  String? paymentDate;
  String? flag;
  dynamic amount;
  dynamic adminFee;
  dynamic total;
  String? settleBank;
  String? idPaymentType;
  String? idCategory;
  String? idMethod;
  String? paymentTypeName;
  String? paymentCategoryName;
  String? paymentMethodName;
  String? paymentTypeCode;
  String? clientRefnum;
  String? expiredDate;
  String? detailResponse;
  String? detailResponsePayment;
  dynamic penalty;
  String? swRefnum;

  PaymentHistory(
      {this.id,
      this.idBilling,
      this.billingData,
      this.generatedDate,
      this.paymentDate,
      this.flag,
      this.amount,
      this.adminFee,
      this.total,
      this.settleBank,
      this.idPaymentType,
      this.idCategory,
      this.idMethod,
      this.paymentTypeName,
      this.paymentCategoryName,
      this.paymentMethodName,
      this.paymentTypeCode,
      this.clientRefnum,
      this.expiredDate,
      this.detailResponse,
      this.detailResponsePayment,
      this.penalty,
      this.swRefnum});

  PaymentHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idBilling = json['id_billing'];
    billingData = json['billing_data'];
    generatedDate = json['generated_date'];
    paymentDate = json['payment_date'];
    flag = json['flag'];
    amount = json['amount'];
    adminFee = json['admin_fee'];
    total = json['total'];
    settleBank = json['settle_bank'];
    idPaymentType = json['id_payment_type'];
    idCategory = json['id_category'];
    idMethod = json['id_method'];
    paymentTypeName = json['payment_type_name'];
    paymentCategoryName = json['payment_category_name'];
    paymentMethodName = json['payment_method_name'];
    paymentTypeCode = json['payment_type_code'];
    clientRefnum = json['client_refnum'];
    expiredDate = json['expired_date'];
    detailResponse = json['detail_response'];
    detailResponsePayment = json['detail_response_payment'];
    penalty = json['penalty'];
    swRefnum = json['sw_refnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_billing'] = idBilling;
    data['billing_data'] = billingData;
    data['generated_date'] = generatedDate;
    data['payment_date'] = paymentDate;
    data['flag'] = flag;
    data['amount'] = amount;
    data['admin_fee'] = adminFee;
    data['total'] = total;
    data['settle_bank'] = settleBank;
    data['id_payment_type'] = idPaymentType;
    data['id_category'] = idCategory;
    data['id_method'] = idMethod;
    data['payment_type_name'] = paymentTypeName;
    data['payment_category_name'] = paymentCategoryName;
    data['payment_method_name'] = paymentMethodName;
    data['payment_type_code'] = paymentTypeCode;
    data['client_refnum'] = clientRefnum;
    data['expired_date'] = expiredDate;
    data['detail_response'] = detailResponse;
    data['detail_response_payment'] = detailResponsePayment;
    data['penalty'] = penalty;
    data['sw_refnum'] = swRefnum;
    return data;
  }
}
