import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';

class ChangeNameOrganizationRepository {
  final String vendorId;
  final String newName;
  final String token;

  ChangeNameOrganizationRepository(this.newName, this.vendorId, this.token);

  Future<String> changeName() async {
    try {
      final response = await http.patch(
        Uri.parse('$BASE_URL/vendor/$vendorId/update_name_of_organization/'),
        headers: {'Authorization': 'Token $token'},
        body: {'address': newName},
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
