part of 'get_order_info_bloc.dart';

@immutable
abstract class GetOrderInfoState {}

class GetOrderInfoInitial extends GetOrderInfoState {}

class GetOrderInfoLoading extends GetOrderInfoState {}

class GetOrderInfoLoaded extends GetOrderInfoState {
  final List<OrderModel> order;
  final OrderModel? selectedOrder;

  GetOrderInfoLoaded({required this.order, this.selectedOrder});

  GetOrderInfoLoaded copyWith(
      {List<OrderModel>? order, OrderModel? selectedOrder}) {
    return GetOrderInfoLoaded(
        order: order ?? this.order,
        selectedOrder: selectedOrder ?? this.selectedOrder);
  }

  int selectedCount() {
    return order.where((i) => i.isActive == true).length;
  }
}

class GetOrderInfoFailed extends GetOrderInfoState {}
