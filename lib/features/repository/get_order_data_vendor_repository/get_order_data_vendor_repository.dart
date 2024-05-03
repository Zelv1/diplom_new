import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';
import 'package:diplom_new/features/models/order_model/order_model.dart';

class GetOrderDataVendorRepository {
  final String token;
  final int vendorId;
  GetOrderDataVendorRepository(this.token, this.vendorId);

  Future<List<OrderModel>> getOrderDataVendor() async {
    List<OrderModel> result = [];
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/vendor/$vendorId/personal_orders/'),
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
