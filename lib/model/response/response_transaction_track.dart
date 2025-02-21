class TransactionTrackResponse {
  List<PaymentTransaction>? paymentTransaction;
  int? total;
  String? perPage;
  int? currentPage;
  String? nextPageUrl;
  String? previousPageUrl;

  TransactionTrackResponse(
      {this.paymentTransaction,
      this.total,
      this.perPage,
      this.currentPage,
      this.nextPageUrl,
      this.previousPageUrl});

  TransactionTrackResponse.fromJson(Map<String, dynamic> json) {
    if (json['payment_transaction'] != null) {
      paymentTransaction = <PaymentTransaction>[];
      json['payment_transaction'].forEach((v) {
        paymentTransaction!.add(PaymentTransaction.fromJson(v));
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
    if (paymentTransaction != null) {
      data['payment_transaction'] =
          paymentTransaction!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['next_page_url'] = nextPageUrl;
    data['previous_page_url'] = previousPageUrl;
    return data;
  }
}

class PaymentTransaction {
  String? id;
  String? idBilling;
  int? billingData;
  String? paymentTypeCode;
  String? paymentTypeName;
  int? amount;
  String? flag;
  String? generatedDate;
  String? paymentDate;
  String? clientRefnum;
  int? adminFee;
  int? total;
  String? paymentMethodName;
  String? expiredDate;
  int? penalty;
  String? swRefnum;

  PaymentTransaction(
      {this.id,
      this.idBilling,
      this.billingData,
      this.paymentTypeCode,
      this.paymentTypeName,
      this.amount,
      this.flag,
      this.generatedDate,
      this.paymentDate,
      this.clientRefnum,
      this.adminFee,
      this.total,
      this.paymentMethodName,
      this.expiredDate,
      this.penalty,
      this.swRefnum});

  PaymentTransaction.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idBilling = json['id_billing'];
    billingData = json['billing_data'];
    paymentTypeCode = json['payment_type_code'];
    paymentTypeName = json['payment_type_name'];
    amount = json['amount'];
    flag = json['flag'];
    generatedDate = json['generated_date'];
    paymentDate = json['payment_date'];
    clientRefnum = json['client_refnum'];
    adminFee = json['admin_fee'];
    total = json['total'];
    paymentMethodName = json['payment_method_name'];
    expiredDate = json['expired_date'];
    penalty = json['penalty'];
    swRefnum = json['sw_refnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_billing'] = idBilling;
    data['billing_data'] = billingData;
    data['payment_type_code'] = paymentTypeCode;
    data['payment_type_name'] = paymentTypeName;
    data['amount'] = amount;
    data['flag'] = flag;
    data['generated_date'] = generatedDate;
    data['payment_date'] = paymentDate;
    data['client_refnum'] = clientRefnum;
    data['admin_fee'] = adminFee;
    data['total'] = total;
    data['payment_method_name'] = paymentMethodName;
    data['expired_date'] = expiredDate;
    data['penalty'] = penalty;
    data['sw_refnum'] = swRefnum;
    return data;
  }
}
