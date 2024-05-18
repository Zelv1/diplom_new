import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';

class DeleteOrderRepository {
  final String token;
  final String orderId;

  DeleteOrderRepository(this.token, this.orderId);

  Future<String> deleteOrder() async {
    try {
      final response = await http.delete(
        Uri.parse('$BASE_URL/order/$orderId'),
        headers: {'Authorization': 'Token $token'},
      );

      if (response.statusCode == 301 || response.statusCode == 204) {
        return 'Удаление выполнено успешно';
      } else {
        throw response.statusCode.toString();
      }
    } catch (e) {
      throw 'Ошибка во время выполнения запроса: $e';
    }
  }
}
