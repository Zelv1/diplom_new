import 'package:diplom_new/bloc/get_order_history_bloc/get_order_history_bloc.dart';
import 'package:diplom_new/elements/product_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPageCourier extends StatefulWidget {
  const HistoryPageCourier({super.key});

  @override
  State<HistoryPageCourier> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPageCourier> {
  late final GetOrderHistoryBloc _getOrderHistoryBloc;
  @override
  void initState() {
    super.initState();
    _getOrderHistoryBloc = BlocProvider.of<GetOrderHistoryBloc>(context);
    if (_getOrderHistoryBloc.state is GetOrderHistoryInitial) {
      _getOrderHistoryBloc.add(GetHistoryEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            onPressed: () => {
              Navigator.pop(
                context,
                // MaterialPageRoute(
                //     builder: (context) => const MainPageCourier()),
              ),
            },
          ),
        ),
        body: BlocBuilder<GetOrderHistoryBloc, GetOrderHistoryState>(
          builder: (context, state) {
            if (state is GetOrderHistoryLoaded) {
              return ListView(
                  children: state
                      .sortedOrders()
                      .map(
                        (e) => ProductCardModel(order: e),
                      )
                      .toList()

                  //  ProductCardModel(
                  //   order: state.order[state.order.length - 1 - index],
                  // );
                  );
            }
            return const Center(child: Text('История пуста'));
          },
        ));
  }
}
