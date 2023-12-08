import 'package:flutter/material.dart';
import '../rentals/rentals_screen.dart';
import '../profile/profile_screen.dart';
import 'rental_process_screen.dart';

class HomeScreen extends StatelessWidget {
  late final int userId;

  final List<Vehicle> vehicles = [
    Vehicle('MDX', 'Acura'),
    Vehicle('DB11', 'Acura'),
    Vehicle('ILX', 'Acura'),
    Vehicle('Civic', 'Honda'),
    Vehicle('ILX', 'Acura'),
    Vehicle('ILX', 'Acura'),
    Vehicle('ILX', 'Acura'),
    Vehicle('ILX', 'Acura'),
    Vehicle('ILX', 'Acura'),
    Vehicle('ILX', 'Acura'),
    Vehicle('ILX', 'Acura'),
    Vehicle('ILX', 'Acura'),
    Vehicle('ILX', 'Acura'),
    Vehicle('ILX', 'Acura'),
  ];

  HomeScreen({
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AutoExpress'),
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
                children: [
                  Image.asset(
                    'assets/AutoExpress_logo.png',
                    height: 100.0,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: vehicles.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.black),
                          ),
                          child: ListTile(
                            title: Text(
                              '${vehicles[index].model} ${vehicles[index].brand}',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onTap: () {
                              Navigator.popUntil(
                                  context, ModalRoute.withName('/'));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RentalProcessScreen(
                                    selectedVehicle: vehicles[index],
                                    userId: userId,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
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
                    builder: (context) => RentalsScreen(userId: userId)),
              );
              break;
            case 2:
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(userId: userId)),
              );
              break;
          }
        },
      ),
    );
  }
}

class Vehicle {
  final String model;
  final String brand;

  Vehicle(this.model, this.brand);
}
