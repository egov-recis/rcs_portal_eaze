class PaymentGroup {
  List<ItemPaymentGroup>? paymentGroup;

  PaymentGroup({this.paymentGroup});

  PaymentGroup.fromJson(Map<String, dynamic> json) {
    if (json['paymentGroup'] != null) {
      paymentGroup = <ItemPaymentGroup>[];
      json['paymentGroup'].forEach((v) {
        paymentGroup!.add(ItemPaymentGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentGroup != null) {
      data['paymentGroup'] = paymentGroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemPaymentGroup {
  String? id;
  String? name;
  String? icon;
  List<ItemPaymentTypeGroup>? paymentTypeGroup;

  ItemPaymentGroup({this.id, this.name, this.icon, this.paymentTypeGroup});

  ItemPaymentGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    if (json['paymentTypeGroup'] != null) {
      paymentTypeGroup = <ItemPaymentTypeGroup>[];
      json['paymentTypeGroup'].forEach((v) {
        paymentTypeGroup!.add(ItemPaymentTypeGroup.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['icon'] = icon;
    if (paymentTypeGroup != null) {
      data['paymentTypeGroup'] =
          paymentTypeGroup!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ItemPaymentTypeGroup {
  String? idPaymentType;
  String? name;

  ItemPaymentTypeGroup({this.idPaymentType, this.name});

  ItemPaymentTypeGroup.fromJson(Map<String, dynamic> json) {
    idPaymentType = json['id_payment_type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_payment_type'] = idPaymentType;
    data['name'] = name;
    return data;
  }
}
