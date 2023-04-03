import 'dart:convert';

import 'package:carshop/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryService {
  final String _baseUrl = "http://localhost:8080";

  Future<List<Category>> getAll() async {
    final response = await http.get(Uri.parse("$_baseUrl/categories"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Category.fromJson(json)).toList();
    } else {
      throw Exception('Error loading data');
    }
  }
}
