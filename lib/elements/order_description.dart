// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/cubit/light_dart_theme_cubit.dart';
import 'package:diplom_new/elements/app_bar_menu.dart';
import 'package:diplom_new/elements/message_dialog.dart';
import 'package:diplom_new/elements/slider.dart';
import 'package:diplom_new/features/models/order_model/order_model.dart';
import 'package:diplom_new/util/checker.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:diplom_new/util/underline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderDescription extends StatelessWidget {
  final OrderModel order;
  final bool isActive;
  final bool isDeliver;
  const OrderDescription(
      {super.key,
      required this.order,
      required this.isActive,
      required this.isDeliver});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: (isDeliver)
          ? AppBarMenu(
              isDeliver: isDeliver,
            )
          : null,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: true,
        leading: (!isDeliver)
            ? IconButton(
                icon: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.secondaryContainer,
                  child: Icon(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    Icons.arrow_back_ios_new_rounded,
                    size: 24,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: BlocBuilder<GetOrderInfoBloc, GetOrderInfoState>(
        builder: (context, state) {
          if (state is GetOrderInfoLoaded) {
            return Center(
              child: SizedBox(
                width: 550,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: (context.read<LightDartThemeCubit>().state ==
                                  false)
                              ? Theme.of(context).colorScheme.tertiaryContainer
                              : Theme.of(context).colorScheme.surfaceVariant,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              width: 450,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, top: 20),
                                    child: Text(
                                      order.address,
                                      style: headerTextStyleWhite,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 100,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 20, top: 20),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondaryContainer,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      child: IconButton(
                                        style: IconButton.styleFrom(),
                                        color: Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant,
                                        onPressed: () {
                                          openYandexMaps(order.address);
                                        },
                                        icon: const Icon(
                                          Icons.navigation_rounded,
                                          size: 40.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.025,
                            ),
                            const UnderLine(),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: SizedBox(
                                  height: 50,
                                  child: TextButton(
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.phone,
                                          size: 24,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(order.phoneNumber,
                                            style: headerTextStyleWhite),
                                      ],
                                    ),
                                    onPressed: () async {
                                      try {
                                        await FlutterPhoneDirectCaller
                                            .callNumber(order.phoneNumber);
                                      } catch (e) {
                                        // ignore: use_build_context_synchronously
                                        showMessageDialog(context,
                                            'Платформа не поддерживает данную функцию');
                                      }
                                    },
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.3,
                                width: 500,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: (context
                                              .read<LightDartThemeCubit>()
                                              .state ==
                                          false)
                                      ? Theme.of(context)
                                          .colorScheme
                                          .surfaceVariant
                                      : Theme.of(context)
                                          .colorScheme
                                          .tertiaryContainer,
                                  boxShadow: const [
                                    BoxShadow(
                                      spreadRadius: 0,
                                      blurRadius: 3,
                                      offset: Offset(1, 2),
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Информация о заказе',
                                        style: headerTextStyleWhite,
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Доставить до: ${formatTime(order.deliverTo.toString())}'
                                        '\n'
                                        '\n'
                                        'Вид товара: ${getGoodType(order.goodType)}'
                                        '\n'
                                        '\n'
                                        'Способ оплаты: ${getPaymentMethod(order.payment)}'
                                        '\n'
                                        '\n'
                                        'Описание: ${order.review}',
                                        style: mainTextStyleWhite,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            isDeliver
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SliderOrder(
                                        orderId: order.id.toString()),
                                  )
                                : const Center()
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future<void> openYandexMaps(String address) async {
  String encodedAddress = Uri.encodeComponent(address);
  String url = 'https://yandex.ru/maps/?text=$encodedAddress';
  await openYandexMapsUniLinks(url);
}

Future<void> openYandexMapsUniLinks(String url) async {
  try {
    await getInitialUri();
    await launchUrlString(url);
  } catch (e) {
    log(e.toString());
  }
}
