import '../payment_category.dart';

class ResponsePaymentCategory {
  String? timestamp;
  int? code;
  String? status;
  String? message;
  ResPaymentCategory? data;

  ResponsePaymentCategory(
      {this.timestamp, this.code, this.status, this.message, this.data});

  ResponsePaymentCategory.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data =
        json['data'] != null ? ResPaymentCategory.fromJson(json['data']) : null;
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

class ResPaymentCategory {
  List<PaymentCategory>? paymentCategory;
  int? total;
  int? perPage;
  int? currentPage;
  dynamic nextPageUrl;
  dynamic previousPageUrl;

  ResPaymentCategory(
      {this.paymentCategory,
      this.total,
      this.perPage,
      this.currentPage,
      this.nextPageUrl,
      this.previousPageUrl});

  ResPaymentCategory.fromJson(Map<String, dynamic> json) {
    if (json['payment_category'] != null) {
      paymentCategory = <PaymentCategory>[];
      json['payment_category'].forEach((v) {
        paymentCategory!.add(PaymentCategory.fromJson(v));
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
    if (paymentCategory != null) {
      data['payment_category'] =
          paymentCategory!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['next_page_url'] = nextPageUrl;
    data['previous_page_url'] = previousPageUrl;
    return data;
  }
}
