import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../rentals/rentals_screen.dart';
import '../login/login_screen.dart'; // Importa la pantalla de inicio de sesión

class ProfileScreen extends StatelessWidget {
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      // Agregar aquí la lógica para cerrar sesión
                      // Por ejemplo, podrías mostrar un cuadro de diálogo de confirmación
                      // y luego navegar a la pantalla de inicio de sesión
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Cerrar sesión'),
                            content: Text(
                                '¿Estás seguro de que quieres cerrar sesión?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Aquí puedes agregar la lógica para cerrar sesión
                                  // Por ejemplo, limpiar el estado de autenticación
                                  // y luego navegar a la pantalla de inicio de sesión
                                  Navigator.of(context)
                                      .pop(); // Cerrar el cuadro de diálogo
                                  Navigator.popUntil(
                                      context, ModalRoute.withName('/'));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                  );
                                },
                                child: Text('Cerrar sesión'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Color rojo
                    ),
                    child: Text('Cerrar sesión'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
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
