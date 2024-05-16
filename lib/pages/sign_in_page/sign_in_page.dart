// ignore_for_file: non_constant_identifier_names
import 'dart:developer';

import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/bloc/create_order_bloc/create_order_bloc.dart';
import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
//import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/pages/main_page/main_page_courier.dart';
import 'package:diplom_new/pages/main_page/main_page_vendor.dart';
import 'package:diplom_new/util/color.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:diplom_new/util/underline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController controllerUserName = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  @override
  void initState() {
    super.initState();
    log('AUTH CHECK CACHE IN PAGE');
    context.read<GetOrderInfoBloc>();
    context.read<CreateOrderBloc>();
    context.read<AuthBloc>().add(AuthCheckCacheEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          if (state.user.courier == null) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainPageVendor()));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainPageCourier()));
          }
        }
      },
      builder: (context, state) {
        if (state is AuthWaitCredentialsState) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                SignInLogo(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                SignInTextFields(context),
                GrayLine(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                SignInButton(),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                ForgetButton()
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    ));
  }

  ConstrainedBox GrayLine() {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 350, maxHeight: 55),
      child: const UnderLine(),
    );
  }

  TextButton ForgetButton() {
    return TextButton(
        onPressed: () => {},
        child: Text(
          'Забыли логин или пароль?',
          style: mainTextStyleBlack,
        ));
  }

  Row SignInLogo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Авторизация', style: authTag)],
    );
  }

  Container SignInButton() => Container(
      decoration: BoxDecoration(
          color: blackColor, borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
          onPressed: () => {
                context.read<AuthBloc>().add(AuthLoginEvent(
                    username: controllerUserName.text,
                    password: controllerPassword.text))
              },
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(350, 55),
            backgroundColor: blackColor,
          ),
          child: Text('Войти', style: headerTextStyleWhite)));

  Column SignInTextFields(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350, maxHeight: 55),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text('Логин', style: headerTextStyleBlack),
                ),
                const Expanded(
                  flex: 3,
                  child: Text(''),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350, maxHeight: 55),
          child: TextFormField(
            controller: controllerUserName,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(15),
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: blackColor, width: 1),
                    borderRadius: BorderRadius.circular(10)),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: blackColor, width: 1),
                    borderRadius: BorderRadius.circular(11)),
                hintText: 'Введите логин',
                prefixIcon: const Icon(Icons.text_rotation_none),
                hintStyle: hintText),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 350, maxHeight: 55),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'Пароль',
                    style: headerTextStyleBlack,
                  ),
                ),
                const Expanded(
                  flex: 3,
                  child: Text(''),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350, maxHeight: 55),
            child: TextFormField(
              controller: controllerPassword,
              textAlign: TextAlign.left,
              obscureText: true,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  alignLabelWithHint: true,
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: blackColor, width: 1),
                      borderRadius: BorderRadius.circular(10)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: blackColor, width: 1),
                      borderRadius: BorderRadius.circular(11)),
                  hintText: 'Введите пароль',
                  prefixIcon: const Icon(Icons.key),
                  hintStyle: hintText),
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
      ],
    );
  }
}
