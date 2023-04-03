import 'package:carshop/models/brand.dart';
import 'package:carshop/models/category.dart';

class Car {
  int id;
  String model;
  int year;
  String fuelType;
  String color;
  double price;
  String description;
  Brand brand;
  Category category;

  Car({
    required this.id,
    required this.model,
    required this.year,
    required this.fuelType,
    required this.color,
    required this.price,
    required this.description,
    required this.brand,
    required this.category,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      model: json['model'],
      year: json['year'],
      fuelType: json['fuelType'],
      color: json['color'],
      price: json['price'].toDouble(),
      description: json['description'],
      brand: Brand.fromJson(json['brand']),
      category: Category.fromJson(json['category']),
    );
  }
}
