import 'dart:async';

import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    context.read<GetOrderInfoBloc>().add(GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blackColor,
        iconTheme: const IconThemeData(size: 25, color: whiteColor),
        actions: [
          IconButton(
              onPressed: () => {scanQR()},
              icon: const Icon(
                Icons.qr_code_scanner,
              )),
        ],
      ),
      drawer: const AppBarMenu(),
      body: BlocBuilder<GetOrderInfoBloc, GetOrderInfoState>(
          builder: (context, state) {
        if (state is GetOrderInfoLoaded) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.order.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {},
                      child: ProductCardModel(
                        index: index,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return Center(
              child: Text('Новых заказов пока нет, ожидайте',
                  style: mainTextStyleBlack));
        }
      }),
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
