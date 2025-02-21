class Transaction {
  String? idBilling;
  String? billingData;
  String? paymentTypeCode;
  String? flag;
  String? generatedDate;
  String? paymentDate;
  String? clientRefnum;

  Transaction(
      {this.idBilling,
      this.billingData,
      this.paymentTypeCode,
      this.flag,
      this.generatedDate,
      this.paymentDate,
      this.clientRefnum});

  Transaction.fromJson(Map<String, dynamic> json) {
    idBilling = json['id_billing'];
    billingData = json['billing_data'];
    paymentTypeCode = json['payment_type_code'];
    flag = json['flag'];
    generatedDate = json['generated_date'];
    paymentDate = json['payment_date'];
    clientRefnum = json['client_refnum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_billing'] = idBilling;
    data['billing_data'] = billingData;
    data['payment_type_code'] = paymentTypeCode;
    data['flag'] = flag;
    data['generated_date'] = generatedDate;
    data['payment_date'] = paymentDate;
    data['client_refnum'] = clientRefnum;
    return data;
  }
}
