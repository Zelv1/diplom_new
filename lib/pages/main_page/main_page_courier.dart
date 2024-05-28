import 'dart:async';
import 'dart:developer';

import 'package:diplom_new/bloc/deliver_order_bloc/deliver_order_bloc.dart';
import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/elements/message_dialog.dart';
import 'package:diplom_new/elements/order_description.dart';
import 'package:diplom_new/util/color.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:diplom_new/elements/app_bar_menu.dart';
import 'package:diplom_new/elements/product_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageCourier extends StatefulWidget {
  const MainPageCourier({super.key});

  @override
  State<MainPageCourier> createState() => _MainPageCourierState();
}

class _MainPageCourierState extends State<MainPageCourier> {
  String qrResult = '';
  late final GetOrderInfoBloc _getOrderInfoBloc;
  List<int?> selectedIndexes = [];
  @override
  void initState() {
    super.initState();
    context.read<DeliverOrderBloc>().add(UpdateOrderStatusEvent());
    _getOrderInfoBloc = BlocProvider.of<GetOrderInfoBloc>(context);
    _getOrderInfoBloc.add(GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeliverOrderBloc, DeliverOrderState>(
      listener: (context, state) {
        if (state is WaitProcessOrderState) {
          context.read<GetOrderInfoBloc>().add(GetOrdersEvent());
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
                backgroundColor: blackColor,
                iconTheme: const IconThemeData(size: 25, color: whiteColor),
                actions: [
                  IconButton(
                      onPressed: () async {
                        try {
                          await scanQR();
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
              drawer: const AppBarMenu(),
              body: BlocBuilder<GetOrderInfoBloc, GetOrderInfoState>(
                  builder: (context, state) {
                if (state is GetOrderInfoLoaded) {
                  log(state.selectedOrder.toString());
                  bool showButton = state.order.any((order) => order.isActive);
                  return (state.order.isNotEmpty)
                      ? Column(
                          children: [
                            Expanded(
                              child: ListView.builder(
                                itemCount: state.order.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    //TODO: фиксануть переключение
                                    onLongPress: () {
                                      if (selectedIndexes.contains(index)) {
                                        selectedIndexes.remove(index);
                                      } else {
                                        selectedIndexes.add(index);
                                      }
                                      _getOrderInfoBloc.add(
                                          SelectOrderEvent(orderIndex: index));
                                    },
                                    child: ProductCardModel(
                                      order: state.order[index],
                                      isActive: state.order[index].isActive,
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (showButton)
                              IconButton(
                                onPressed: () {
                                  context.read<DeliverOrderBloc>().add(
                                      ClaimOrderEvent(state.selectedOrder!));
                                },
                                icon: const Icon(Icons.back_hand_rounded,
                                    size: 50),
                              ),
                          ],
                        )
                      : Center(
                          child: Text(
                            "Заказов пока нет, ожидайте",
                            style: headerTextStyleBlack,
                          ),
                        );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
            );
          }
        },
      ),
    );
  }

  Future<void> scanQR() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      if (!mounted) return;
      setState(() {
        qrResult = qrCode.toString();
      });
    } on PlatformException {
      qrResult = 'Fail';
    }
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
  bool light = false;
  @override
  Widget build(BuildContext context) {
    return Switch(
      value: light,
      activeColor: whiteColor,
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}
