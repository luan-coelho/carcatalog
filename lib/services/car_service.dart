import 'dart:async';
import 'dart:convert';

import 'package:car_catalog_client/models/car.dart';
import 'package:http/http.dart' as http;

import '../config/global_config.dart';

class CarService {

  Future<List<Car>> getAll() async {
    final response = await http.get(Uri.parse("${GlobalConfig.apiBaseUrl}/cars"));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse.map((json) => Car.fromJson(json)).toList();
    } else {
      throw Exception('Error loading data');
    }
  }

  Future<Car> getById(int id) async {
    final response = await http.get(Uri.parse("${GlobalConfig.apiBaseUrl}/cars/$id"));

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

    final response = await http.post(Uri.parse("${GlobalConfig.apiBaseUrl}/cars"),
        body: json, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> update(int carId, Car car) async {
    Map<String, dynamic> carMap = car.toMap();
    String json = jsonEncode(carMap);

    final response = await http.put(Uri.parse("${GlobalConfig.apiBaseUrl}/cars/$carId"),
        body: json, headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> deleteById(int id) async {
    final response = await http.delete(Uri.parse("${GlobalConfig.apiBaseUrl}/cars/$id"),
        headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 204) {
      return true;
    }
    return false;
  }
}
