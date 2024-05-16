part of 'create_order_bloc.dart';

@immutable
abstract class CreateOrderBlocState {}

class CreateOrderBlocInitial extends CreateOrderBlocState {}

class OrderCreating extends CreateOrderBlocState {}

class OrderCreatingSuccessful extends CreateOrderBlocState {}

class OrderCreatingFailed extends CreateOrderBlocState {}
