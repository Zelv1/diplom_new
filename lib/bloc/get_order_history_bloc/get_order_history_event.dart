// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_order_history_bloc.dart';

@immutable
abstract class GetOrderHistoryEvent {}

class GetHistoryEvent extends GetOrderHistoryEvent {
  GetHistoryEvent();
}

class UpdateSelectedOrder extends GetOrderHistoryEvent {
  final List<OrderModel> orders;
  UpdateSelectedOrder({
    required this.orders,
  });
}

class SelectOrderEvent extends GetOrderHistoryEvent {
  final int orderIndex;
  SelectOrderEvent({required this.orderIndex});
}
