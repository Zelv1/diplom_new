// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'dart:developer';

import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/pages/sign_in_page/sign_in_page.dart';
import 'package:diplom_new/util/color.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:diplom_new/util/underline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VendorProfile extends StatefulWidget {
  const VendorProfile({Key? key});

  @override
  _VendorProfileState createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccessState) {
          log(state.user.vendor!.image.toString());
          return Scaffold(
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).padding.bottom,
                    ),
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            height: 200,
                            child: ClipOval(
                              child: Image.network(
                                state.user.vendor!.image.toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.02),
                          Text(
                            state.user.vendor!.nameOfOrganization,
                            style: authTag,
                          ),
                          SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.03),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(Icons.edit),
                            title: Text('Редактировать профиль',
                                style: headerTextStyleBlack),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () {},
                          ),
                          GrayLine(context),
                          ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text('Изменить адрес',
                                style: headerTextStyleBlack),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () {},
                          ),
                          GrayLine(context),
                          ListTile(
                            leading: const Icon(Icons.lock),
                            title: Text('Изменить пароль',
                                style: headerTextStyleBlack),
                            trailing:
                                const Icon(Icons.arrow_forward_ios_rounded),
                            onTap: () {},
                          ),
                          GrayLine(context),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: lightWhite,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: greyColor.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title:
                        Text('Выйти из аккаунта', style: headerTextStyleBlack),
                    onTap: () {
                      context.read<AuthBloc>().add(AuthLogoutEvent());
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignInPage()),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  // ignore: non_constant_identifier_names
  ConstrainedBox GrayLine(BuildContext context) {
    return ConstrainedBox(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.95),
        child: const UnderLine());
  }
}
