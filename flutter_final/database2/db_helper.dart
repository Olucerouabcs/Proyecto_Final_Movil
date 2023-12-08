import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();

  factory DBHelper() => _instance;

  DBHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    // Si la base de datos no existe, la crea
    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'my_database.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // Crear tablas

        await db.execute('''
          CREATE TABLE addresses (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            address TEXT NOT NULL,
            code_postal INTEGER NOT NULL,
            residence_number TEXT,
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE bill_rentals (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            id_renta INTEGER NOT NULL,
            metodo_pago TEXT NOT NULL,
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE cars (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            v_models_id INTEGER NOT NULL,
            trademarks_id INTEGER NOT NULL,
            categories_id INTEGER NOT NULL,
            is_avaliable INTEGER NOT NULL DEFAULT 1,
            rates_id INTEGER NOT NULL,
            image TEXT,
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE categories (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            categoria TEXT NOT NULL,
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE clients (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            lastname TEXT NOT NULL,
            email TEXT NOT NULL,
            phone INTEGER NOT NULL,
            id_address INTEGER NOT NULL,
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE failed_jobs (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            uuid TEXT NOT NULL,
            connection TEXT NOT NULL,
            queue TEXT NOT NULL,
            payload TEXT NOT NULL,
            exception TEXT NOT NULL,
            failed_at TEXT NOT NULL DEFAULT current_timestamp()
          )
        ''');

        await db.execute('''
          CREATE TABLE migrations (
            id INTEGER NOT NULL,
            migration TEXT NOT NULL,
            batch INTEGER NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE personal_access_tokens (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            tokenable_type TEXT NOT NULL,
            tokenable_id INTEGER NOT NULL,
            name TEXT NOT NULL,
            token TEXT NOT NULL,
            abilities TEXT,
            last_used_at TEXT,
            expires_at TEXT,
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE rates (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            descripcion TEXT NOT NULL,
            categoria TEXT NOT NULL,
            tarifa INTEGER NOT NULL,
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE remember_passwords (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            users_id INTEGER NOT NULL,
            email TEXT NOT NULL,
            new_password TEXT NOT NULL,
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE rentals (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            client_id INTEGER NOT NULL,
            id_vehiculo INTEGER NOT NULL,
            rates_id INTEGER NOT NULL,
            initial_day TEXT NOT NULL,
            delivery_day TEXT NOT NULL,
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE trademarks (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            marca TEXT NOT NULL,
            image TEXT NOT NULL,
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            lastname TEXT NOT NULL,
            phone TEXT NOT NULL,
            email TEXT NOT NULL,
            password TEXT NOT NULL,
            email_verified_at TEXT,
            created_at TEXT,
            updated_at TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE v_models (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            nombre TEXT NOT NULL,
            trademarks_id INTEGER NOT NULL,
            created_at TEXT,
            updated_at TEXT
          )
        ''');
        // Insertar datos

        await db.execute('''
          INSERT INTO addresses (address, code_postal, residence_number, created_at, updated_at)
          VALUES
          ('Avenida Central', 20040, '7E', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          ('Calle 15', 18050, '2F', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          ('Boulevard 8', 25030, '9G', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          ('Ronda 6', 19020, '4H', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          ('Pasaje 11', 22015, '6I', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          ('Avenida Principal', 28050, '12B', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          ('Calle 10', 15060, '5A', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          ('Avenida 3', 31040, '8C', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          ('Callejón 7', 18025, '3B', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          ('Paseo 12', 26015, '10D', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          ('Calle 7', 24234, '10', '2023-12-07 05:36:23', '2023-12-07 05:36:35');
        ''');

        await db.execute('''
          INSERT INTO bill_rentals (id_renta, metodo_pago, created_at, updated_at)
          VALUES
          (1, 'efectivo', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (2, 'tarjeta', '2023-12-04 23:03:27', '2023-12-04 23:03:27');
        ''');

        await db.execute('''
          INSERT INTO cars (v_models_id, trademarks_id, categories_id, is_avaliable, rates_id, image, created_at, updated_at)
          VALUES
          (1, 1, 1, 0, 4, '', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (2, 2, 1, 2, 0, 7, '', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (3, 3, 1, 3, 1, 11, '', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (4, 1, 1, 4, 1, 15, '', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (5, 2, 1, 5, 1, 20, '', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (6, 4, 2, 1, 1, 4, '', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (7, 5, 2, 2, 1, 7, '', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (8, 6, 2, 3, 1, 11, '', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (9, 4, 2, 4, 1, 15, '', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (10, 5, 2, 5, 1, 20, '', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (11, 5, 5, 7, 1, 8, NULL, '2023-12-07 09:57:11', '2023-12-07 09:57:11');
        ''');
        await db.execute('''
          INSERT INTO `categories` (`id`, `categoria`, `created_at`, `updated_at`) VALUES
          (1, 'Clase A: Autos pequeños', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (2, 'Clase B: Autos pequeños', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (3, 'Clase C: Autos medianos', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (4, 'Clase D: Autos grandes', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (5, 'Clase E: Autos de gama alta', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (6, 'Clase F: Autos de lujo', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (7, 'CLase J: Vehículos SUV con equipamiento deportivo', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (8, 'Clase M: MPV vehiculos polivalentes', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (9, 'Clase S: Vehículos deportivos', '2023-12-04 23:03:26', '2023-12-04 23:03:26');
        ''');

        await db.execute('''
          INSERT INTO `clients` (`id`, `name`, `lastname`, `email`, `phone`, `id_address`, `created_at`, `updated_at`) VALUES
          (1, 'Juan', 'Perez', 'jupe@gmail.com', 6601234567, 1, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (2, 'Pedro', 'Lopez', 'pelo@gmail.com', 9865197516, 2, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (3, 'Maria', 'Gonzalez', 'mago@gmail.com', 1234567890, 3, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (4, 'Jose', 'Rodriguez', 'joro@hotmail.com', 446548975, 4, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (5, 'Ana', 'Martinez', 'anma@outlock.com', 6122009874, 5, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (6, 'Juan', 'Gomez', 'juan.gomez@uabcs.mx', 6123456789, 6, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (7, 'Carlos', 'López', 'carlos.lopez@hotmail.com', 6125551234, 7, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (8, 'Elena', 'Ramirez', 'elena.ramirez@gmail.com', 6128765432, 8, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (9, 'Jorge', 'Perez', 'jorge.perez@outlock.com', 6129876543, 9, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (10, 'Laura', 'Rodriguez', 'laura.rodriguez@uabcs.mx', 6123334444, 10, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (11, 'Bianca', 'Sandez', 'bsandez@gmail.com', 6121256892, 11, '2023-12-07 05:36:23', '2023-12-07 05:36:23');
        ''');

        await db.execute('''
          INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
          (1, '2019_08_19_000000_create_failed_jobs_table', 1),
          (2, '2019_12_14_000001_create_personal_access_tokens_table', 1),
          (3, '2023_11_22_003748_create_users_table', 1),
          (4, '2023_11_22_003749_create_bill_rentals_table', 1),
          (5, '2023_11_22_003750_create_trademarks_table', 1),
          (6, '2023_11_22_003751_create_rates_table', 1),
          (7, '2023_11_22_003752_create_clients_table', 1),
          (8, '2023_11_22_003753_create_categories_table', 1),
          (9, '2023_11_22_003754_create_rentals_table', 1),
          (10, '2023_11_22_003755_create_cars_table', 1),
          (11, '2023_11_22_003756_create_addresses_table', 1),
          (12, '2023_11_22_003757_create_remember_passwords_table', 1),
          (13, '2023_12_03_012232_create_v_models_table', 1);
        ''');
        await db.execute('''
          INSERT INTO rates (id, descripcion, categoria, tarifa, created_at, updated_at)
          VALUES
          (1, 'Diario', 'Clase A: Autos pequeños', 100, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (2, 'Semanal', 'Clase A: Autos pequeños', 500, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (3, 'Mensual', 'Clase A: Autos pequeños', 1500, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (4, 'Anual', 'Clase A: Autos pequeños', 15000, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (5, 'Diario', 'Clase B: Autos pequeños', 150, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (6, 'Semanal', 'Clase B: Autos pequeños', 750, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (7, 'Mensual', 'Clase B: Autos pequeños', 2250, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (8, 'Anual', 'Clase B: Autos pequeños', 20000, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (9, 'Diario', 'Clase C: Autos medianos', 200, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (10, 'Semanal', 'Clase C: Autos medianos', 1000, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (11, 'Mensual', 'Clase C: Autos medianos', 3000, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (12, 'Anual', 'Clase C: Autos medianos', 30000, '2023-12-04 23:03:27', '2023-12-04 23:03:27');
        ''');

        // Tabla `rentals`
        await db.execute('''
          INSERT INTO rentals (id, client_id, id_vehiculo, rates_id, initial_day, delivery_day, created_at, updated_at)
          VALUES
          (1, 1, 1, 4, '2023-11-23 00:00:00', '2024-12-23 00:00:00', '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (2, 2, 2, 1, '2023-11-23 00:00:00', '2023-12-23 00:00:00', '2023-12-04 23:03:27', '2023-12-04 23:03:27');
        ''');

        // Tabla `trademarks`
        await db.execute('''
          INSERT INTO trademarks (id, marca, image, created_at, updated_at)
          VALUES
          (1, 'Acura', '..\\assets\\img\\svgs\\acura.svg', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (2, 'Alfa Romeo', '..\\assets\\img\\svgs\\alfa_romeo.svg', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (3, 'AM General', '..\\assets\\img\\svgs\\am_general.svg', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (4, 'Aston Martin', '..\\assets\\img\\svgs\\aston_martin.svg', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (5, 'Audi', '..\\assets\\img\\svgs\\audi.svg', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (6, 'Bentley', '..\\assets\\img\\svgs\\bentley.svg', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (7, 'BMW', '..\\assets\\img\\svgs\\bmw.svg', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (8, 'Bugatti', '..\\assets\\img\\svgs\\bugatti.svg', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (9, 'Cadillac', '..\\assets\\img\\svgs\\cadillac.svg', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (10, 'Chevrolet', '..\\assets\\img\\svgs\\chevrolet.svg', '2023-12-04 23:03:26', '2023-12-04 23:03:26');
        ''');
        await db.execute('''
          INSERT INTO users (id, name, lastname, phone, email, password, email_verified_at, created_at, updated_at) VALUES
          (1, 'Admin', 'Admin', '123456789', 'Admin@gmail.com', '123456789', NULL, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (2, 'Jose Ramon', 'Villavicencio Alvarez', '987654321', 'joseramonv_20@alu.uabcs.mx', '123456789', NULL, '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (3, 'Chelsea Sporer', 'Pacocha', '+1.904.410.0844', 'khaley@example.org', '2y127JHfhH.ADaZbWfHv7Rcu0ebNDnrPiYCaCcOQuau41WOVJ8ICCEJ1q', '2023-12-04 23:03:26', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (4, 'Etha Kohler', 'Cruickshank', '+1-458-793-0744', 'ivory80@example.com', '2y127JHfhH.ADaZbWfHv7Rcu0ebNDnrPiYCaCcOQuau41WOVJ8ICCEJ1q', '2023-12-04 23:03:26', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (5, 'August Terry', 'Murphy', '+14439188649', 'pascale36@example.com', '2y127JHfhH.ADaZbWfHv7Rcu0ebNDnrPiYCaCcOQuau41WOVJ8ICCEJ1q', '2023-12-04 23:03:26', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (6, 'Maye Gerlach', 'Nitzsche', '+13864261605', 'hpurdy@example.org', '2y127JHfhH.ADaZbWfHv7Rcu0ebNDnrPiYCaCcOQuau41WOVJ8ICCEJ1q', '2023-12-04 23:03:26', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (7, 'Aurelio Waelchi', 'Pfannerstill', '773-900-5576', 'khalil72@example.org', '2y127JHfhH.ADaZbWfHv7Rcu0ebNDnrPiYCaCcOQuau41WOVJ8ICCEJ1q', '2023-12-04 23:03:26', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (8, 'Shad Dach', 'Crooks', '234.309.3087', 'nick22@example.com', '2y127JHfhH.ADaZbWfHv7Rcu0ebNDnrPiYCaCcOQuau41WOVJ8ICCEJ1q', '2023-12-04 23:03:26', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (9, 'Sedrick Rempel', 'Gerlach', '+1 (360) 614-1608', 'xfritsch@example.com', '2y127JHfhH.ADaZbWfHv7Rcu0ebNDnrPiYCaCcOQuau41WOVJ8ICCEJ1q', '2023-12-04 23:03:26', '2023-12-04 23:03:26', '2023-12-04 23:03:26'),
          (10, 'Addie Sauer I', 'Stokes', '+1 (256) 734-3222', 'betsy.quigley@example.com', '2y127JHfhH.ADaZbWfHv7Rcu0ebNDnrPiYCaCcOQuau41WOVJ8ICCEJ1q', '2023-12-04 23:03:26', '2023-12-04 23:03:26', '2023-12-04 23:03:26');
        ''');

        // Insertar datos en la tabla v_models
        await db.execute('''
          INSERT INTO v_models (id, nombre, trademarks_id, created_at, updated_at) VALUES
          (1, 'MDX', 1, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (2, 'RDX', 1, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (3, 'ILX', 1, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (4, 'Giulia', 2, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (5, 'Stelvio', 2, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (6, '4C', 2, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (7, 'Vantage', 4, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (8, 'DB11', 4, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (9, 'DBS', 4, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (10, '124 Spider', 18, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (11, 'Panda', 18, '2023-12-04 23:03:27', '2023-12-04 23:03:27'),
          (12, '500X', 18, '2023-12-04 23:03:27', '2023-12-04 23:03:27');
        ''');
      },
    );
  }
}

void main() async {
  DBHelper dbHelper = DBHelper();

  // Obtén una referencia a la base de datos
  Database db = await dbHelper.database;

  // Realiza operaciones en la base de datos según tus necesidades
  // ...
}
