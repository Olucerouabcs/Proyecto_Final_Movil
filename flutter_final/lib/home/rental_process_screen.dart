import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../home/home_screen.dart';
import '../rentals/rentals_screen.dart';
import '../profile/profile_screen.dart';
import 'package:flutter_final/database/vehicleRentals.dart';
import 'package:flutter_final/database/clients.dart';
import '../database/db.dart';
import 'package:sqflite/sqflite.dart';

class RentalProcessScreen extends StatefulWidget {
  final int userId;
  final Vehicle selectedVehicle;

  RentalProcessScreen({
    required this.userId,
    required this.selectedVehicle,
  });
  @override
  _RentalProcessScreenState createState() => _RentalProcessScreenState();
}

class _RentalProcessScreenState extends State<RentalProcessScreen> {
  late DateTime startDate;
  late DateTime endDate;
  int selectedDays = 1;
  final double ratePerDay = 400.0;
  String selectedPaymentMethod = 'Efectivo';

  _RentalProcessScreenState() {
    startDate = DateTime.now();
    endDate = startDate.add(Duration(days: selectedDays));
  }
  Future<void> saveRental() async {
    Client client;
    try {
      client = await DB.getClientById(widget.userId);
    } catch (e) {
      print('Error al obtener el cliente: $e');
      return;
    }

    Vehicle selectedVehicle = widget.selectedVehicle;

    double total = calculateTotal(startDate, endDate, ratePerDay);

    VehicleRental rental = VehicleRental(
      idClient: widget.userId,
      idVehicle: 1,
      total: total.toInt(),
      initialDay: startDate,
      deliveryDay: endDate,
      paymentMethod: selectedPaymentMethod,
    );

    try {
      await DB.insertVehicleRental(rental);
      print('Renta guardada con éxito');
    } catch (e) {
      print('Error al guardar la renta: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    startDate = DateTime.now();
    endDate = startDate.add(Duration(days: selectedDays));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AutoExpress - Rentar Vehículo'),
      ),
      body: Container(
        color: Color(0xFF69B5F4),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.90),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/AutoExpress_logo.png',
                    height: 80.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Crear Renta de Vehículo',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Vehículo: ${widget.selectedVehicle.model} ${widget.selectedVehicle.brand}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Fecha de Préstamo: ${DateFormat('yyyy-MM-dd').format(startDate)}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: startDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != startDate) {
                        setState(() {
                          selectedDays = 1;
                          endDate = picked.add(Duration(days: selectedDays));
                          selectedDays = calculateDays(startDate, endDate);
                        });
                      }
                    },
                    child: Text('Seleccionar Fecha de Entrega'),
                  ),
                  Builder(
                    builder: (BuildContext context) {
                      DateTime displayEndDate =
                          endDate.subtract(Duration(days: 1));
                      return Text(
                        'Fecha de Entrega: ${DateFormat('yyyy-MM-dd').format(displayEndDate)}',
                        style: TextStyle(fontSize: 16.0),
                      );
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Días: $selectedDays',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Tarifa Diaria: \$${ratePerDay.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Método de Pago:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  DropdownButton<String>(
                    value: selectedPaymentMethod,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPaymentMethod = newValue!;
                      });
                    },
                    items: <String>['Efectivo', 'Tarjeta', 'Transferencia']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Total: \$${calculateTotal(startDate, endDate, ratePerDay).toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Cancelar
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(userId: widget.userId)),
                          );
                        },
                        child: Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RentalsScreen(userId: widget.userId)),
                          );
                        },
                        child: Text('Guardar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.car_rental),
            label: 'Autos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Rentas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          switch (index) {
            case 0:
              break;
            case 1:
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RentalsScreen(userId: widget.userId)),
              );
              break;
            case 2:
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(userId: widget.userId)),
              );
              break;
          }
        },
      ),
    );
  }

  int calculateDays(DateTime startDate, DateTime endDate) {
    if (endDate.isBefore(startDate)) {
      return 0;
    }

    return endDate.difference(startDate).inDays;
  }

  double calculateTotal(
      DateTime startDate, DateTime endDate, double ratePerDay) {
    int days = calculateDays(startDate, endDate);
    return days * ratePerDay;
  }
}
