part of 'get_order_info_bloc.dart';

@immutable
abstract class GetOrderInfoState {}

class GetOrderInfoInitial extends GetOrderInfoState {}

class GetOrderInfoLoading extends GetOrderInfoState {}

class GetOrderInfoLoaded extends GetOrderInfoState {
  final List<OrderModel> order;
  GetOrderInfoLoaded({required this.order});
}

class CreateOrderSuccessState extends GetOrderInfoState {}

class GetOrderInfoFailed extends GetOrderInfoState {}
