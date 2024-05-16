import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/features/repository/get_order_data_courier_history_repository/get_order_data_courier_history_repository.dart';
import 'package:diplom_new/features/repository/get_order_data_vendor_history_repository/get_order_data_vendor_history_repository.dart';
import 'package:diplom_new/features/repository/get_order_data_vendor_repository/get_order_data_vendor_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import 'package:diplom_new/features/models/order_model/order_model.dart';

import 'package:diplom_new/features/repository/get_order_data_courier_repository/get_order_data_courier_repository.dart';

part 'get_order_info_event.dart';
part 'get_order_info_state.dart';

class GetOrderInfoBloc extends Bloc<GetOrderInfoEvent, GetOrderInfoState> {
  String? token;
  String? vendorId;
  String? courierId;

  GetOrderInfoBloc() : super(GetOrderInfoInitial()) {
    log('GET ORDER BLOC');
    log('+++++++++++++++ AUTh DATA +++++++++++++++');
    AuthMiddleware.authData.listen((event) {
      log('===== event=$event =====');
      token = event.toString();
    });
    log('+++++++++++++++ USER DATA +++++++++++++++');
    AuthMiddleware.user.listen((event) {
      log('===== event=$event =====');
      vendorId = event.vendor?.id.toString();
      courierId = event.courier?.id.toString();
    });

    on<GetOrdersEvent>((event, emit) async {
      emit(GetOrderInfoLoading());

      try {
        if (token != null && vendorId != null) {
          log("Должны отображаться заказы заказчика");
          final repository =
              GetOrderDataVendorRepository(token!, int.parse(vendorId!));
          final order = await repository.getOrderDataVendor();
          emit(GetOrderInfoLoaded(order: order));
        } else if (vendorId == null) {
          log("Должны отображаться заказы курьера");
          final repository = GetOrderDataCourierRepository(token!);
          final order = await repository.getOrderDataCourier();
          emit(GetOrderInfoLoaded(order: order));
        } else {
          emit(GetOrderInfoFailed());
        }
      } catch (e) {
        log(e.toString());
        emit(GetOrderInfoFailed());
      }
    });

    on<GetHistoryEvent>((event, emit) async {
      emit(GetOrderInfoLoading());
      try {
        if (token != null && vendorId != null) {
          final repository =
              GetOrderDataVendorHistoryRepository(token!, int.parse(vendorId!));
          final order = await repository.getOrderDataVendorHistory();
          emit(GetOrderInfoLoaded(order: order));
        } else if (courierId != null) {
          final repository = GetOrderDataCourierHistoryRepository(
              token!, int.parse(courierId!));
          final order = await repository.getOrderDataCourierHistory();
          emit(GetOrderInfoLoaded(order: order));
        } else {
          emit(GetOrderInfoFailed());
        }
      } catch (e) {
        log(e.toString());
        emit(GetOrderInfoFailed());
      }
    });

    on<DeleteOrderEvent>(
      (event, emit) async {
        if (state is GetOrderInfoLoaded) {
          final index = event.orderIndex;
          var orders = (state as GetOrderInfoLoaded).order;
          final selectedOrder = orders[index].copyWith(isActive: true);
          orders[index] = selectedOrder;
          emit((state as GetOrderInfoLoaded).copyWith(orders));
        }
      },
    );
  }
}
