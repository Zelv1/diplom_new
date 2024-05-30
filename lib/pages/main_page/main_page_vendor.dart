// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'dart:developer';

import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/cubit/light_dart_theme_cubit.dart';
import 'package:diplom_new/elements/message_dialog.dart';

import 'package:diplom_new/elements/order_form.dart';
import 'package:diplom_new/elements/product_card.dart';
import 'package:diplom_new/elements/qr_code_watch.dart';
import 'package:diplom_new/elements/vendor_profile.dart';
import 'package:diplom_new/features/api_url.dart';
import 'package:diplom_new/features/repository/printing/print_qr_code.dart';
import 'package:diplom_new/pages/history_page/history_page_vendor.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageVendor extends StatefulWidget {
  const MainPageVendor({super.key});

  @override
  State<MainPageVendor> createState() => _MainPageVendorState();
}

class _MainPageVendorState extends State<MainPageVendor> {
  int _selectedIndex = 0;
  bool light = true;
  final List<Widget> _widgetOptions = <Widget>[
    const GeneralPageVendor(),
    const HistoryPageVendor(),
    const OrderFormWidget(),
    const VendorProfile(),
  ];

  @override
  void initState() {
    light = context.read<LightDartThemeCubit>().state;
    super.initState();
  }

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
                backgroundColor: Theme.of(context).colorScheme.surface,
                iconTheme: IconThemeData(
                  size: 25,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                actions: [
                  IconButton(
                      onPressed: () {
                        context.read<LightDartThemeCubit>().emit(!light);
                        setState(() {
                          light = !light;
                        });
                      },
                      icon: Icon((light) ? Icons.light_mode : Icons.dark_mode)),
                ]),
            body: Center(
              child: SizedBox(
                width: 800,
                child: SafeArea(
                  child: _widgetOptions.elementAt(_selectedIndex),
                ),
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              unselectedItemColor: Theme.of(context).colorScheme.onBackground,
              selectedItemColor: Theme.of(context).colorScheme.onBackground,
              selectedFontSize: 14,
              unselectedFontSize: 14,
              iconSize: 25,
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  label: 'Текущие заказы',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  label: 'История',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  label: 'Добавить',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
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
    log(selectedIndexes.length.toString());
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

          return (state.order.isNotEmpty)
              ? Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.order.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedIndexes;
                          log(selectedIndexes.toString());
                          log('на главной ${state.order[index].isActive.toString()}');
                          return GestureDetector(
                            onLongPress: () {
                              //TODO: фиксануть переключение
                              log(state.order[index].isActive.toString());
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
                              order: state.order[index],
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
                          state.selectedOrder?.state != '2'
                              ? IconButton(
                                  onPressed: () {
                                    _getOrderInfoBloc
                                        .add(DeleteSelectedOrdersEvent());
                                    selectedIndexes.clear();
                                  },
                                  icon: const Icon(Icons.delete, size: 50),
                                )
                              : const Center(),
                          IconButton(
                              onPressed: () async {
                                try {
                                  final imageBytes = await getImageBytes(
                                      BASE_URL +
                                          state.order[selectedIndexes.first!]
                                              .qrCode
                                              .toString());
                                  await printDoc(imageBytes);
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  showMessageDialog(context,
                                      'Платформа не поддерживает данную функцию');
                                }
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
                      (state.selectedOrder?.state != '2')
                          ? IconButton(
                              onPressed: () {
                                _getOrderInfoBloc
                                    .add(DeleteSelectedOrdersEvent());
                                selectedIndexes.clear();
                              },
                              icon: const Icon(Icons.delete, size: 50),
                            )
                          : Text(
                              'Вы не можете удалить заказ, который находится в пути\n',
                              style: headerTextStyleBlack,
                            )
                  ],
                )
              : Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      'Заказы в доставке или обратотке отсутствуют, создайте заказ',
                      maxLines: null,
                      textAlign: TextAlign.justify,
                      style: headerTextStyleBlack,
                    ),
                  ),
                );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
