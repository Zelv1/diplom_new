import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';

class ChangeNumberOrganizationRepository {
  final String vendorId;
  final String newPhone;
  final String token;

  ChangeNumberOrganizationRepository(
    this.token,
    this.vendorId,
    this.newPhone,
  );

  Future<String> changeNumber() async {
    try {
      final response = await http.patch(
        Uri.parse('$BASE_URL/vendor/$vendorId/update_phone_number/'),
        headers: {'Authorization': 'Token $token'},
        body: {'phoneNumber': newPhone},
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
