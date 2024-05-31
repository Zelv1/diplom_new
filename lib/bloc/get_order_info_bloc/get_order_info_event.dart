// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_order_info_bloc.dart';

@immutable
abstract class GetOrderInfoEvent {}

class GetOrdersEvent extends GetOrderInfoEvent {
  GetOrdersEvent();
}

class DeleteSelectedOrdersEvent extends GetOrderInfoEvent {}

class UpdateSelectedOrder extends GetOrderInfoEvent {
  final List<OrderModel> orders;
  UpdateSelectedOrder({
    required this.orders,
  });
}
