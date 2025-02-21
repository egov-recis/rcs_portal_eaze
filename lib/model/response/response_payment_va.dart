import '../virtual_account.dart';

class ResponsePaymentVirtualAccount {
  String? timestamp;
  int? code;
  String? status;
  String? message;
  VirtualAccount? data;

  ResponsePaymentVirtualAccount(
      {this.timestamp, this.code, this.status, this.message, this.data});

  ResponsePaymentVirtualAccount.fromJson(Map<String, dynamic> json) {
    timestamp = json['timestamp'];
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? VirtualAccount.fromJson(json['data']) : null;
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
