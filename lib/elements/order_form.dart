// ignore_for_file: library_private_types_in_public_api

import 'package:diplom_new/bloc/create_order_bloc/create_order_bloc.dart';
import 'package:diplom_new/util/regex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diplom_new/util/text_styles.dart';

class OrderFormWidget extends StatefulWidget {
  const OrderFormWidget({super.key});

  @override
  _OrderFormWidgetState createState() => _OrderFormWidgetState();
}

class _OrderFormWidgetState extends State<OrderFormWidget> {
  final Map<String, String> _productTypes = {
    '1': 'Скоропортящийся',
    '2': 'Насыпной',
    '3': 'Генеральный',
    '4': 'Негабаритный',
    '5': 'Газообразный',
    '6': 'Пылевидный',
    '7': 'Наливной',
    '8': 'Опасный',
  };
  String? _selectedProductType;

  final Map<String, String> _paymentMethods = {
    '1': 'Терминал',
    '2': 'Наличные',
  };
  String? _selectedPaymentMethod;

  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CreateOrderBloc, CreateOrderBlocState>(
        builder: (context, state) {
          if (state is CreateOrderBlocInitial) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(child: buildOrderFormFields(context)),
                  buildPublishOrderButton(),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  SingleChildScrollView buildOrderFormFields(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextFormField(
                _addressController, 'Укажите адрес', true, addressRegex),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            buildTextFormField(_phoneNumberController, 'Номер телефона', true,
                phoneNumberRegex),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            buildDropdownButtonField(
                'Выберите тип товара:', _productTypes, _selectedProductType,
                (String? value) {
              setState(() {
                _selectedProductType = value;
              });
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            buildDropdownButtonField('Выберите способ оплаты:', _paymentMethods,
                _selectedPaymentMethod, (String? value) {
              setState(() {
                _selectedPaymentMethod = value;
              });
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            buildTextFormField(_commentsController, 'Комментарий', false),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String labelText,
      [bool validate = true, String? regexPattern]) {
    return TextFormField(
      controller: controller,
      validator: validate
          ? (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, укажите $labelText';
              } else if (regexPattern != null &&
                  !RegExp(regexPattern).hasMatch(value)) {
                return 'Пожалуйста, введите корректный $labelText';
              }
              return null;
            }
          : null,
      decoration: InputDecoration(
        labelText: labelText,
      ),
    );
  }

  void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: headerTextStyleWhite,
        ),
      ),
    );
  }

  Widget buildDropdownButtonField(String labelText, Map<String, String> items,
      String? selectedItem, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            labelText,
            style: headerTextStyleBlack,
            maxLines: 1,
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          Flexible(
            child: DropdownButton<String>(
              value: selectedItem,
              onChanged: onChanged,
              isExpanded: true,
              items: items.keys.map((String itemKey) {
                return DropdownMenuItem<String>(
                  value: itemKey,
                  child: Text(
                    items[itemKey]!,
                    maxLines: 1,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPublishOrderButton() {
    return Container(
      width: 350,
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: FilledButton.tonal(
        style: FilledButton.styleFrom(
            fixedSize: const Size(350, 55),
            shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          if (_formKey.currentState!.validate() &&
              _selectedProductType != null &&
              _selectedPaymentMethod != null) {
            context.read<CreateOrderBloc>().add(CreateOrderEvent(
                  _addressController.text,
                  _selectedPaymentMethod!,
                  _phoneNumberController.text,
                  _selectedProductType!,
                  _commentsController.text,
                ));
          } else {
            showSnackBarMessage(
                context, 'Пожалуйста, заполните все обязательные поля');
          }
        },
        child: Text('Опубликовать', style: headerTextStyleWhite),
      ),
    );
  }
}
