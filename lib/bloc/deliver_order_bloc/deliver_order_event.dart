part of 'deliver_order_bloc.dart';

@immutable
abstract class DeliverOrderEvent {}

class UpdateOrderStatusEvent extends DeliverOrderEvent {}

class GetDataFromQREvent extends DeliverOrderEvent {
  final String orderId;

  GetDataFromQREvent({required this.orderId});
}

class ClaimOrderEvent extends DeliverOrderEvent {
  final OrderModel order;
  ClaimOrderEvent(this.order);
}

class FinishOrderEvent extends DeliverOrderEvent {
  final String orderId;
  FinishOrderEvent(this.orderId);
}
