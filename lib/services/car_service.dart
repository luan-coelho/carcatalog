import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:carshop/models/car.dart';

class CarService {
  final String _baseUrl = "http://localhost:3000";

  Future<List<Car>> getAllCars() async {
    final response = await http.get(Uri.parse("$_baseUrl/cars"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Car.fromJson(json)).toList();
    } else {
      throw Exception('Error loading data');
    }
  }

  Future<Car> getCarById(int id) async {
    final response = await http.get(Uri.parse("$_baseUrl/cars/$id"));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return Car.fromJson(jsonResponse);
    } else {
      throw Exception('Error when searching car by id');
    }
  }
}
