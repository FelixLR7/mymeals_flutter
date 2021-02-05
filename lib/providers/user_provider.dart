import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'package:project_test/providers/base_provider.dart';

class UserProvider extends BaseProvider {
  static final secret = 'VsUE2j6pbu';
  String authUrl = BaseProvider.url + 'auth/';
  String signUpUrl = 'sociallogin';
  String logoutUrl = 'logout';

  UserProvider() : super();

  Future<bool> createUser(String email, String name, String accessToken) async {
    bool response = false;
    final hash =
        sha256.convert(utf8.encode('VsUE2j6pbu' + email + name)).toString();
    final json = jsonEncode(
        {"name": name, "email": email, "hash": hash, "token": accessToken});

    final apiRes = await http.post(
      BaseProvider.url + signUpUrl,
      headers: headers,
      body: json,
    );

    final Map<String, dynamic> jsonRes = jsonDecode(apiRes.body);

    if (jsonRes.containsKey('access_token')) {
      BaseProvider.preferences.token = jsonRes['access_token'];
      response = true;
    }

    return response;
  }

  Future<bool> logout() async {
    // final apiRes = await http.get(
    //   BaseProvider.url + logoutUrl,
    //   headers: headers,
    // );
    BaseProvider.preferences.token = '';

    return true;
  }
}
