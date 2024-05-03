import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';
import 'package:diplom_new/features/models/order_model/order_model.dart';

class GetOrderDataCourierRepository {
  final String token;
  GetOrderDataCourierRepository(this.token);

  Future<List<OrderModel>> getOrderDataCourier() async {
    List<OrderModel> result = [];
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/order/waiting_orders/'),
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        for (var index in jsonResponse) {
          result.add(OrderModel.fromJson(index));
          log(result.toString());
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
