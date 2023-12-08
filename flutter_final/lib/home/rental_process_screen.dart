import 'package:flutter/material.dart';
import '../home/home_screen.dart';
import '../rentals/rentals_screen.dart';
import '../profile/profile_screen.dart';

class RentalProcessScreen extends StatefulWidget {
  final Vehicle selectedVehicle;

  RentalProcessScreen({required this.selectedVehicle});

  @override
  _RentalProcessScreenState createState() => _RentalProcessScreenState();
}

class _RentalProcessScreenState extends State<RentalProcessScreen> {
  late DateTime selectedDate;
  late int selectedDays;
  final double ratePerDay = 400.0;
  String selectedPaymentMethod = 'Efectivo';

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
    selectedDays = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AutoExpress - Rentar Vehículo'),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/AutoExpress_logo.png',
                    height: 80.0,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Crear Renta de Vehículo',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Vehículo: ${widget.selectedVehicle.model} ${widget.selectedVehicle.brand}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Fecha de Préstamo: ${selectedDate.toLocal()}'
                        .split(' ')[0],
                    style: TextStyle(fontSize: 16.0),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked != selectedDate)
                        setState(() {
                          selectedDate = picked;
                        });
                    },
                    child: Text('Seleccionar Fecha de Préstamo'),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Días: $selectedDays',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  Slider(
                    value: selectedDays.toDouble(),
                    min: 1,
                    max: 30,
                    onChanged: (value) {
                      setState(() {
                        selectedDays = value.toInt();
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Tarifa Diaria: \$${ratePerDay.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Método de Pago:',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  DropdownButton<String>(
                    value: selectedPaymentMethod,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedPaymentMethod = newValue!;
                      });
                    },
                    items: <String>['Efectivo', 'Tarjeta', 'Transferencia']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Total: \$${(selectedDays * ratePerDay).toStringAsFixed(2)}',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Cancelar
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()),
                          );
                        },
                        child: Text('Cancelar'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Guardar la renta (puedes implementar lógica de guardado aquí)
                          // Luego puedes navegar a la pantalla de rentas o realizar otras acciones necesarias
                          Navigator.popUntil(context, ModalRoute.withName('/'));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RentalsScreen()),
                          );
                        },
                        child: Text('Guardar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
              break;
            case 1:
              // Navegar a la pantalla de "Rentas"
              Navigator.popUntil(context, ModalRoute.withName('/'));
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RentalsScreen()),
              );
              break;
            case 2:
              // Navegar a la sección de "Perfil"
              Navigator.popUntil(context, ModalRoute.withName('/'));
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
