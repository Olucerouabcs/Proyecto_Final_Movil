import 'package:flutter/material.dart';
import '../profile/profile_screen.dart';
import '../home/home_screen.dart';
import '../database/db.dart';
import '../database/vehicleRentals.dart';

class RentalsScreen extends StatelessWidget {
  final int userId;

  RentalsScreen({required this.userId});

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
                  SizedBox(height: 20.0),
                  Text(
                    'Lista de Rentas',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  FutureBuilder(
                    future: DB.getVehicleRentals(userId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData ||
                          (snapshot.data as List).isEmpty) {
                        return Text('No hay rentas disponibles.');
                      } else {
                        List<VehicleRental> rentals =
                            snapshot.data as List<VehicleRental>;

                        return Expanded(
                          child: ListView.builder(
                            itemCount: rentals.length,
                            itemBuilder: (context, index) {
                              VehicleRental rental = rentals[index];

                              return ListTile(
                                title: Text(
                                    'Vehículo: ${rental.idVehicle}, Total: \$${rental.total}'),
                                subtitle: Text(
                                    'Cliente: ${rental.idClient}, Fecha Inicio: ${rental.initialDay}, Fecha Entrega: ${rental.deliveryDay}'),
                                // Agrega más información si es necesario
                                // ...
                              );
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
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
              // Navegar a la sección de "Autos"
              Navigator.popUntil(context,
                  ModalRoute.withName('/')); // Regresa a la pantalla principal
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(userId: userId)),
              );
              break;
            case 1:
              // Navegar a la pantalla de "Rentas"
              Navigator.popUntil(context,
                  ModalRoute.withName('/')); // Regresa a la pantalla principal
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RentalsScreen(userId: userId)),
              );
              break;
            case 2:
              // Navegar a la sección de "Perfil"
              Navigator.popUntil(context,
                  ModalRoute.withName('/')); // Regresa a la pantalla principal
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
