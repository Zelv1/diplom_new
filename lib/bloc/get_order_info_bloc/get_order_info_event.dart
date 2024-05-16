part of 'get_order_info_bloc.dart';

@immutable
abstract class GetOrderInfoEvent {}

class GetOrdersEvent extends GetOrderInfoEvent {
  GetOrdersEvent();
}

class GetHistoryEvent extends GetOrderInfoEvent {
  GetHistoryEvent();
}

class DeleteOrderEvent extends GetOrderInfoEvent {
  final int orderIndex;
  DeleteOrderEvent({required this.orderIndex});
}
