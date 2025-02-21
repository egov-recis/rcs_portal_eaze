class VirtualAccount {
  String? virtualAccount;
  String? customerName;
  String? datetimeExpired;
  String? paymentType;
  dynamic trxAmount;
  dynamic amount;
  dynamic penalty;
  dynamic admin;
  String? idBilling;
  String? description;
  String? clientRefnum;
  List<AdditionalData>? additionalData;

  VirtualAccount(
      {this.virtualAccount,
      this.customerName,
      this.datetimeExpired,
      this.paymentType,
      this.trxAmount,
      this.amount,
      this.penalty,
      this.admin,
      this.idBilling,
      this.description,
      this.clientRefnum,
      this.additionalData});

  VirtualAccount.fromJson(Map<String, dynamic> json) {
    virtualAccount = json['virtual_account'];
    customerName = json['customer_name'];
    datetimeExpired = json['datetime_expired'];
    paymentType = json['payment_type'];
    trxAmount = json['trx_amount'];
    amount = json['amount'];
    penalty = json['penalty'];
    admin = json['admin'];
    idBilling = json['id_billing'];
    description = json['description'];
    clientRefnum = json['client_refnum'];
    if (json['additional_data'] != null) {
      additionalData = <AdditionalData>[];
      json['additional_data'].forEach((v) {
        additionalData!.add(AdditionalData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['virtual_account'] = virtualAccount;
    data['customer_name'] = customerName;
    data['datetime_expired'] = datetimeExpired;
    data['payment_type'] = paymentType;
    data['trx_amount'] = trxAmount;
    data['amount'] = amount;
    data['penalty'] = penalty;
    data['admin'] = admin;
    data['id_billing'] = idBilling;
    data['description'] = description;
    data['client_refnum'] = clientRefnum;
    if (additionalData != null) {
      data['additional_data'] = additionalData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AdditionalData {
  String? label;
  String? value;

  AdditionalData({this.label, this.value});

  AdditionalData.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['value'] = value;
    return data;
  }
}
