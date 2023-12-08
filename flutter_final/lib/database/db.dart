import 'package:flutter_final/database/clients.dart';
import 'package:flutter_final/database/vehicles.dart';
import 'package:flutter_final/database/vehicleRentals.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DB {
  static Future<Database> openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'autoexpress.db'),
      onCreate: (db, version) async {
        // Crear la tabla para Clientes
        await db.execute('''
          CREATE TABLE Clients(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            lastname TEXT,
            phone INTEGER,
            email TEXT,
            password TEXT
          )
        ''');

        // Insertar datos de ejemplo para Clientes
        await db.rawInsert('''
          INSERT INTO Clients(name, lastname, phone, email, password)
          VALUES('John', 'Doe', 123456789, 'john.doe@example.com', 'Password123')
        ''');

        await db.rawInsert('''
          INSERT INTO Clients(name, lastname, phone, email, password)
          VALUES('Jane', 'Smith', 987654321, 'jane.smith@example.com', 'Pass456')
        ''');

        // Crear la tabla para Vehículos
        await db.execute('''
          CREATE TABLE Vehicles(
            id INTEGER PRIMARY KEY,
            model TEXT,
            brand TEXT,
            category TEXT,
            rate INTEGER,
            isAvailable INTEGER
          )
        ''');

        await db.rawInsert('''
  INSERT INTO Vehicles(model, brand, category, rate, isAvailable)
  VALUES('Sedan', 'Toyota', 'Compact', 400, 1)
''');

        await db.rawInsert('''
  INSERT INTO Vehicles(model, brand, category, rate, isAvailable)
  VALUES('SUV', 'Honda', 'SUV', 400, 1)
''');

        await db.rawInsert('''
  INSERT INTO Vehicles(model, brand, category, rate, isAvailable)
  VALUES('SUV', 'Acura', 'SUV', 300, 1)
''');

        await db.rawInsert('''
  INSERT INTO Vehicles(model, brand, category, rate, isAvailable)
  VALUES('Sedan', 'Alfa Romeo', 'Compact', 500, 1)
''');

        await db.rawInsert('''
  INSERT INTO Vehicles(model, brand, category, rate, isAvailable)
  VALUES('Crossover', 'Acura', 'Deportiva', 800, 1)
''');

        // Crear la tabla para Rentas de Vehículos
        await db.execute('''
          CREATE TABLE VehicleRentals(
            id INTEGER PRIMARY KEY AUTOINCREMENT, 
            idClient INTEGER,
            idVehicle INTEGER,
            total INTEGER,
            initialDay TEXT,
            deliveryDay TEXT,
            paymentMethod TEXT,
            FOREIGN KEY (idClient) REFERENCES Clients(id),
            FOREIGN KEY (idVehicle) REFERENCES Vehicles(id)
          )
        ''');
      },
      version: 1,
    );
  }

  // Operaciones CRUD para Clientes
  static Future<int> insertClient(Client client) async {
    final db = await openDB();
    return await db.insert('Clients', client.toMap());
  }

  static Future<int> deleteClient(Client client) async {
    final db = await openDB();
    return await db.delete('Clients', where: "id = ?", whereArgs: [client.id]);
  }

  static Future<int> updateClient(Client client) async {
    final db = await openDB();
    return await db.update('Clients', client.toMap(),
        where: "id = ?", whereArgs: [client.id]);
  }

  static Future<List<Client>> getClients() async {
    final db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query('Clients');
    return List.generate(maps.length, (i) {
      return Client(
        id: maps[i]['id'],
        name: maps[i]['name'],
        lastName: maps[i]['lastName'],
        phone: maps[i]['phone'],
        email: maps[i]['email'],
        password: maps[i]['password'],
      );
    });
  }

  static Future<Client> getClientById(int clientId) async {
    final db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'Clients',
      where: 'id = ?',
      whereArgs: [clientId],
    );

    if (maps.isNotEmpty) {
      return Client(
        id: maps[0]['id'],
        name: maps[0]['name'] ?? '', // Maneja el caso en que 'name' sea nulo
        lastName: maps[0]['lastName'] ??
            '', // Maneja el caso en que 'lastName' sea nulo
        phone: maps[0]['phone'] ?? 0, // Maneja el caso en que 'phone' sea nulo
        email: maps[0]['email'] ?? '', // Maneja el caso en que 'email' sea nulo
        password: maps[0]['password'] ?? '',
      );
    } else {
      // Si no se encuentra ningún cliente con el ID proporcionado, devolver null
      throw Exception('Cliente no encontrado');
    }
  }

  // Operaciones CRUD para Vehículos
  static Future<int> insertVehicle(Vehicle vehicle) async {
    final db = await openDB();
    return await db.insert('Vehicles', vehicle.toMap());
  }

  static Future<List<Vehicle>> getVehicles() async {
    final db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query('Vehicles');
    return List.generate(maps.length, (i) {
      return Vehicle(
        id: maps[i]['id'],
        model: maps[i]['model'],
        brand: maps[i]['brand'],
        category: maps[i]['category'],
        rate: maps[i]['rate'],
        isAvailable: maps[i]['is_available'] == 1,
      );
    });
  }

  // Operaciones CRUD para Rentas de Vehículos
  static Future<int> insertVehicleRental(VehicleRental rental) async {
    final db = await openDB();
    return await db.insert('VehicleRentals', rental.toMap());
  }

  static Future<List<VehicleRental>> getVehicleRentals(int userId) async {
    final db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'VehicleRentals',
      where: 'idClient = ?',
      whereArgs: [userId],
    );
    return List.generate(maps.length, (i) {
      return VehicleRental(
        id: maps[i]['id'],
        idClient: maps[i]['idClient'],
        idVehicle: maps[i]['idVehicle'],
        total: maps[i]['total'],
        initialDay: DateTime.parse(maps[i]['initialDay']),
        deliveryDay: DateTime.parse(maps[i]['deliveryDay']),
        paymentMethod: maps[i]['paymentMethod'],
      );
    });
  }
}
