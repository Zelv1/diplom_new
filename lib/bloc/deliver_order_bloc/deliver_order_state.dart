part of 'deliver_order_bloc.dart';

@immutable
abstract class DeliverOrderState {}

class DeliverOrderBlocInitial extends DeliverOrderState {}

class ProcessOrderState extends DeliverOrderState {
  final OrderModel order;
  ProcessOrderState({required this.order});

  ProcessOrderState copyWith(OrderModel? order) {
    return ProcessOrderState(order: order ?? this.order);
  }
}

class WaitProcessOrderState extends DeliverOrderState {}

class OrderHasAlreadyDeliveredState extends DeliverOrderState {}
