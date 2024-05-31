import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/features/repository/get_order_data_courier_history_repository/get_order_data_courier_history_repository.dart';
import 'package:diplom_new/features/repository/get_order_data_vendor_history_repository/get_order_data_vendor_history_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import 'package:diplom_new/features/models/order_model/order_model.dart';

part 'get_order_history_event.dart';
part 'get_order_history_state.dart';

class GetOrderHistoryBloc
    extends Bloc<GetOrderHistoryEvent, GetOrderHistoryState> {
  String? token;
  String? vendorId;
  String? courierId;

  GetOrderHistoryBloc() : super(GetOrderHistoryInitial()) {
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

    on<UpdateSelectedOrder>(
      (event, emit) {
        emit((state as GetOrderHistoryLoaded).copyWith(order: event.orders));
      },
    );

    on<GetHistoryEvent>((event, emit) async {
      emit(GetOrderHistoryLoading());
      try {
        if (token != null && vendorId != null) {
          final repository =
              GetOrderDataVendorHistoryRepository(token!, int.parse(vendorId!));
          final order = await repository.getOrderDataVendorHistory();
          emit(GetOrderHistoryLoaded(order: order));
        } else if (courierId != null) {
          final repository = GetOrderDataCourierHistoryRepository(
              token!, int.parse(courierId!));
          final order = await repository.getOrderDataCourierHistory();
          emit(GetOrderHistoryLoaded(order: order));
        } else {
          emit(GetOrderHistoryFailed());
        }
      } catch (e) {
        log(e.toString());
        emit(GetOrderHistoryFailed());
      }
    });
  }
}
