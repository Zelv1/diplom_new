import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:diplom_new/features/api_url.dart';
import 'package:localstore/localstore.dart';

void authRepositorySetLocalToken(String token) {
  final db = Localstore.instance;

  db.collection('secrets').doc('token').set({'token': token});
}

Future<String?> authRepositoryGetLocalToken() async {
  final db = Localstore.instance;

  final token = await db.collection('secrets').doc('token').get();
  if (token == null) {
    log(token.toString());
    return null;
  } else {
    log(token.toString());
    return token['token'];
  }
}

Future<String> authRepositoryAuthorization(
    String username, String password) async {
  try {
    final response = await http.post(
      Uri.parse('$BASE_URL/auth/token/login/'),
      body: {'username': username, 'password': password},
    );
    if (response.statusCode == 200) {
      final tokenDecoded = jsonDecode(response.body);

      authRepositorySetLocalToken(tokenDecoded['auth_token'].toString());

      return tokenDecoded['auth_token'].toString();
    } else {
      throw response.statusCode.toString();
    }
  } catch (e) {
    throw 'Ошибка во время выполнения запроса: $e';
  }
}

Future<void> deleteLocalToken() async {
  final db = Localstore.instance;
  await db.collection('secrets').doc('token').delete();
}

class AuthRepository {
  final String username;
  final String password;

  AuthRepository({this.username = '', this.password = ''});

  Future<String> authorization() async {
    try {
      final response = await http.post(
        Uri.parse('$BASE_URL/auth/token/login/'),
        body: {'username': username, 'password': password},
      );
      if (response.statusCode == 200) {
        final tokenDecoded = jsonDecode(response.body);
        setLocalToken(tokenDecoded['auth_token'].toString());
        return tokenDecoded['auth_token'].toString();
      } else {
        throw response.statusCode.toString();
      }
    } catch (e) {
      throw 'Ошибка во время выполнения запроса: $e';
    }
  }

  void setLocalToken(String token) {
    final db = Localstore.instance;

    db.collection('token').doc().set({'token': token});
  }

  Future<String> getLocalToken() async {
    final db = Localstore.instance;
    final token = await db.collection('token').get();
    return token?['token'];
  }
}
