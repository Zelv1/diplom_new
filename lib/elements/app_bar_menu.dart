import 'package:diplom_new/pages/main_page/main_page_courier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class AppBarMenu extends StatelessWidget {
  const AppBarMenu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 35, 33, 33),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.account_circle_sharp,
                  size: 60,
                ),
                Text('Имя',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
                Text('+375(99)999-99-99',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w300))
              ],
            ),
          ),
          const ListTile(
            leading: Icon(Icons.dark_mode_rounded),
            title: Text('Темная тема',
                style: TextStyle(
                    color: Color.fromARGB(255, 35, 33, 33),
                    fontSize: 13,
                    fontWeight: FontWeight.w300)),
            trailing: SwitchButton(),
          ),
          GrayLine(context),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('История',
                style: TextStyle(
                    color: Color.fromARGB(255, 35, 33, 33),
                    fontSize: 13,
                    fontWeight: FontWeight.w300)),
            onTap: () => {},
          ),
          GrayLine(context),
          ListTile(
            leading: const Icon(Icons.phone_android_rounded),
            title: const Text('Вызов менеджера',
                style: TextStyle(
                    color: Color.fromARGB(255, 35, 33, 33),
                    fontSize: 13,
                    fontWeight: FontWeight.w300)),
            onTap: () async {
              FlutterPhoneDirectCaller.callNumber('+375295601300');
            },
          ),
          GrayLine(context),
        ],
      ),
    );
  }

  Divider GrayLine(BuildContext context) {
    return Divider(
      color: Colors.grey,
      thickness: 1,
      height: 0,
      indent: MediaQuery.of(context).size.width * 0.03,
      endIndent: MediaQuery.of(context).size.width * 0.03,
    );
  }
}
