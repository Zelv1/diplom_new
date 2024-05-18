import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';

import 'package:diplom_new/elements/order_form.dart';
import 'package:diplom_new/elements/product_card.dart';
import 'package:diplom_new/elements/qr_code_watch.dart';
import 'package:diplom_new/elements/vendor_profile.dart';
import 'package:diplom_new/features/api_url.dart';
import 'package:diplom_new/features/repository/print_qr_code/print_qr_code.dart';
import 'package:diplom_new/pages/history_page/history_page_vendor.dart';
import 'package:diplom_new/util/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageVendor extends StatefulWidget {
  const MainPageVendor({super.key});

  @override
  State<MainPageVendor> createState() => _MainPageVendorState();
}

class _MainPageVendorState extends State<MainPageVendor> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const GeneralPageVendor(),
    const HistoryPageVendor(),
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
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccessState) {
          return Scaffold(
            appBar: AppBar(
                backgroundColor: blackColor,
                iconTheme: const IconThemeData(
                  size: 25,
                )),
            body: SafeArea(
              child: _widgetOptions.elementAt(_selectedIndex),
            ),
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: blackColor,
              unselectedItemColor: blackColor,
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
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class GeneralPageVendor extends StatefulWidget {
  const GeneralPageVendor({super.key});

  @override
  State<GeneralPageVendor> createState() => _GeneralPageVendorState();
}

class _GeneralPageVendorState extends State<GeneralPageVendor> {
  late final GetOrderInfoBloc _getOrderInfoBloc;
  List<int?> selectedIndexes = [];
  @override
  void initState() {
    super.initState();
    //context.read<GetOrderInfoBloc>().add(GetOrdersEvent());
    _getOrderInfoBloc = BlocProvider.of<GetOrderInfoBloc>(context);
    _getOrderInfoBloc.add(GetOrdersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetOrderInfoBloc, GetOrderInfoState>(
          builder: (context, state) {
        if (state is GetOrderInfoLoaded) {
          bool showButton = state.order.any((order) => order.isActive);
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.order.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onLongPress: () {
                        if (selectedIndexes.contains(index)) {
                          selectedIndexes.remove(index);
                        } else {
                          selectedIndexes.add(index);
                        }
                        _getOrderInfoBloc
                            .add(SelectOrderEvent(orderIndex: index));
                      },
                      child: ProductCardModel(
                        index: index,
                        isActive: state.order[index].isActive,
                      ),
                    );
                  },
                ),
              ),
              if (showButton && selectedIndexes.length == 1)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        _getOrderInfoBloc.add(DeleteSelectedOrdersEvent());
                        selectedIndexes.clear();
                      },
                      icon: const Icon(Icons.delete, size: 50),
                    ),
                    IconButton(
                        onPressed: () async {
                          final imageBytes = await getImageBytes(BASE_URL +
                              state.order[selectedIndexes.first!].qrCode
                                  .toString());
                          await printDoc(imageBytes);
                        },
                        icon: const Icon(Icons.print, size: 50)),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QRCodeWatcher(
                                      index: selectedIndexes.first)));
                        },
                        icon: const Icon(Icons.info_outlined, size: 50)),
                  ],
                ),
              if (showButton && selectedIndexes.length > 1)
                IconButton(
                  onPressed: () {
                    _getOrderInfoBloc.add(DeleteSelectedOrdersEvent());
                    selectedIndexes.clear();
                  },
                  icon: const Icon(Icons.delete, size: 50),
                ),
            ],
          );
        } else {
          return const Center(
              child: Text('Заказы в обработке или доставке отсутствуют'));
        }
      }),
    );
  }
}
