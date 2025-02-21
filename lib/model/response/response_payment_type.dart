import '../payment_type.dart';

class ResponsePaymentType {
  String? timestamp;
  int? code;
  String? status;
  String? message;
  ResPaymentType? data;

  ResponsePaymentType(
      {this.timestamp, this.code, this.status, this.message, this.data});

  ResponsePaymentType.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ResPaymentType.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['timestamp'] = timestamp;
    data['code'] = code;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ResPaymentType {
  List<PaymentType>? paymentType;
  int? total;
  String? perPage;
  int? currentPage;
  dynamic nextPageUrl;
  dynamic previousPageUrl;

  ResPaymentType(
      {this.paymentType,
      this.total,
      this.perPage,
      this.currentPage,
      this.nextPageUrl,
      this.previousPageUrl});

  ResPaymentType.fromJson(Map<String, dynamic> json) {
    if (json['payment_type'] != null) {
      paymentType = <PaymentType>[];
      json['payment_type'].forEach((v) {
        paymentType!.add(PaymentType.fromJson(v));
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
    if (paymentType != null) {
      data['payment_type'] = paymentType!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['next_page_url'] = nextPageUrl;
    data['previous_page_url'] = previousPageUrl;
    return data;
  }
}
