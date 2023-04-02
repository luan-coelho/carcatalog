import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:carshop/models/car.dart';

class CarService {
  final String baseUrl = "http://localhost:3000";

  Future<List<Car>> getAllCars() async {
    final response = await http.get(Uri.parse("$baseUrl/cars"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Car.fromJson(json)).toList();
    } else {
      throw Exception('Error loading data');
    }
  }
}
