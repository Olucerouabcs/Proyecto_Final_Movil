class Vehicle {
  int id;
  String model;
  String brand;
  String category;
  int rate;
  bool isAvailable;

  Vehicle({
    required this.id,
    required this.model,
    required this.brand,
    required this.category,
    required this.rate,
    required this.isAvailable,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'model': model,
      'brand': brand,
      'category': category,
      'rate': rate,
      'is_available': isAvailable,
    };
  }
}
