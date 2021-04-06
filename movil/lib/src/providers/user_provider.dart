import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movil/src/Userpreferences/user_preferences.dart';
import 'package:movil/src/providers/http_complements.dart';

class UserProvider {
  final _prefs = new UserPreferences();

  Future<Map<String, dynamic>> singIn(String username, String password) async {
    final authData = {
      'username': username,
      'password': password,
      'accessToken': true
    };
    final resp = await http.post(uriSingIn(),
        headers: headerContent(), body: json.encode(authData));

    Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('accessToken')) {
      _prefs.accessToken = decodedResp['accessToken'];
      return {'ok': true, 'accessToken': decodedResp['accessToken']};
    } else {
      return {'ok': false, 'error': decodedResp['message']};
    }
  }
}
