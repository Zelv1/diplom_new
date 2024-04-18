import 'package:diplom_new/elements/order_description.dart';
import 'package:flutter/material.dart';

class ProductCardModel extends StatelessWidget {
  final String items;
  final List<int> selectedIndexes;
  final Color defaultColor;

  ProductCardModel(
      {super.key,
      required this.items,
      required this.defaultColor,
      required this.selectedIndexes});

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
                onBack: () {},
                selectedIndexes: selectedIndexes,
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0.0, 1.0), // снизу
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
            color: defaultColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color:
                    const Color.fromARGB(255, 204, 183, 183).withOpacity(0.5),
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
                  color: Color.fromARGB(255, 35, 33, 33),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${items}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      ),
                      Text(
                        'Доставить до 16:30',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 125,
                width: MediaQuery.of(context).size.width * 0.95,
                child: const Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 17, left: 15),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_sharp,
                            size: 35,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'ул. Уборевича, 146',
                            style: TextStyle(
                                color: Color.fromARGB(255, 35, 33, 33),
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 35, right: 10),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(''),
                          ),
                          Icon(
                            Icons.watch_later_outlined,
                            size: 24,
                          ),
                          SizedBox(width: 7),
                          Text('Ожидает доставки',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 35, 33, 33),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
                thickness: 0,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5, bottom: 10, left: 13),
                child: Row(
                  children: [
                    Text(
                      'Терминал',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          color: Color.fromARGB(255, 35, 33, 33)),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Icon(
                      Icons.terminal,
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
