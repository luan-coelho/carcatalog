import 'dart:convert';

import 'package:car_catalog_client/config/global_config.dart';
import 'package:http/http.dart' as http;

import '../models/brand.dart';

class AuthService {
  bool validateLogin(String login, String password) {
    if (login == 'admin' && password == 'admin') {
      return true;
    }
    return false;
  }
}
