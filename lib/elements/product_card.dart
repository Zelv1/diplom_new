import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/elements/order_description.dart';
import 'package:diplom_new/util/checker.dart';
import 'package:diplom_new/util/color.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:diplom_new/util/underline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCardModel extends StatelessWidget {
  final int index;
  final bool isActive;
  const ProductCardModel({
    this.isActive = false,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetOrderInfoBloc, GetOrderInfoState>(
      builder: (context, state) {
        //log(isActive as String);
        if (state is GetOrderInfoLoaded && state.order.isNotEmpty) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        OrderDescription(index: index),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 1.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: Container(
                height: 200,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                  color: isActive ? greyColor : whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: semiWhiteColor.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: blackColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${state.order[index].id}',
                              style: mainTextStyleWhite,
                            ),
                            Text(
                              'Доставить до ${formatTime(state.order[index].deliverTo.toString())}',
                              style: mainTextStyleWhite,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 125,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 17, left: 15),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.location_on_sharp,
                                  size: 35,
                                ),
                                const SizedBox(
                                  width: 7,
                                ),
                                Text(
                                  state.order[index].address,
                                  style: headerTextStyleBlack,
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 35, right: 10),
                            child: Row(
                              children: [
                                const Expanded(
                                  flex: 1,
                                  child: Text(''),
                                ),
                                Icon(
                                  state.order[index].state == '1'
                                      ? Icons.watch_later_outlined
                                      : state.order[index].state == '2'
                                          ? Icons.drive_eta_outlined
                                          : state.order[index].state == '3'
                                              ? Icons.done
                                              : Icons.assist_walker,
                                  size: 24,
                                ),
                                const SizedBox(width: 7),
                                Text(getOrderState(state.order[index].state),
                                    style: mainTextStyleBlack)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const UnderLine(),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 5, bottom: 10, left: 13),
                      child: Row(
                        children: [
                          Text(getPaymentMethod(state.order[index].payment),
                              style: mainTextStyleBlack),
                          const SizedBox(
                            width: 7,
                          ),
                          Icon(
                            getPaymentIcon(state.order[index].payment),
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
              child: Text(
            'Заказов нет',
            style: mainTextStyleBlack,
          ));
        }
      },
    );
  }
}
