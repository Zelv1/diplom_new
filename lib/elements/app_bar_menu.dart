import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/elements/message_dialog.dart';
import 'package:diplom_new/pages/history_page/history_page_courier.dart';
import 'package:diplom_new/pages/main_page/main_page_courier.dart';
import 'package:diplom_new/pages/sign_in_page/sign_in_page.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:diplom_new/util/underline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

class AppBarMenu extends StatelessWidget {
  final bool isDeliver;
  const AppBarMenu({
    super.key,
    required this.isDeliver,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccessState) {
          return Drawer(
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      DrawerHeader(
                        decoration: const BoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              child: ClipOval(
                                child: Image.network(
                                  state.user.courier?.image.toString() ?? '',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Text(state.user.courier?.name ?? '',
                                style: headerTextStyle),
                            Text(state.user.courier?.number ?? '',
                                style: mainTextStyle)
                          ],
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.dark_mode_rounded),
                        title: Text('Темная тема', style: mainTextStyle),
                        trailing: const SwitchButton(),
                      ),
                      const UnderLine(),
                      ListTile(
                        leading: const Icon(Icons.history),
                        title: Text('История', style: mainTextStyle),
                        onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HistoryPageCourier()))
                        },
                      ),
                      const UnderLine(),
                      ListTile(
                        leading: const Icon(Icons.phone_android_rounded),
                        title: Text('Вызов менеджера', style: mainTextStyle),
                        onTap: () async {
                          try {
                            await FlutterPhoneDirectCaller.callNumber(
                                '+375295601300');
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            showMessageDialog(context,
                                'Платформа не поддерживает данную функцию');
                          }
                        },
                      ),
                      const UnderLine(),
                      ListTile(
                        leading: const Icon(Icons.info_outline),
                        title: Text('О нас ', style: mainTextStyle),
                        onTap: () => showMessageDialog(context,
                            'Приложение разработано учащимся группы 52ТП Зеленкевичем Иваном'),
                      ),
                      const UnderLine(),
                    ],
                  ),
                ),
                (!isDeliver)
                    ? ListTile(
                        leading: const Icon(
                          Icons.exit_to_app,
                        ),
                        title: Text('Выйти из аккаунта', style: mainTextStyle),
                        onTap: () {
                          context.read<AuthBloc>().add(AuthLogoutEvent());
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()),
                          );
                        },
                      )
                    : const Center(),
                const Padding(
                  padding: EdgeInsets.only(bottom: 1),
                  child: UnderLine(),
                ),
              ],
            ),
          );
        } else {
          return const Center();
        }
      },
    );
  }
}
