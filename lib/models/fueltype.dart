class FuelType {
  int id;
  String name;

  FuelType({
    required this.id,
    required this.name,
  });

  factory FuelType.fromJson(Map<String, dynamic> json) {
    return FuelType(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
