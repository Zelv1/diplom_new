// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/bloc/edit_profile_data_bloc/edit_profile_data_bloc.dart';
import 'package:diplom_new/elements/edit_profile_page.dart';
import 'package:diplom_new/pages/sign_in_page/sign_in_page.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:diplom_new/util/underline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class VendorProfile extends StatefulWidget {
  const VendorProfile({Key? key});

  @override
  _VendorProfileState createState() => _VendorProfileState();
}

class _VendorProfileState extends State<VendorProfile> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  void onRefresh() {
    context.read<AuthBloc>().add(AuthCheckCacheEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccessState) {
          return SmartRefresher(
            enablePullDown: true,
            onRefresh: onRefresh,
            controller: _refreshController,
            child: Scaffold(
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
                              onTap: () {
                                context
                                    .read<EditProfileDataBloc>()
                                    .add(EditNameEvent());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfilePage(
                                              userModel: state.user,
                                            )));
                              },
                            ),
                            GrayLine(context),
                            ListTile(
                              leading: const Icon(Icons.location_on),
                              title: Text('Изменить адрес',
                                  style: headerTextStyleBlack),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                              onTap: () {
                                context
                                    .read<EditProfileDataBloc>()
                                    .add(EditAddressEvent());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfilePage(
                                              userModel: state.user,
                                            )));
                              },
                            ),
                            GrayLine(context),
                            ListTile(
                              leading: const Icon(Icons.numbers),
                              title: Text('Изменить номер организации',
                                  style: headerTextStyleBlack),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios_rounded),
                              onTap: () {
                                context
                                    .read<EditProfileDataBloc>()
                                    .add(EditNumberEvent());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditProfilePage(
                                              userModel: state.user,
                                            )));
                              },
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
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.background,
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: Text('Выйти из аккаунта',
                          style: headerTextStyleBlack),
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
