import '../courier_model/courier_model.dart';
import '../vendor_model/vendor_model.dart';

class OrderModel {
  final bool isActive;
  final int id;
  CourierModel? iDCourier;
  VendorModel? iDVendor;
  final String date;
  final String address;
  final DateTime deliverTo;
  final String payment;
  final String state;
  final String phoneNumber;
  final String goodType;
  String? review;
  String? qrCode;

  OrderModel(
      {this.isActive = false,
      required this.id,
      this.iDCourier,
      this.iDVendor,
      required this.date,
      required this.address,
      required this.deliverTo,
      required this.payment,
      required this.state,
      required this.phoneNumber,
      required this.goodType,
      this.review,
      this.qrCode});

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        date = json['date'],
        address = json['address'],
        deliverTo = DateTime.parse(json['deliverTo']),
        payment = json['payment'],
        state = json['state'],
        phoneNumber = json['phoneNumber'],
        goodType = json['goodType'],
        isActive = false {
    iDCourier = json['IDCourier'] != null
        ? CourierModel.fromJson(json['IDCourier'])
        : null;
    iDVendor = json['IDVendor'] != null
        ? VendorModel.fromJson(json['IDVendor'])
        : null;
    review = json['review'];
    qrCode = json['qr_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (iDCourier != null) {
      data['IDCourier'] = iDCourier!.toJson();
    }
    if (iDVendor != null) {
      data['IDVendor'] = iDVendor!.toJson();
    }
    data['date'] = date;
    data['address'] = address;
    data['deliverTo'] = deliverTo;
    data['payment'] = payment;
    data['state'] = state;
    data['phoneNumber'] = phoneNumber;
    data['goodType'] = goodType;
    data['review'] = review;
    data['qr_code'] = qrCode;
    return data;
  }

  OrderModel copyWith(
      {bool? isActive,
      int? id,
      CourierModel? iDCourier,
      VendorModel? iDVendor,
      String? date,
      String? address,
      DateTime? deliverTo,
      String? payment,
      String? state,
      String? phoneNumber,
      String? goodType,
      String? review,
      String? qrCode}) {
    return OrderModel(
      address: address ?? this.address,
      id: id ?? this.id,
      iDCourier: iDCourier ?? this.iDCourier,
      iDVendor: iDVendor ?? this.iDVendor,
      date: date ?? this.date,
      deliverTo: deliverTo ?? this.deliverTo,
      payment: payment ?? this.payment,
      state: state ?? this.state,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      goodType: goodType ?? this.goodType,
      review: review ?? this.review,
      isActive: isActive ?? this.isActive,
      qrCode: qrCode ?? this.qrCode,
    );
  }
}
