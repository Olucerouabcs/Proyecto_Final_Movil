import 'package:flutter/material.dart';
import 'login/login_screen.dart';
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
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
