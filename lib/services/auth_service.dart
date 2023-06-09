import 'dart:convert';

import 'package:car_catalog_client/config/global_config.dart';
import 'package:car_catalog_client/dto/register_request.dart';
import 'package:http/http.dart' as http;

class AuthService {
  Future<bool> validateLogin(String login, String password) async {
    Map<String, String> authRequest = {'login': login, 'password': password};
    String body = jsonEncode(authRequest);

    final response = await http.post(
        Uri.parse("${GlobalConfig.apiBaseUrl}/auth/login"),
        body: body,
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> register(RegisterRequest request) async {
    String body = jsonEncode(request.toMap());

    final response = await http.post(
        Uri.parse("${GlobalConfig.apiBaseUrl}/auth/register"),
        body: body,
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
