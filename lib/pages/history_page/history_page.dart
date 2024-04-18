//import 'package:diplom_new/elements/product_card.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 35, 33, 33),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onPressed: () => {},
          ),
          title: const Text(
            'История заказов',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          ),
        ),
        body: ListView.builder(
            itemCount: 30,
            itemBuilder: (context, index) {
              return Placeholder();
            }));
  }
}
