import 'package:diplom_new/elements/order_form.dart';
import 'package:diplom_new/elements/vendor_profile.dart';
import 'package:flutter/material.dart';

class MainPageVendor extends StatefulWidget {
  const MainPageVendor({super.key});

  @override
  State<MainPageVendor> createState() => _MainPageVendorState();
}

class _MainPageVendorState extends State<MainPageVendor> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const Text('Главная'),
    const Text('История'),
    const OrderFormWidget(),
    const VendorProfile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 35, 33, 33),
          iconTheme: const IconThemeData(
            size: 25,
          )),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 35, 33, 33),
        unselectedItemColor: const Color.fromARGB(255, 35, 33, 33),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        iconSize: 25,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Текущие заказы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'История',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Добавить',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
