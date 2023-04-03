import 'dart:convert';

import 'package:carshop/models/brand.dart';
import 'package:http/http.dart' as http;

class BrandService {
  final String _baseUrl = "http://localhost:3000";

  Future<List<Brand>> getAllBrands() async {
    final response = await http.get(Uri.parse("$_baseUrl/brands"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Brand> list = jsonResponse.map((json) => Brand.fromJson(json)).toList();
      return list;
    } else {
      throw Exception('Error loading data');
    }
  }
}
