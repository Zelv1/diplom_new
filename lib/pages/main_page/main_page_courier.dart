// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:diplom_new/elements/order_description.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:diplom_new/elements/app_bar_menu.dart';
import 'package:diplom_new/elements/product_card.dart';

class MainPageCourier extends StatefulWidget {
  const MainPageCourier({super.key});

  @override
  State<MainPageCourier> createState() => _MainPageCourierState();
}

class _MainPageCourierState extends State<MainPageCourier> {
  String qrResult = '';
  List<String> items = List.generate(10, (index) => '${index + 1}');
  List<int> selectedIndexes = [];
  bool isButtonVisible = false;

  @override
  void initState() {
    super.initState();
    selectedIndexes.clear();
    isButtonVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 33, 33),
        iconTheme: const IconThemeData(size: 25, color: Colors.white),
        actions: [
          IconButton(
              onPressed: () => {scanQR()},
              icon: const Icon(
                Icons.qr_code_scanner,
              )),
        ],
      ),
      drawer: const AppBarMenu(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    setState(() {
                      if (selectedIndexes.contains(index)) {
                        selectedIndexes.remove(index);
                      } else {
                        if (selectedIndexes.length < 3) {
                          selectedIndexes.add(index);
                        }
                      }
                      isButtonVisible = selectedIndexes.isNotEmpty;
                    });
                  },
                  child: ProductCardModel(
                    items: items[index],
                    selectedIndexes: selectedIndexes,
                    defaultColor: selectedIndexes.contains(index)
                        ? Color.fromARGB(255, 180, 185, 189)
                        : Colors.white,
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: isButtonVisible,
            child: IconButton(
              icon: Icon(Icons.waving_hand_sharp, size: 45),
              onPressed: () {
                _showOrderDetais(context);
              },
            ),
          )
        ],
      ),
    );
  }

  void _showOrderDetais(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        List<int> selectedIndexesCopy = List.from(selectedIndexes);
        selectedIndexes.clear();
        isButtonVisible = false;
        return OrderDescription(
            selectedIndexes: selectedIndexesCopy,
            onBack: () {
              setState(() {
                // Reset selected indexes when navigating back
                selectedIndexes.clear();
                isButtonVisible = false;
              });
            });
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
      activeColor: Colors.white,
      onChanged: (bool value) {
        setState(() {
          light = value;
        });
      },
    );
  }
}
