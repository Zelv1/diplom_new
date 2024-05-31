part of 'get_order_history_bloc.dart';

@immutable
abstract class GetOrderHistoryState {}

class GetOrderHistoryInitial extends GetOrderHistoryState {}

class GetOrderHistoryLoading extends GetOrderHistoryState {}

class GetOrderHistoryLoaded extends GetOrderHistoryState {
  final List<OrderModel> order;
  final OrderModel? selectedOrder;

  GetOrderHistoryLoaded({required this.order, this.selectedOrder});

  GetOrderHistoryLoaded copyWith(
      {List<OrderModel>? order, OrderModel? selectedOrder}) {
    return GetOrderHistoryLoaded(
        order: order ?? this.order,
        selectedOrder: selectedOrder ?? this.selectedOrder);
  }

  int selectedCount() {
    return order.where((i) => i.isActive == true).length;
  }

  List<OrderModel> sortedOrders() {
    List<OrderModel> sortedorders = order;
    sortedorders.sort(
      (a, b) {
        return a.deliverTo.compareTo(b.deliverTo);
      },
    );
    return sortedorders
        .where((element) =>
            element.deliverTo.day == DateTime.now().day ||
            element.deliverTo.day == DateTime.now().day - 1)
        .toList()
        .reversed
        .toList();
  }
}

class GetOrderHistoryFailed extends GetOrderHistoryState {}
