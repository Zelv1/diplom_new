import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';

class ChangeStatusOrderClaim {
  final String orderId;
  final String token;
  ChangeStatusOrderClaim(this.orderId, this.token);

  Future<String> changeStatusOrderClaim() async {
    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/order/$orderId/claim_order/'),
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 200) {
        final decodedResponse = utf8.decode(response.bodyBytes);
        return decodedResponse;
      } else {
        throw response.statusCode.toString();
      }
    } catch (e) {
      throw 'Ошибка во время выполнения запроса: $e';
    }
  }
}
