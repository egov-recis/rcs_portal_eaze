class PaymentCategory {
  String? id;
  String? title;
  String? description;

  PaymentCategory({this.id, this.title, this.description});

  PaymentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}
