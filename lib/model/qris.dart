class Qris {
  String? qris;
  String? customerName;
  String? paymentType;
  String? idBilling;
  String? datetimeExpired;
  String? clientRefnum;
  String? trxAmount;

  Qris(
      {this.qris,
      this.customerName,
      this.paymentType,
      this.idBilling,
      this.datetimeExpired,
      this.clientRefnum,
      this.trxAmount});

  Qris.fromJson(Map<String, dynamic> json) {
    qris = json['qris'];
    customerName = json['customer_name'];
    paymentType = json['payment_type'];
    idBilling = json['id_billing'];
    datetimeExpired = json['datetime_expired'];
    clientRefnum = json['client_refnum'];
    trxAmount = json['trx_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qris'] = qris;
    data['customer_name'] = customerName;
    data['payment_type'] = paymentType;
    data['id_billing'] = idBilling;
    data['datetime_expired'] = datetimeExpired;
    data['client_refnum'] = clientRefnum;
    data['trx_amount'] = trxAmount;
    return data;
  }
}
