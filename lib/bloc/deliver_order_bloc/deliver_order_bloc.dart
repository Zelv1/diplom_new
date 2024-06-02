import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';

import 'package:diplom_new/features/models/order_model/order_model.dart';
import 'package:diplom_new/features/repository/change_status_order_repository/change_status_order_claim_repository.dart';
import 'package:diplom_new/features/repository/change_status_order_repository/change_status_order_finish_repository.dart';
import 'package:diplom_new/features/repository/get_courier_personal_order_repository/get_courier_personal_order_repository.dart';
import 'package:diplom_new/features/repository/get_order_data_single_repository/get_order_data_single_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'deliver_order_event.dart';
part 'deliver_order_state.dart';

class DeliverOrderBloc extends Bloc<DeliverOrderEvent, DeliverOrderState> {
  String? _token;
  String? courierId;
  DeliverOrderBloc() : super(WaitProcessOrderState()) {
    on<GetDataFromQREvent>(
      (event, emit) async {
        try {
          if (_token != null) {
            final getSingleOrder =
                GetOrderDataRepository(_token!, event.orderId);
            final orderr = await getSingleOrder.getOrderDataSingle();
            final repository = ChangeStatusOrderClaim(_token!, event.orderId);
            if (orderr.state == '1') {
              await repository.changeStatusOrderClaim();
              emit(ProcessOrderState(order: orderr));
            } else {
              emit(OrderHasAlreadyDeliveredState());
              await Future.delayed(const Duration(seconds: 1));
              emit(WaitProcessOrderState());
            }
          }
        } catch (e) {
          log(e.toString());
        }
      },
    );
    on<UpdateOrderStatusEvent>((event, emit) async {
      try {
        if (_token != null && courierId != null) {
          final repository =
              GetCourierPersonalOrderRepository(_token!, courierId!);
          final orders = await repository.getPersonalOrderCourier();
          emit(ProcessOrderState(order: orders.first));
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<ClaimOrderEvent>((event, emit) async {
      try {
        if (_token != null) {
          final repository =
              ChangeStatusOrderClaim(_token!, event.order.id.toString());
          final getSingleOrder =
              GetOrderDataRepository(_token!, event.order.id.toString());
          final order = await getSingleOrder.getOrderDataSingle();
          await repository.changeStatusOrderClaim();
          emit(ProcessOrderState(order: order));
        }
      } catch (e) {
        log(e.toString());
      }
    });

    on<FinishOrderEvent>(((event, emit) async {
      try {
        if (_token != null) {
          final repository = ChangeStatusOrderFinish(_token!, event.orderId);
          await repository.changeStatusOrderFinish();
          emit(WaitProcessOrderState());
        }
      } catch (e) {
        log(e.toString());
      }
    }));

    AuthMiddleware.authData.listen((event) {
      _token = event.toString();
    });

    AuthMiddleware.user.listen((event) {
      courierId = event.courier?.id.toString();
    });
  }
}
