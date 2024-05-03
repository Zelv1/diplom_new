import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';
import 'package:diplom_new/features/models/order_model/order_model.dart';

class GetOrderDataRepository {
  final String token;
  final String orderId;
  GetOrderDataRepository(this.token, this.orderId);

  Future<OrderModel> getOrderDataSingle() async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/order/$orderId/'),
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
        return OrderModel.fromJson(jsonResponse);
      } else {
        throw response.statusCode.toString();
      }
    } catch (e) {
      throw 'Ошибка во время выполнения запроса: $e';
    }
  }
}
