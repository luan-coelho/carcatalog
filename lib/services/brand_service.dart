import 'dart:convert';

import 'package:car_catalog_client/config/global_config.dart';
import 'package:http/http.dart' as http;

import '../models/brand.dart';

class BrandService {
  Future<List<Brand>> getAll() async {
    final response = await http.get(Uri.parse("${GlobalConfig.apiBaseUrl}/brands"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Brand.fromJson(json)).toList();
    } else {
      throw Exception('Error loading data');
    }
  }
}
