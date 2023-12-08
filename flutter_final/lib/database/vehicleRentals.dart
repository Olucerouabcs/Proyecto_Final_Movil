class VehicleRental {
  int? id;
  int idClient;
  int idVehicle;
  int total;
  DateTime initialDay;
  DateTime deliveryDay;
  String paymentMethod;

  VehicleRental({
    this.id,
    required this.idClient,
    required this.idVehicle,
    required this.total,
    required this.initialDay,
    required this.deliveryDay,
    required this.paymentMethod,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'idClient': idClient,
      'idVehicle': idVehicle,
      'total': total,
      'initialDay': initialDay.toIso8601String(),
      'deliveryDay': deliveryDay.toIso8601String(),
      'paymentMethod': paymentMethod,
    };
  }
}
