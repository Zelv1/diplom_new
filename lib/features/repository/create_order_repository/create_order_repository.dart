import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';

class CreateOrderRepository {
  final String vendor;
  final String address;
  final String phoneNumber;
  final String token;
  final String payment;
  final String goodType;
  String review;
  CreateOrderRepository(this.vendor, this.address, this.payment,
      this.phoneNumber, this.goodType, this.review,
      {required this.token});

  Future<void> createOrder(String? token) async {
    try {
      await http.post(
        Uri.parse('$BASE_URL/order/'),
        headers: {'Authorization': 'Token $token'},
        body: {
          'IDVendor': vendor,
          'address': address,
          'payment': payment,
          'phoneNumber': phoneNumber,
          'goodType': goodType,
          'review': review,
        },
      );
    } catch (e) {
      throw 'Ошибка во время выполнения запроса: $e';
    }
  }
}
