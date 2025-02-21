class Tracking {
  String? qris;
  String? vaNumber;
  String? expiredDate;
  String? paymentType;
  dynamic trxAmount;
  dynamic amount;
  dynamic penalty;
  dynamic admin;
  String? idBilling;
  String? description;
  String? clientRefnum;
  dynamic additionalData;
  dynamic paymentDate;
  String? flag;
  String? countdownExpired;
  String? generatedDate;
  String? paymentTypeCode;
  String? paymentMethodCode;
  String? paymentMethodName;
  String? bankName;

  Tracking(
      {this.qris,
      this.vaNumber,
      this.expiredDate,
      this.paymentType,
      this.trxAmount,
      this.amount,
      this.penalty,
      this.admin,
      this.idBilling,
      this.description,
      this.clientRefnum,
      this.additionalData,
      this.paymentDate,
      this.flag,
      this.countdownExpired,
      this.generatedDate,
      this.paymentTypeCode,
      this.paymentMethodCode,
      this.paymentMethodName,
      this.bankName});

  Tracking.fromJson(Map<String, dynamic> json) {
    qris = json['qris'];
    vaNumber = json['va_number'];
    expiredDate = json['expired_date'];
    paymentType = json['payment_type'];
    trxAmount = json['trx_amount'];
    amount = json['amount'];
    penalty = json['penalty'];
    admin = json['admin'];
    idBilling = json['id_billing'];
    description = json['description'];
    clientRefnum = json['client_refnum'];
    additionalData = json['additional_data'];
    paymentDate = json['payment_date'];
    flag = json['flag'];
    countdownExpired = json['countdown_expired'];
    generatedDate = json['generated_date'];
    paymentTypeCode = json['payment_type_code'];
    paymentMethodCode = json['payment_method_code'];
    paymentMethodName = json['payment_method_name'];
    bankName = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qris'] = this.qris;
    data['va_number'] = this.vaNumber;
    data['expired_date'] = this.expiredDate;
    data['payment_type'] = this.paymentType;
    data['trx_amount'] = this.trxAmount;
    data['amount'] = this.amount;
    data['penalty'] = this.penalty;
    data['admin'] = this.admin;
    data['id_billing'] = this.idBilling;
    data['description'] = this.description;
    data['client_refnum'] = this.clientRefnum;
    data['additional_data'] = this.additionalData;
    data['payment_date'] = this.paymentDate;
    data['flag'] = this.flag;
    data['countdown_expired'] = this.countdownExpired;
    data['generated_date'] = this.generatedDate;
    data['payment_type_code'] = this.paymentTypeCode;
    data['payment_method_code'] = this.paymentMethodCode;
    data['payment_method_name'] = this.paymentMethodName;
    data['bank_name'] = this.bankName;
    return data;
  }
}
