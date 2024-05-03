import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';
import 'package:diplom_new/features/models/user_model/user_model.dart';

class GetUserDataRepository {
  final String token;
  GetUserDataRepository(this.token);

  Future<UserModel> getUserData() async {
    try {
      final response = await http.get(
        Uri.parse('$BASE_URL/auth/users/me/'),
        headers: {'Authorization': 'Token $token'},
      );
      if (response.statusCode == 200) {
        final decodedUserData = utf8.decode(response.bodyBytes);
        return UserModel.fromJson(jsonDecode(decodedUserData));
      } else {
        throw response.statusCode.toString();
      }
    } catch (e) {
      throw 'Ошибка во время выполнения запроса: $e';
    }
  }
}
