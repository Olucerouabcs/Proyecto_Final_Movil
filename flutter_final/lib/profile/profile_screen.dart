import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../rentals/rentals_screen.dart';
import '../login/login_screen.dart';
import '../database/clients.dart';
import '../database/db.dart';

class ProfileScreen extends StatefulWidget {
  final int userId;

  ProfileScreen({required this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<Client> _futureClient;

  @override
  void initState() {
    super.initState();
    _futureClient = DB.getClientById(widget.userId);
  }

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
              child: FutureBuilder(
                future: _futureClient,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else {
                    Client client = snapshot.data as Client;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/AutoExpress_logo.png',
                          height: 100.0,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Nombre: ${client.name} ${client.lastName}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Teléfono: ${client.phone}',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          'Correo Electrónico: ${client.email}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Cerrar sesión'),
                                  content: Text(
                                    '¿Estás seguro de que quieres cerrar sesión?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Cancelar'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        Navigator.popUntil(
                                          context,
                                          ModalRoute.withName('/'),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginScreen(),
                                          ),
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
                            primary: Colors.red,
                          ),
                          child: Text('Cerrar sesión'),
                        ),
                      ],
                    );
                  }
                },
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
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(userId: widget.userId),
                ),
              );
              break;
            case 1:
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RentalsScreen(userId: widget.userId),
                ),
              );
              break;
            case 2:
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(userId: widget.userId),
                ),
              );
              break;
          }
        },
      ),
    );
  }
}
