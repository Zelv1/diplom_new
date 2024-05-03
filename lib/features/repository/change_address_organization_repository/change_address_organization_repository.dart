import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';

class ChangeAddressOrganizationRepository {
  final String vendorId;
  final String newAddress;
  final String token;

  ChangeAddressOrganizationRepository(
      this.newAddress, this.vendorId, this.token);

  Future<String> changeAddress() async {
    try {
      final response = await http.patch(
        Uri.parse('$BASE_URL/vendor/$vendorId/update_address/'),
        headers: {'Authorization': 'Token $token'},
        body: {'address': newAddress},
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
