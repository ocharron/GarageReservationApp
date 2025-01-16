import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  static final DatabaseHandler _databaseHandler = DatabaseHandler._internal();

  factory DatabaseHandler() {
    return _databaseHandler;
  }

  DatabaseHandler._internal();

  Database? database;

  Future<void> initDb() async {
    WidgetsFlutterBinding.ensureInitialized();
    database = await openDatabase(
      join(await getDatabasesPath(), 'garageauto_database.db'),
      version: 4,
      onCreate: (db, version) async {
        _initialScript.forEach((script) async => await db.execute(script));
      }
    );
  }

  static final _initialScript = [
    '''
      PRAGMA foreign_keys = ON;
    ''',
    '''
      CREATE TABLE User (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL
      );
    ''',
    '''
      CREATE TABLE Role (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT,
        role TEXT NOT NULL,
        FOREIGN KEY(userId) REFERENCES User(id)
      );
    ''',
    '''
      CREATE TABLE Mechanic (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        name TEXT
      );
    ''',
    '''
      CREATE TABLE Appointment (
        id INTEGER PRIMARY KEY AUTOINCREMENT, 
        date TEXT,
        mechanicId INT,
        userId TEXT,
        FOREIGN KEY (mechanicId) REFERENCES Mechanic(id),
        FOREIGN KEY (userId) REFERENCES User(id)
      );
    ''',
    '''
      INSERT INTO User (id, name) VALUES
      ('auth0|657b443a800b946fec8cd8f3', 'admin@mikesworkshop.com'),
      ('auth0|6577cfeb34659f99dd98deb7', 'toto@toto.com');
    ''',
    '''
      INSERT INTO Role (userId, role) VALUES
      ('auth0|657b443a800b946fec8cd8f3', 'admin'),
      ('auth0|6577cfeb34659f99dd98deb7', 'user');
    ''',
    '''
      INSERT INTO Mechanic (name) VALUES
      ('Mike'),
      ('Joe'),
      ('Bob'),
      ('Mark'),
      ('John');
    ''',
    '''
      INSERT INTO Appointment (date, userId, mechanicId) VALUES
      ('2023-12-29 13:30', NULL, 1),
      ('2023-12-30 14:00', NULL, 2),
      ('2023-12-29 13:30', 'auth0|6577cfeb34659f99dd98deb7', 3),
      ('2024-01-03 11:00', NULL, 3),
      ('2024-01-02 09:45', 'auth0|6577cfeb34659f99dd98deb7', 4),
      ('2023-12-29 14:30', NULL, 5),
      ('2023-12-31 14:00', NULL, 5);
    '''
  ];
}