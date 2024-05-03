class CourierModel {
  final int id;
  final String name;
  final int drivingExperience;
  final String number;
  String? image;

  CourierModel(this.image,
      {required this.id,
      required this.name,
      required this.drivingExperience,
      required this.number});

  CourierModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        drivingExperience = json['drivingExperience'],
        number = json['number'] {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['drivingExperience'] = drivingExperience;
    data['number'] = number;
    data['image'] = image;
    return data;
  }
}
