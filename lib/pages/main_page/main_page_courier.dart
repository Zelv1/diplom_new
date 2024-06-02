import 'dart:async';

import 'package:diplom_new/bloc/deliver_order_bloc/deliver_order_bloc.dart';
import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/cubit/light_dart_theme_cubit.dart';
import 'package:diplom_new/elements/message_dialog.dart';
import 'package:diplom_new/elements/order_description.dart';

import 'package:diplom_new/util/find_order.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:flutter/material.dart';

import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:diplom_new/elements/app_bar_menu.dart';
import 'package:diplom_new/elements/product_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MainPageCourier extends StatefulWidget {
  const MainPageCourier({super.key});

  @override
  State<MainPageCourier> createState() => _MainPageCourierState();
}

class _MainPageCourierState extends State<MainPageCourier> {
  String qrResult = '';
  late final GetOrderInfoBloc _getOrderInfoBloc;
  List<int?> selectedIndexes = [];
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  void initState() {
    super.initState();
    context.read<DeliverOrderBloc>().add(UpdateOrderStatusEvent());
    _getOrderInfoBloc = BlocProvider.of<GetOrderInfoBloc>(context);
    _getOrderInfoBloc.add(GetOrdersEvent());
  }

  void onRefresh() {
    context.read<GetOrderInfoBloc>().add(GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliverOrderBloc, DeliverOrderState>(
      listener: (context, state) {
        if (state is WaitProcessOrderState) {
          context.read<GetOrderInfoBloc>().add(GetOrdersEvent());
        } else if (state is OrderHasAlreadyDeliveredState) {
          showMessageDialog(context, 'Данный заказ уже в пути или доставлен');
        }
      },
      child: BlocBuilder<DeliverOrderBloc, DeliverOrderState>(
        builder: (context, state) {
          if (state is ProcessOrderState) {
            return OrderDescription(
              order: state.order,
              isActive: true,
              isDeliver: true,
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                iconTheme: IconThemeData(
                    size: 25,
                    color: (context.read<LightDartThemeCubit>().state == false)
                        ? Theme.of(context).colorScheme.surfaceVariant
                        : Theme.of(context).colorScheme.onSurfaceVariant),
                actions: [
                  IconButton(
                      onPressed: () async {
                        try {
                          String? qr = await scanQR();

                          (qr == 'Fail')
                              // ignore: use_build_context_synchronously
                              ? showMessageDialog(context,
                                  'Платформа не поддерживает данную функцию')
                              : (qr == '')
                                  ? showMessageDialog(
                                      // ignore: use_build_context_synchronously
                                      context,
                                      'Вы не выбрали заказ')
                                  : showDialog(
                                      // ignore: use_build_context_synchronously
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(
                                            'Внимание!',
                                            style: authTag,
                                          ),
                                          content: Text(
                                            'Вы собираетесь взять на доставку заказ №$qr',
                                            maxLines: null,
                                            textAlign: TextAlign.justify,
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                  context
                                                      .read<DeliverOrderBloc>()
                                                      .add(GetDataFromQREvent(
                                                          orderId: qr!));
                                                },
                                                child: Text('Вперед!',
                                                    style: headerTextStyle)),
                                            TextButton(
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text('Отмена',
                                                    style: headerTextStyle))
                                          ],
                                        );
                                      },
                                    );
                        } catch (e) {
                          // ignore: use_build_context_synchronously
                          showMessageDialog(context,
                              'Платформа не поддерживает данную функцию');
                        }
                      },
                      icon: const Icon(
                        Icons.qr_code_scanner,
                      )),
                ],
              ),
              drawer: const AppBarMenu(
                isDeliver: false,
              ),
              body: Center(
                child: SizedBox(
                  width: 800,
                  child: BlocBuilder<GetOrderInfoBloc, GetOrderInfoState>(
                      builder: (context, state) {
                    if (state is GetOrderInfoLoaded) {
                      return (state.order.isNotEmpty)
                          ? Column(
                              children: [
                                Expanded(
                                  child: SmartRefresher(
                                    enablePullDown: true,
                                    onRefresh: onRefresh,
                                    controller: _refreshController,
                                    child: ListView.builder(
                                      itemCount: state.order.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onLongPress: () {
                                            state.order[index] =
                                                state.order[index].copyWith(
                                                    isActive: !state
                                                        .order[index].isActive);
                                            context
                                                .read<GetOrderInfoBloc>()
                                                .add(UpdateSelectedOrder(
                                                    orders: state.order));
                                          },
                                          child: ProductCardModel(
                                            order: state.order[index],
                                            isActive:
                                                state.order[index].isActive,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                if (state.selectedCount() == 1)
                                  IconButton(
                                    onPressed: () {
                                      context.read<DeliverOrderBloc>().add(
                                          ClaimOrderEvent(state.order
                                              .where((element) =>
                                                  element.isActive == true)
                                              .first));
                                    },
                                    icon: const Icon(Icons.back_hand_rounded,
                                        size: 50),
                                  ),
                              ],
                            )
                          : const Center(child: CircularProgressIndicator());
                    } else {
                      return Center(
                        child: Text(
                          "Заказов пока нет, ожидайте",
                          style: headerTextStyle,
                        ),
                      );
                    }
                  }),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Future<String?> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      qrResult = extractBetweenPipes(qrCode.toString());
    } catch (e) {
      qrResult = 'Fail';
    }
    return qrResult;
  }
}

class SwitchButton extends StatefulWidget {
  const SwitchButton({
    super.key,
  });

  @override
  State<SwitchButton> createState() => _SwitchButtonState();
}

class _SwitchButtonState extends State<SwitchButton> {
  bool light = true;

  @override
  void initState() {
    super.initState();
    light = context.read<LightDartThemeCubit>().state;
  }

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: light,
      onChanged: (bool value) {
        setState(() {
          // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
          context.read<LightDartThemeCubit>().emit(!light);
          light = value;
        });
      },
    );
  }
}
