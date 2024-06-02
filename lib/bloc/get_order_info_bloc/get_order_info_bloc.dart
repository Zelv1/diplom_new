import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/features/repository/delete_order_repository/delete_order_repository.dart';
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
  final selectedIndexes = <int>{};

  GetOrderInfoBloc() : super(GetOrderInfoInitial()) {
    AuthMiddleware.authData.listen((event) {
      token = event.toString();
    });

    AuthMiddleware.user.listen((event) {
      vendorId = event.vendor?.id.toString();
      courierId = event.courier?.id.toString();
    });

    on<UpdateSelectedOrder>(
      (event, emit) {
        emit((state as GetOrderInfoLoaded).copyWith(order: event.orders));
      },
    );

    on<GetOrdersEvent>((event, emit) async {
      emit(GetOrderInfoLoading());
      try {
        if (token != null && vendorId != null) {
          final repository =
              GetOrderDataVendorRepository(token!, int.parse(vendorId!));
          final order = await repository.getOrderDataVendor();
          emit(GetOrderInfoLoaded(
            order: order,
          ));
        } else if (vendorId == null) {
          final repository = GetOrderDataCourierRepository(token!);
          final order = await repository.getOrderDataCourier();
          emit(GetOrderInfoLoaded(
            order: order,
          ));
        } else {
          emit(GetOrderInfoFailed());
        }
      } catch (e) {
        log(e.toString());
        emit(GetOrderInfoFailed());
      }
    });

    on<DeleteSelectedOrdersEvent>(
      (event, emit) async {
        if (state is GetOrderInfoLoaded) {
          List<String> orderToDelete = [];
          log(orderToDelete.toString());
          try {
            orderToDelete.addAll((state as GetOrderInfoLoaded)
                .order
                .where((element) => element.isActive == true)
                .map((e) => e.id.toString()));

            for (var orderId in orderToDelete) {
              final repository = DeleteOrderRepository(token!, orderId);
              await repository.deleteOrder();
            }

            add(GetOrdersEvent());
          } catch (e) {
            log(e.toString());
          }
        }
      },
    );
  }
}
