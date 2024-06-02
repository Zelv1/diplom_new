import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/features/repository/create_order_repository/create_order_repository.dart';
import 'package:meta/meta.dart';

part 'create_order_event.dart';
part 'create_order_state.dart';

class CreateOrderBloc extends Bloc<CreateOrderBlocEvent, CreateOrderBlocState> {
  String? _token;
  String? _vendorId;

  CreateOrderBloc() : super(CreateOrderBlocInitial()) {
    on<CreateOrderEvent>((event, emit) async {
      emit(OrderCreating());

      try {
        if (_token != null && _vendorId != null) {}
        final repository = CreateOrderRepository(
          token: _token!,
          _vendorId!,
          event.address,
          event.payment,
          event.phoneNumber,
          event.goodType,
          event.review,
        );
        await repository.createOrder(_token);

        emit(OrderCreatingSuccessful());
        if (state is OrderCreatingSuccessful) {
          emit(CreateOrderBlocInitial());
        }
      } catch (e) {
        log(e.toString());
        emit(OrderCreatingFailed());
      }
    });

    AuthMiddleware.authData.listen((event) {
      _token = event.toString();
    });

    AuthMiddleware.user.listen((event) {
      _vendorId = event.vendor?.id.toString();
    });
  }
}
