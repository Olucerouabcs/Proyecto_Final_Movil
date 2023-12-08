import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../profile/profile_screen.dart';

class RentalsScreen extends StatelessWidget {
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
                  // Resto de las secciones
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
        // Aquí puedes manejar la navegación entre las secciones
        onTap: (index) {
          switch (index) {
            case 0:
              // Navegar a la sección de "Autos"
              Navigator.popUntil(context,
                  ModalRoute.withName('/')); // Regresa a la pantalla principal
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
              break;
            case 1:
              // Navegar a la pantalla de "Rentas"
              Navigator.popUntil(context,
                  ModalRoute.withName('/')); // Regresa a la pantalla principal
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RentalsScreen()),
              );
              break;
            case 2:
              // Navegar a la sección de "Perfil"
              Navigator.popUntil(context,
                  ModalRoute.withName('/')); // Regresa a la pantalla principal
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              break;
          }
        },
      ),
    );
  }
}
