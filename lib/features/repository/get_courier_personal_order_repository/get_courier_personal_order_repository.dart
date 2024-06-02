import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';
import 'package:diplom_new/features/models/order_model/order_model.dart';

class GetCourierPersonalOrderRepository {
  final String token;
  final String courierId;
  GetCourierPersonalOrderRepository(this.token, this.courierId);

  Future<List<OrderModel>> getPersonalOrderCourier() async {
    List<OrderModel> result = [];
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/courier/$courierId/personal_orders/'),
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        for (var index in jsonResponse) {
          result.add(OrderModel.fromJson(index));
        }

        return result;
      } else {
        throw response.statusCode.toString();
      }
    } catch (e) {
      throw 'Ошибка во время выполнения запроса: $e';
    }
  }
}
