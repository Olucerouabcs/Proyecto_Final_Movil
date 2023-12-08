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

  // Método toMap para convertir el objeto a un mapa
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

  // Puedes agregar más métodos, getters, setters según sea necesario
}
