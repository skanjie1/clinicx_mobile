class BranchModel {
  String? name;
  String? description;
  String? address;
  String? phoneNumber;
  double? longitude;
  double? latitude;
  int? id;

  BranchModel(
      {this.name,
      this.description,
      this.address,
      this.phoneNumber,
      this.longitude,
      this.latitude,
      this.id});

  BranchModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    address = json['address'];
    phoneNumber = json['phone_number'];
    longitude = double.parse(json['longitude'].toString());
    latitude = double.parse(json['latitude'].toString());
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['address'] = address;
    data['phone_number'] = phoneNumber;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    data['id'] = id;
    return data;
  }
}
