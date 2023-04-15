import 'package:car_catalog_client/models/brand.dart';
import 'package:car_catalog_client/models/category.dart';
import 'package:car_catalog_client/models/fueltype.dart';

class Car {
  late int id;
  String model;
  int year;
  FuelType fuelType;
  double price;
  String description;
  Brand brand;
  Category category;

  Car({ required this.model,
        required this.year,
        required this.fuelType,
        required this.price,
        required this.description,
        required this.brand,
        required this.category,
      });

  Car.factory(
    this.id, {
    required this.model,
    required this.year,
    required this.fuelType,
    required this.price,
    required this.description,
    required this.brand,
    required this.category,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car.factory(
      json['id'],
      model: json['model'],
      year: json['year'],
      fuelType: FuelType.fromJson(json['fuelType']),
      price: json['price'].toDouble(),
      description: json['description'],
      brand: Brand.fromJson(json['brand']),
      category: Category.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'model': model,
      'year': year,
      'fuelType': fuelType.toMap(),
      'price': price,
      'description': description,
      'brand': brand.toMap(),
      'category': category.toMap(),
    };
  }
}
