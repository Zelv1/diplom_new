import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';
import 'package:diplom_new/features/models/order_model/order_model.dart';

class GetOrderDataCourierHistoryRepository {
  final String token;
  final int courierId;
  GetOrderDataCourierHistoryRepository(this.token, this.courierId);

  Future<List<OrderModel>> getOrderDataCourierHistory() async {
    List<OrderModel> result = [];
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/courier/$courierId/personal_history/'),
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 200) {
        final decodedOrderData = json.decode(utf8.decode(response.bodyBytes));
        for (var index in decodedOrderData) {
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
