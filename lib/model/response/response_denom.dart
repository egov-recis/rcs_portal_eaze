class DenomResponse {
  List<Denom>? denom;
  int? total;
  int? perPage;
  int? currentPage;
  String? nextPageUrl;
  String? previousPageUrl;

  DenomResponse(
      {this.denom,
      this.total,
      this.perPage,
      this.currentPage,
      this.nextPageUrl,
      this.previousPageUrl});

  DenomResponse.fromJson(Map<String, dynamic> json) {
    if (json['denom'] != null) {
      denom = <Denom>[];
      json['denom'].forEach((v) {
        denom!.add(Denom.fromJson(v));
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
    if (denom != null) {
      data['denom'] = denom!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    data['per_page'] = perPage;
    data['current_page'] = currentPage;
    data['next_page_url'] = nextPageUrl;
    data['previous_page_url'] = previousPageUrl;
    return data;
  }
}

class Denom {
  String? id;
  String? idPaymentType;
  String? code;
  int? amount;
  int? admin;
  int? total;
  String? label;
  String? prefix;

  Denom(
      {this.id,
      this.idPaymentType,
      this.code,
      this.amount,
      this.admin,
      this.total,
      this.label,
      this.prefix});

  Denom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idPaymentType = json['id_payment_type'];
    code = json['code'];
    amount = json['amount'];
    admin = json['admin'];
    total = json['total'];
    label = json['label'];
    prefix = json['prefix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['id_payment_type'] = idPaymentType;
    data['code'] = code;
    data['amount'] = amount;
    data['admin'] = admin;
    data['total'] = total;
    data['label'] = label;
    data['prefix'] = prefix;
    return data;
  }
}
