import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:carshop/models/car.dart';

class CarService {
  final String _baseUrl = "http://localhost:3000";

  Future<List<Car>> getAll() async {
    final response = await http.get(Uri.parse("$_baseUrl/cars"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Car.fromJson(json)).toList();
    } else {
      throw Exception('Error loading data');
    }
  }

  Future<Car> getById(int id) async {
    final response = await http.get(Uri.parse("$_baseUrl/cars/$id"));

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      return Car.fromJson(jsonResponse);
    } else {
      throw Exception('Error when searching car by id');
    }
  }

  Future<bool> create(Car car) async {
    Map<String, dynamic> carMap = car.toMap();
    String json = jsonEncode(carMap);

    final response = await http.post(Uri.parse("$_baseUrl/cars/"), body: json);

    if (response.statusCode != 200 || response.statusCode != 201) {
      return false;
    }
    return true;
  }
}
