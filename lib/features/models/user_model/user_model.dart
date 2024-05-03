import 'package:diplom_new/features/models/courier_model/courier_model.dart';
import 'package:diplom_new/features/models/vendor_model/vendor_model.dart';

class UserModel {
  final int id;
  final String username;
  String? email;
  String? firstName;
  String? lastName;
  CourierModel? courier;
  VendorModel? vendor;

  UserModel(
      {required this.id,
      required this.username,
      this.email,
      this.firstName,
      this.lastName,
      this.courier,
      this.vendor});

  UserModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'] {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    courier =
        json['courier'] != null ? CourierModel.fromJson(json['courier']) : null;
    vendor =
        json['vendor'] != null ? VendorModel.fromJson(json['vendor']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    if (courier != null) {
      data['courier'] = courier!.toJson();
    }
    if (vendor != null) {
      data['vendor'] = vendor!.toJson();
    }
    return data;
  }
}
