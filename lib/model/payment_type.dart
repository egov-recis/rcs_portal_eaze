class PaymentTypes {
  List<PaymentType>? paymentType;

  PaymentTypes({this.paymentType});

  PaymentTypes.fromJson(Map<String, dynamic> json) {
    if (json['payment_type'] != null) {
      paymentType = <PaymentType>[];
      json['payment_type'].forEach((v) {
        paymentType!.add(PaymentType.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentType != null) {
      data['payment_type'] = paymentType!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaymentType {
  String? id;
  String? code;
  String? title;
  String? description;
  String? icon;
  String? isActive;
  String? isManualInput;
  String? idCategory;
  int? paymentSpecId;

  PaymentType(
      {this.id,
      this.code,
      this.title,
      this.description,
      this.icon,
      this.isActive,
      this.isManualInput,
      this.idCategory,
      this.paymentSpecId});

  PaymentType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    title = json['title'];
    description = json['description'];
    icon = json['icon'];
    isActive = json['is_active'];
    isManualInput = json['is_manual_input'];
    idCategory = json['id_category'];
    paymentSpecId = json['payment_spec_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['title'] = title;
    data['description'] = description;
    data['icon'] = icon;
    data['is_active'] = isActive;
    data['is_manual_input'] = isManualInput;
    data['id_category'] = idCategory;
    data['payment_spec_id'] = paymentSpecId;
    return data;
  }
}
