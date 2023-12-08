import 'dart:ffi';

import 'package:flutter/material.dart';

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

  void printClientInfo() {
    print('Client ID: $id');
    print('Name: $name');
    print('lastname:$lastName');
    print('Phone: $phone');
    print('Email: $email');
  }
}
