class ServiceModel {
  String? name;
  int? price;
  bool? isActive;
  int? id;

  ServiceModel({this.name, this.price, this.isActive, this.id});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    price = json['price'];
    isActive = json['is_active'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['price'] = price;
    data['is_active'] = isActive;
    data['id'] = id;
    return data;
  }
}
