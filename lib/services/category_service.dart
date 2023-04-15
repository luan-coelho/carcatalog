import 'dart:convert';

import 'package:car_catalog_client/models/category.dart';
import 'package:http/http.dart' as http;

import '../config/global_config.dart';

class CategoryService {

  Future<List<Category>> getAll() async {
    final response = await http.get(Uri.parse("${GlobalConfig.apiBaseUrl}/categories"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Error loading data');
    }
  }
}
