import 'package:diplom_new/bloc/get_order_history_bloc/get_order_history_bloc.dart';
import 'package:diplom_new/elements/message_dialog.dart';
import 'package:diplom_new/elements/product_card.dart';
import 'package:diplom_new/features/repository/printing/print_order_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPageVendor extends StatefulWidget {
  const HistoryPageVendor({super.key});

  @override
  State<HistoryPageVendor> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPageVendor> {
  late final GetOrderHistoryBloc _getOrderHistoryBloc;
  List<int?> selectedIndexes = [];
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
    return Scaffold(body:
        BlocBuilder<GetOrderHistoryBloc, GetOrderHistoryState>(
            builder: (context, state) {
      if (state is GetOrderHistoryLoaded) {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: state.order.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      //TODO: фиксануть переключение
                      onLongPress: () {
                        state.order[index] = state.order[index]
                            .copyWith(isActive: !state.order[index].isActive);
                        context
                            .read<GetOrderHistoryBloc>()
                            .add(UpdateSelectedOrder(orders: state.order));
                      },
                      child: ProductCardModel(
                        order: state.order[state.order.length - 1 - index],
                        isActive: state.order[index].isActive,
                      ),
                    );
                  }),
            ),
            if (state.selectedCount() == 1)
              IconButton(
                  onPressed: () async {
                    try {
                      await printOrder(state.order
                          .where((element) => element.isActive == true)
                          .first);
                    } catch (e) {
                      showMessageDialog(
                          // ignore: use_build_context_synchronously
                          context,
                          'Платформа не поддерживает данную функцию');
                    }
                  },
                  icon: const Icon(Icons.print, size: 50))
          ],
        );
      }
      return const Center(
        child: Text('История пуста'),
      );
    }));
  }
}
