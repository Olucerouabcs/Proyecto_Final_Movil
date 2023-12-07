import 'package:flutter/material.dart';
import 'login/login_screen.dart'; // Asegúrate de importar la pantalla de inicio de sesión
import 'register/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AutoExpress App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login', // Ruta inicial
      routes: {
        '/login': (context) =>
            LoginScreen(), // Ruta para la pantalla de inicio de sesión
        '/register': (context) =>
            RegisterScreen(), // Ruta para la pantalla de registro
        // Agrega más rutas según sea necesario
      },
    );
  }
}
