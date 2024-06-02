import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/bloc/edit_profile_data_bloc/edit_profile_data_bloc.dart';
import 'package:diplom_new/elements/message_dialog.dart';

import 'package:diplom_new/features/models/user_model/user_model.dart';
import 'package:diplom_new/pages/main_page/main_page_vendor.dart';
import 'package:diplom_new/util/regex.dart';
import 'package:diplom_new/util/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class EditProfilePage extends StatelessWidget {
  final UserModel userModel;
  EditProfilePage({
    required this.userModel,
    super.key,
  });

  final TextEditingController controllerUserName = TextEditingController();
  String? inputFormatter;
  String? userEditData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          onPressed: () => {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => const MainPageVendor()),
            ),
          },
        ),
      ),
      body: BlocSelector<EditProfileDataBloc, EditProfileDataState, String?>(
        selector: (state) {
          if (state is EditAddressState) {
            userEditData = userModel.vendor!.address;
            inputFormatter = addressRegex;
          } else if (state is EditNameState) {
            userEditData = userModel.vendor!.nameOfOrganization;
            inputFormatter = organizationNameRegex;
          } else if (state is EditNumberState) {
            userEditData = userModel.vendor!.phoneNumber;
            inputFormatter = phoneNumberRegex;
          }
          return userEditData;
        },
        builder: (context, state) {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    'Внесите новые данные',
                    style: headerTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ConstrainedBox(
                    constraints:
                        const BoxConstraints(maxWidth: 350, maxHeight: 60),
                    child: TextFormField(
                      controller: controllerUserName,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(15),
                          alignLabelWithHint: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(11)),
                          hintText: userEditData,
                          prefixIcon: const Icon(Icons.edit_square),
                          hintStyle: const TextStyle(color: Colors.grey)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: SizedBox(
                    width: 350,
                    child: Center(
                      child: Text(
                        'Выше отображаются данные, которое вы собираетесь редактировать, внестите новое значение или покиньте страницу',
                        textAlign: TextAlign.justify,
                        maxLines: null,
                        style: hintText,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40, bottom: 20),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: FilledButton.tonal(
                      style: FilledButton.styleFrom(
                          fixedSize: const Size(350, 55),
                          shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        if (controllerUserName.text.isEmpty) {
                          showMessageDialog(
                              context, 'Пожалуйста, укажите значение');
                        } else if (inputFormatter == null ||
                            !RegExp(inputFormatter!)
                                .hasMatch(controllerUserName.text)) {
                          showMessageDialog(
                              context, 'Пожалуйста, заполните поле коректно');
                        } else {
                          context.read<EditProfileDataBloc>().add(
                              EditProfileEvent(
                                  newData: controllerUserName.text));
                          Navigator.pop(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainPageVendor()),
                          );

                          showMessageDialog(
                              context, 'Изменения внесены успешно');
                          context.read<AuthBloc>().add(AuthCheckCacheEvent());
                        }
                      },
                      child: Text('Внести изменения', style: headerTextStyle),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
