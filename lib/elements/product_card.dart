// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:diplom_new/elements/order_description.dart';
import 'package:diplom_new/features/models/order_model/order_model.dart';
import 'package:diplom_new/util/checker.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:diplom_new/util/underline.dart';

class ProductCardModel extends StatelessWidget {
  final OrderModel order;
  final bool isActive;

  const ProductCardModel({
    super.key,
    required this.order,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  OrderDescription(
                order: order,
                isActive: order.isActive,
                isDeliver: false,
              ),
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
            color: isActive
                ? Theme.of(context).colorScheme.tertiaryContainer
                : Theme.of(context).colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                spreadRadius: 0,
                blurRadius: 3,
                offset: Offset(1, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Container(
                height: 35,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
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
                        '${order.id}',
                        style: mainTextStyleWhite,
                      ),
                      Text(
                        'Доставить до ${formatTimeToCard(order.deliverTo.toString())}',
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
                            order.address,
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
                            order.state == '1'
                                ? Icons.watch_later_outlined
                                : order.state == '2'
                                    ? Icons.drive_eta_outlined
                                    : order.state == '3'
                                        ? Icons.done
                                        : Icons.assist_walker,
                            size: 24,
                          ),
                          const SizedBox(width: 7),
                          Text(getOrderState(order.state),
                              style: mainTextStyleBlack)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const UnderLine(),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 10, left: 13),
                child: Row(
                  children: [
                    Text(getPaymentMethod(order.payment),
                        style: mainTextStyleBlack),
                    const SizedBox(
                      width: 7,
                    ),
                    Icon(
                      getPaymentIcon(order.payment),
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
  }
}
