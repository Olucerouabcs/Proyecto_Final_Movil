import 'package:flutter/material.dart';
import '../database/db.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_final/database/clients.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
                child: Column(
                  children: [
                    Image.asset(
                      'assets/AutoExpress_logo.png',
                      height: 100.0,
                    ),
                    RegisterForm(),
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

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Obtén una referencia a la base de datos
      Database db = await DB.openDB();

      // Crea un objeto Client con los datos del formulario
      Client newClient = Client(
        name: _nameController.text,
        lastName: _lastNameController.text,
        phone: int.parse(_phoneController.text),
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Inserta el nuevo cliente en la base de datos
      int clientId = await DB.insertClient(newClient);

      if (clientId != -1) {
        // Registro exitoso, podrías realizar acciones adicionales si es necesario
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Registro exitoso. ID del usuario: $clientId'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Error en el registro
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error en el registro. Inténtelo nuevamente.'),
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
            'Rápido, fácil y siempre a tu medida',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Nombre',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese su nombre';
              } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                return 'El nombre solo debe contener letras';
              }
              return null;
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _lastNameController,
            decoration: InputDecoration(
              labelText: 'Apellido',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese su apellido';
              } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                return 'El apellido solo debe contener letras';
              }
              return null;
            },
          ),
          SizedBox(height: 8),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Teléfono',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ingrese su teléfono';
              } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                return 'El teléfono debe contener 10 dígitos';
              }
              return null;
            },
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
          ElevatedButton(
            onPressed: _register,
            child: Text('Registrarse'),
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
              Text('¿Tienes una cuenta?'),
              SizedBox(width: 4),
              TextButton(
                onPressed: () {
                  // Navegar a la pantalla de inicio de sesión
                  Navigator.pop(context);
                },
                child: Text('Inicia sesión'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
