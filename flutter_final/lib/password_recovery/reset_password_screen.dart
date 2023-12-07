import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatelessWidget {
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
              child: Column(
                children: [
                  Image.asset(
                    'assets/AutoExpress_logo.png',
                    height: 100.0,
                  ),
                  ResetPasswordForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ResetPasswordForm extends StatefulWidget {
  @override
  _ResetPasswordFormState createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void _resetPassword() {
    // Lógica para restablecer la contraseña
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 16),
          Text(
            'Reset Password 🔒',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _newPasswordController,
            decoration: InputDecoration(
              labelText: 'Nueva contraseña',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: true,
            validator: (value) {
              // Validaciones de la nueva contraseña
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _confirmPasswordController,
            decoration: InputDecoration(
              labelText: 'Confirmar contraseña',
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            obscureText: true,
            validator: (value) {
              // Validaciones de la confirmación de la contraseña
            },
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Guardar nueva contraseña'),
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
