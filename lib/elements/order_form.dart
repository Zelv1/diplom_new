import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diplom_new/bloc/auth_bloc/auth_bloc.dart';
import 'package:diplom_new/bloc/get_order_info_bloc/get_order_info_bloc.dart';
import 'package:diplom_new/util/color.dart';
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
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(child: buildOrderFormFields(context)),
                  buildPublishOrderButton(state.user.vendor!.id.toString()),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text('что-то пошло не так'),
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
            buildTextFormField(_addressController, 'Укажите адрес', true,
                r'^(г\.?\s?[А-Яа-я]+,\s*)?(ул\.|пр-т|пер\.)\s?[А-Яа-я]+[А-Яа-я\d\s\-]*\s*,\s*\d{1,3}(?:\\\d{1})?$'),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            buildTextFormField(_phoneNumberController, 'Номер телефона', true,
                r'^\+?375\(?([0-9]{2})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{2})[-. ]?([0-9]{2})$'),
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(labelText, style: headerTextStyleBlack),
          SizedBox(width: MediaQuery.of(context).size.width * 0.02),
          DropdownButton<String>(
            value: selectedItem,
            onChanged: onChanged,
            style: headerTextStyleBlack,
            items: items.keys.map((String itemKey) {
              return DropdownMenuItem<String>(
                value: itemKey,
                child: Text(items[itemKey]!),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget buildPublishOrderButton(String vendor) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        color: blackColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate() &&
              _selectedProductType != null &&
              _selectedPaymentMethod != null) {
            context.read<GetOrderInfoBloc>().add(CreateOrderEvent(
                  vendor,
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
        style: ElevatedButton.styleFrom(
          backgroundColor: blackColor,
        ),
        child: Text('Опубликовать', style: mainTextStyleWhite),
      ),
    );
  }
}
