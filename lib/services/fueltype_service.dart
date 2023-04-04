import 'dart:convert';

import 'package:carshop/models/fueltype.dart';
import 'package:http/http.dart' as http;

class FuelTypeService {
  final String _baseUrl = "http://localhost:8080";

  Future<List<FuelType>> getAll() async {
    final response = await http.get(Uri.parse("$_baseUrl/fueltype"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => FuelType.fromJson(json)).toList();
    } else {
      throw Exception('Error loading data');
    }
  }
}
