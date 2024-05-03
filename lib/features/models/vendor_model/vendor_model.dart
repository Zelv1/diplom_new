class VendorModel {
  final int id;
  final String address;
  final String nameOfOrganization;
  final String phoneNumber;
  String? image;

  VendorModel(this.image,
      {required this.id,
      required this.address,
      required this.nameOfOrganization,
      required this.phoneNumber});

  VendorModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        address = json['address'],
        nameOfOrganization = json['nameOfOrganization'],
        phoneNumber = json['phoneNumber'] {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['address'] = address;
    data['nameOfOrganization'] = nameOfOrganization;
    data['phoneNumber'] = phoneNumber;
    data['image'] = image;
    return data;
  }
}
