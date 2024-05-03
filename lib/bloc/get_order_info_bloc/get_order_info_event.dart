part of 'get_order_info_bloc.dart';

@immutable
abstract class GetOrderInfoEvent {}

class GetCourierOrderEvent extends GetOrderInfoEvent {
  GetCourierOrderEvent();
}

class GetVendorOrderEvent extends GetOrderInfoEvent {
  final int vendorId;
  GetVendorOrderEvent({required this.vendorId});
}

class GetVendorHistoryEvent extends GetOrderInfoEvent {
  final int vendorId;
  GetVendorHistoryEvent({required this.vendorId});
}

class GetCourierHistoryEvent extends GetOrderInfoEvent {
  final int courierId;
  GetCourierHistoryEvent({required this.courierId});
}

class CreateOrderSuccessEvent extends GetOrderInfoEvent {}

class CreateOrderEvent extends GetOrderInfoEvent {
  final String vendor;
  final String address;
  final String phoneNumber;
  final String payment;
  final String goodType;
  final String review;
  CreateOrderEvent(
    this.vendor,
    this.address,
    this.payment,
    this.phoneNumber,
    this.goodType,
    this.review,
  );
}
