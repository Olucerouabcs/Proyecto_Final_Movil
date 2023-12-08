import 'dart:ffi';

class Client {
  int? id;
  String name;
  String lastName;
  int phone;
  String email;
  String password;

  Client({
    this.id,
    required this.name,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'password': password
    };
  }

  // Método para imprimir información del cliente
  void printClientInfo() {
    print('Client ID: $id');
    print('Name: $name $lastName');
    print('Phone: $phone');
    print('Email: $email');
    // No imprimimos la contraseña por razones de seguridad
  }
}
