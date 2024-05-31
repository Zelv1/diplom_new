import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

IconData getPaymentIcon(String payment) {
  switch (payment) {
    case '1':
      return Icons.credit_card;
    case '2':
      return Icons.account_balance_wallet;
    default:
      return Icons.done;
  }
}

String getPaymentMethod(String payment) {
  switch (payment) {
    case '1':
      return 'Терминал';
    case '2':
      return 'Наличные';
    default:
      return '';
  }
}

String getOrderState(String state) {
  switch (state) {
    case '1':
      return 'Обрабатывается';
    case '2':
      return 'В пути';
    case '3':
      return 'Доставлен';
    default:
      return 'Инвалид';
  }
}

String formatTime(String receivedDate) {
  DateTime dateTime = DateTime.parse(receivedDate);
  DateTime localDateTime = dateTime.toLocal();
  DateFormat timeFormat = DateFormat('HH:mm');
  String formattedTime = timeFormat.format(localDateTime);
  return formattedTime;
}

bool sortTimeForHistory(String date) {
  DateTime dateTime = DateTime.parse(date);
  DateTime localDateTime = dateTime.toLocal();

  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(const Duration(days: 1));

  if (localDateTime.year == now.year &&
      localDateTime.month == now.month &&
      localDateTime.day == now.day) {
    return true;
  } else if (localDateTime.year == yesterday.year &&
      localDateTime.month == yesterday.month &&
      localDateTime.day == yesterday.day) {
    return true;
  } else {
    return false;
  }
}

String getGoodType(String goodType) {
  switch (goodType) {
    case '1':
      return 'Скоропортящийся';
    case '2':
      return 'Насыпной';
    case '3':
      return 'Генеральный';
    case '4':
      return 'Негабаритный';
    case '5':
      return 'Газообразный';
    case '6':
      return 'Пылевидный';
    case '7':
      return 'Наливной';
    case '8':
      return 'Опасный';
    default:
      return '';
  }
}
