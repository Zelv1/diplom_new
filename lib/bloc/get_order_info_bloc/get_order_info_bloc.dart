import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/features/repository/create_order_repository/create_order_repository.dart';
import 'package:diplom_new/features/repository/get_order_data_courier_history_repository/get_order_data_courier_history_repository.dart';
import 'package:diplom_new/features/repository/get_order_data_vendor_history_repository/get_order_data_vendor_history_repository.dart';
import 'package:diplom_new/features/repository/get_order_data_vendor_repository/get_order_data_vendor_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import 'package:diplom_new/features/models/order_model/order_model.dart';
import 'package:diplom_new/features/repository/auth_repository/auth_repository.dart';
import 'package:diplom_new/features/repository/get_order_data_courier_repository/get_order_data_courier_repository.dart';

part 'get_order_info_event.dart';
part 'get_order_info_state.dart';

class GetOrderInfoBloc extends Bloc<GetOrderInfoEvent, GetOrderInfoState> {
  final AuthBloc authBloc;
  late final StreamSubscription authSubscription;

  GetOrderInfoBloc({required this.authBloc}) : super(GetOrderInfoInitial()) {
    on<GetCourierOrderEvent>((event, emit) async {
      emit(GetOrderInfoLoading());
      final token = await authRepositoryGetLocalToken();
      final repository = GetOrderDataCourierRepository(token!);
      final order = await repository.getOrderDataCourier();
      emit(GetOrderInfoLoaded(order: order));
    });

    on<GetVendorOrderEvent>((event, emit) async {
      emit(GetOrderInfoLoading());
      try {
        final token = await authRepositoryGetLocalToken();
        final repository = GetOrderDataVendorRepository(token!, event.vendorId);
        final order = await repository.getOrderDataVendor();
        emit(GetOrderInfoLoaded(order: order));
      } catch (e) {
        log(e.toString());
        emit(GetOrderInfoFailed());
      }
    });

    on<GetVendorHistoryEvent>((event, emit) async {
      emit(GetOrderInfoLoading());
      try {
        final token = await authRepositoryGetLocalToken();
        final repository =
            GetOrderDataVendorHistoryRepository(token!, event.vendorId);
        final order = await repository.getOrderDataVendorHistory();
        emit(GetOrderInfoLoaded(order: order));
      } catch (e) {
        log(e.toString());
        emit(GetOrderInfoFailed());
      }
    });

    on<GetCourierHistoryEvent>((event, emit) async {
      emit(GetOrderInfoLoading());
      try {
        final token = await authRepositoryGetLocalToken();
        final repository =
            GetOrderDataCourierHistoryRepository(token!, event.courierId);
        final order = await repository.getOrderDataCourierHistory();
        emit(GetOrderInfoLoaded(order: order));
      } catch (e) {
        log(e.toString());
        emit(GetOrderInfoFailed());
      }
    });

    on<CreateOrderEvent>((event, emit) async {
      emit(GetOrderInfoLoading());
      try {
        final token = await authRepositoryGetLocalToken();
        final repository = CreateOrderRepository(
          token!,
          event.vendor,
          event.address,
          event.payment,
          event.phoneNumber,
          event.goodType,
          event.review,
        );
        await repository.createOrder();
        log('Success creating');
        emit(CreateOrderSuccessState());
      } catch (e) {
        log(e.toString());
        emit(GetOrderInfoFailed());
      }
    });
  }
}
