import 'package:diplom_new/elements/slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher_string.dart';

class OrderDescription extends StatefulWidget {
  final List<int> selectedIndexes;
  final VoidCallback onBack;
  OrderDescription(
      {required this.onBack, required this.selectedIndexes, Key? key})
      : super(key: key);

  @override
  State<OrderDescription> createState() => _OrderDescriptionState();
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
    print(e.toString());
  }
}

class _OrderDescriptionState extends State<OrderDescription> {
  List<int> selectedOrderIndexes = [0]; // Initialize with one item
  List<Widget> sliders = []; // List to hold the sliders

  @override
  void initState() {
    super.initState();
    // Initialize sliders based on selected indexes
    sliders = List.generate(
        widget.selectedIndexes.length, (index) => buildSlider(index));
  }

  bool checkSelectedIndexes(int selectedIndexes) {
    if (selectedIndexes == 0) {
      return true;
    } else {
      return false;
    }
  }

  Widget buildSlider(int index) {
    return SliderOrder(
      onBack: () {
        widget.onBack();
        Navigator.pop(context); // наверное собака зарыта тут
      },
    );
  }

  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> toggleButtons = List.generate(
      widget.selectedIndexes.length,
      (index) => Text(
        '${widget.selectedIndexes[index] + 1}',
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w300,
          color: selectedOrderIndexes.contains(index)
              ? Colors.white
              : Colors.black,
        ),
      ),
    );

    return WillPopScope(
      onWillPop: () async {
        widget.onBack();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Visibility(
            visible: checkSelectedIndexes(widget.selectedIndexes.length),
            child: IconButton(
              icon: const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 35, 33, 33),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          title: ToggleButtons(
            isSelected: List.generate(
              widget.selectedIndexes.length,
              (index) => selectedOrderIndexes.contains(index),
            ),
            onPressed: (index) {
              setState(() {
                // Toggle selected indexes
                if (selectedOrderIndexes.contains(index)) {
                  selectedOrderIndexes.remove(index);
                } else {
                  selectedOrderIndexes.clear();
                  selectedOrderIndexes.add(index);
                }
              });
            },
            constraints: BoxConstraints.tightFor(width: 60, height: 30),
            borderRadius: BorderRadius.circular(13),
            color: Colors.white,
            selectedColor: Colors.white,
            fillColor: Colors.black,
            children: toggleButtons,
          ),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
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
                  color: Color.fromARGB(255, 35, 33, 33),
                ),
                child: Column(
                  children: [
                    OrderDescriptionHeader(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.025,
                    ),
                    const Divider(
                      thickness: 0,
                      height: 1,
                      color: Colors.grey,
                    ),
                    Phone(context),
                    OrderDescriptionDescription(context),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Visibility(
                        visible: selectedOrderIndexes.isNotEmpty,
                        child: Stack(
                            children: sliders.asMap().entries.map(
                          (entry) {
                            final index = entry.key;
                            final widget = entry.value;
                            return Visibility(
                                visible: index == selectedOrderIndexes.first,
                                child: widget);
                          },
                        ).toList()),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding Phone(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.width * 0.1,
          child: TextButton(
            child: const Row(
              children: [
                Icon(
                  Icons.phone,
                  color: Colors.white,
                  size: 24,
                ),
                SizedBox(
                  width: 10,
                ),
                Text('+375295601300',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white)),
              ],
            ),
            onPressed: () async {
              FlutterPhoneDirectCaller.callNumber('+375295601300');
            },
          )),
    );
  }

  Padding OrderDescriptionDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 50, 50, 50), // цвет светлее
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // изменение позиции тени
            ),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0), // добавление отступов
          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // выравнивание по левому краю

            children: [
              Text(
                'Информация о заказе',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 5), // отступ между текстом и другим содержимым
              Text(
                'Доставить до: 16:30\n'
                '1. Позиция 1 - 5 упаковок\n'
                '2. Позиция 2 - 10 упаковок\n'
                '3. Позиция 3 - 15 упаковок\n'
                '\n'
                'Сумма: 124.00 - Безналичные',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row OrderDescriptionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.only(left: 25, top: 25),
            child: Text(
              'ул. Уборевича, 146',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.only(top: 25, right: 15),
            child: InkWell(
              onTap: () {
                openYandexMaps("ул.Уборевича, 146");
              },
              borderRadius: BorderRadius.circular(50.0),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30.0,
                child: Icon(
                  Icons.navigation_rounded,
                  color: Color.fromARGB(255, 35, 33, 33),
                  size: 40.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
