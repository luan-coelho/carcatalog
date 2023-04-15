import 'dart:convert';

import 'package:car_catalog_client/models/fueltype.dart';
import 'package:http/http.dart' as http;

import '../config/global_config.dart';

class FuelTypeService {

  Future<List<FuelType>> getAll() async {
    final response = await http.get(Uri.parse("${GlobalConfig.apiBaseUrl}/fueltype"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => FuelType.fromJson(json)).toList();
    } else {
      throw Exception('Error loading data');
    }
  }
}
