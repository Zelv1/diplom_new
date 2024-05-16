part of 'create_order_bloc.dart';

@immutable
abstract class CreateOrderBlocEvent {}

class CreateOrderEvent extends CreateOrderBlocEvent {
  final String address;
  final String phoneNumber;
  final String payment;
  final String goodType;
  final String review;
  CreateOrderEvent(
    this.address,
    this.payment,
    this.phoneNumber,
    this.goodType,
    this.review,
  );
}
