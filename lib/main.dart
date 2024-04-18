//import 'package:diplom_new/elements/product_card.dart';
//import 'package:diplom_new/elements/slider.dart';
//import 'package:diplom_new/pages/history_page/history_page.dart';
//import 'package:diplom_new/pages/main_page/main_page_courier.dart';
import 'package:diplom_new/pages/main_page/main_page_courier.dart';
//import 'package:diplom_new/pages/main_page/main_page_vendor.dart';
//import 'package:diplom_new/pages/sign_in_page/sign_in_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPageCourier(),
    );
  }
}
