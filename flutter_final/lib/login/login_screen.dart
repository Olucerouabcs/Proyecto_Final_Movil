import 'package:flutter/material.dart';
import '../database/db.dart';
import 'package:sqflite/sqflite.dart';
import '../register/register_screen.dart';
import '../password_recovery/forgot_password_screen.dart';
import '../home/home_screen.dart';

class LoginScreen extends StatelessWidget {
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
              color: Colors.white.withOpacity(0.67),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Image.asset(
                      'assets/AutoExpress_logo.png',
                      height: 100.0,
                    ),
                    LoginForm(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      Database db = await DB.openDB();
      print("Ruta de la base de datos: ${await getDatabasesPath()}");

      List<Map<String, dynamic>> result = await db.rawQuery(
        'SELECT id FROM Clients WHERE email = ? AND password = ?',
        [_emailController.text, _passwordController.text],
      );
      print(_emailController.text);
      print(_passwordController.text);

      if (result.isNotEmpty) {
        int userId = result[0]['id'];
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(userId: userId),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Correo electrónico o contraseña incorrectos.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Inicie sesión y comience la aventura',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Correo Electrónico',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese su correo electrónico';
              } else if (!RegExp(
                      r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                  .hasMatch(value)) {
                return 'Ingrese un correo electrónico válido';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Contraseña',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese su contraseña';
              } else if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              } else if (!RegExp(r'^(?=.*[A-Z])(?=.*\d).*$').hasMatch(value)) {
                return 'La contraseña debe contener al menos una mayúscula y un número';
              }
              return null;
            },
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ForgotPasswordScreen()),
                );
              },
              child: Text('¿Olvidó su contraseña?'),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _login,
            child: Text('Ingresar'),
            style: ElevatedButton.styleFrom(
              primary: Color(0xFF5063BF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('¿Eres nuevo usuario?'),
              SizedBox(width: 4),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text('Crear cuenta'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
