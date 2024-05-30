import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
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
  List<int?> selectedIndexes = [];
  @override
  void initState() {
    super.initState();
    context.read<GetOrderInfoBloc>().add(GetHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<GetOrderInfoBloc, GetOrderInfoState>(
        builder: (context, state) {
      if (state is GetOrderInfoLoaded) {
        bool showButton = state.order.any((order) => order.isActive);
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: state.order.length,
                  itemBuilder: (context, index) {
                    final isSelected = selectedIndexes;
                    return GestureDetector(
                      //TODO: фиксануть переключение
                      onLongPress: () {
                        if (isSelected.contains(index)) {
                          context
                              .read<GetOrderInfoBloc>()
                              .add(SelectOrderEvent(orderIndex: index));
                          isSelected.remove(index);
                        } else {
                          isSelected.add(index);
                          context
                              .read<GetOrderInfoBloc>()
                              .add(SelectOrderEvent(orderIndex: index));
                        }
                      },
                      child: ProductCardModel(
                        order: state.order[state.order.length - 1 - index],
                        isActive: state.order[index].isActive,
                      ),
                    );
                  }),
            ),
            if (showButton && selectedIndexes.length == 1)
              IconButton(
                  onPressed: () async {
                    try {
                      await printOrder(state.selectedOrder!);
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
