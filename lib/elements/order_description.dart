// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/elements/message_dialog.dart';
import 'package:diplom_new/elements/slider.dart';
import 'package:diplom_new/features/models/order_model/order_model.dart';
import 'package:diplom_new/util/checker.dart';
import 'package:diplom_new/util/color.dart';
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
      appBar: AppBar(
        centerTitle: true,
        leading: (!isDeliver)
            ? IconButton(
                icon: const CircleAvatar(
                  backgroundColor: blackColor,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: whiteColor,
                    size: 24,
                  ),
                ),
                onPressed: () => Navigator.pop(context),
              )
            : const Center(),
      ),
      body: BlocBuilder<GetOrderInfoBloc, GetOrderInfoState>(
        builder: (context, state) {
          if (state is GetOrderInfoLoaded) {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: whiteColor,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                      color: blackColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, top: 25),
                                child: Text(
                                  order.address,
                                  style: headerTextStyleWhite,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 25, right: 15),
                                child: InkWell(
                                  onTap: () {
                                    openYandexMaps(order.address);
                                  },
                                  borderRadius: BorderRadius.circular(50.0),
                                  child: const CircleAvatar(
                                    backgroundColor: whiteColor,
                                    radius: 30.0,
                                    child: Icon(
                                      Icons.navigation_rounded,
                                      color: blackColor,
                                      size: 40.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025,
                        ),
                        const UnderLine(),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: TextButton(
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.phone,
                                      color: whiteColor,
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
                                    await FlutterPhoneDirectCaller.callNumber(
                                        order.phoneNumber);
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
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.width * 0.9,
                            decoration: BoxDecoration(
                              color: lightBlack,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: blackColor.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    '${order.iDCourier?.name}'
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
                                child:
                                    SliderOrder(orderId: order.id.toString()),
                              )
                            : const Center()
                      ],
                    ),
                  ),
                ),
              ],
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
