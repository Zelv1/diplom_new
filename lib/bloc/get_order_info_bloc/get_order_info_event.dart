part of 'get_order_info_bloc.dart';

@immutable
abstract class GetOrderInfoEvent {}

class GetOrdersEvent extends GetOrderInfoEvent {
  GetOrdersEvent();
}

class GetHistoryEvent extends GetOrderInfoEvent {
  GetHistoryEvent();
}

class DeleteSelectedOrdersEvent extends GetOrderInfoEvent {}

class SelectOrderEvent extends GetOrderInfoEvent {
  final int orderIndex;
  SelectOrderEvent({required this.orderIndex});
}
