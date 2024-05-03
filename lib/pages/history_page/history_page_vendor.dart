//import 'package:diplom_new/elements/product_card.dart';
import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/elements/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPageVendor extends StatefulWidget {
  const HistoryPageVendor({super.key});

  @override
  State<HistoryPageVendor> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPageVendor> {
  late AuthBloc _authBloc;
  @override
  void initState() {
    super.initState();
    _authBloc = BlocProvider.of<AuthBloc>(context);

    final state = _authBloc.state;

    if (state is AuthSuccessState && state.user.vendor != null) {
      BlocProvider.of<GetOrderInfoBloc>(context)
          .add(GetVendorHistoryEvent(vendorId: state.user.vendor!.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GetOrderInfoBloc, GetOrderInfoState>(
        builder: (context, state) {
      if (state is GetOrderInfoLoaded) {
        return ListView.builder(
            itemCount: state.order.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onLongPress: () {},
                child: ProductCardModel(
                  index: index,
                ),
              );
            });
      }
      return const Center(
        child: Text('История пуста'),
      );
    }));
  }
}
