import 'package:carshop/models/brand.dart';
import 'package:carshop/models/category.dart';

class Car {
  int id;
  String make;
  String model;
  int year;
  String fuelType;
  String color;
  double mileage;
  double price;
  String description;
  Brand brand;
  Category category;

  @override
  String toString() {
    return 'Car{id: $id, make: $make, model: $model, year: $year, fuelType: $fuelType, color: $color, mileage: $mileage, price: $price, description: $description, brand: $brand, category: $category}';
  }

  Car({
    required this.id,
    required this.make,
    required this.model,
    required this.year,
    required this.fuelType,
    required this.color,
    required this.mileage,
    required this.price,
    required this.description,
    required this.brand,
    required this.category,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      make: json['make'],
      model: json['model'],
      year: json['year'],
      fuelType: json['fuelType'],
      color: json['color'],
      mileage: json['mileage'].toDouble(),
      price: json['price'].toDouble(),
      description: json['description'],
      brand: Brand.fromJson(json['brand']),
      category: Category.fromJson(json['category']),
    );
  }
}
