class PaymentTypeGroup {
  String? name;
  String? description;
  String? code;
  String? label;
  String? isManualInput;
  int? paymentSpecId;
  List<BankCategory>? bankCategory;

  PaymentTypeGroup(
      {this.name,
      this.description,
      this.code,
      this.label,
      this.isManualInput,
      this.paymentSpecId,
      this.bankCategory});

  PaymentTypeGroup.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    code = json['code'];
    label = json['label'];
    isManualInput = json['is_manual_input'];
    paymentSpecId = json['payment_spec_id'];
    if (json['bank_category'] != null) {
      bankCategory = <BankCategory>[];
      json['bank_category'].forEach((v) {
        bankCategory!.add(BankCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['code'] = code;
    data['label'] = label;
    data['is_manual_input'] = isManualInput;
    data['payment_spec_id'] = paymentSpecId;
    if (bankCategory != null) {
      data['bank_category'] = bankCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BankCategory {
  String? paymentTypeId;
  String? methodName;
  String? methodId;
  String? idCategory;
  String? code;
  String? name;
  String? description;
  String? paymentTypeName;

  BankCategory(
      {this.paymentTypeId,
      this.methodName,
      this.methodId,
      this.idCategory,
      this.code,
      this.name,
      this.description,
      this.paymentTypeName});

  BankCategory.fromJson(Map<String, dynamic> json) {
    paymentTypeId = json['payment_type_id'];
    methodName = json['method_name'];
    methodId = json['method_id'];
    idCategory = json['id_category'];
    code = json['code'];
    name = json['name'];
    description = json['description'];
    paymentTypeName = json['payment_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_type_id'] = paymentTypeId;
    data['method_name'] = methodName;
    data['method_id'] = methodId;
    data['id_category'] = idCategory;
    data['code'] = code;
    data['name'] = name;
    data['description'] = description;
    data['payment_type_name'] = paymentTypeName;
    return data;
  }
}
