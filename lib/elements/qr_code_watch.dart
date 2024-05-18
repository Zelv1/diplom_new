import 'dart:developer';

import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/features/api_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QRCodeWatcher extends StatelessWidget {
  final int? index;
  const QRCodeWatcher({required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrderInfoBloc, GetOrderInfoState>(
        builder: (context, state) {
      if (state is GetOrderInfoLoaded) {
        log(state.order[index!].qrCode.toString());
        return Scaffold(
          body: Center(
              child: Image.network(
            BASE_URL + state.order[index!].qrCode.toString(),
            fit: BoxFit.cover,
          )),
        );
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    });
  }
}
