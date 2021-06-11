import 'dart:io';

import 'package:flutter_application_qrscanner/models/scanner_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initBD();

    return _database;
  }

  Future<Database> initBD() async {
    //Path donde almacenaremos la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "QRScanner.db");
    print(path);

    //1.- Crear base de datos y tabla
    //2.- Luego creamos el modelo de Scanner
    return openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE Scanner(
          id INTEGER PRIMARY KEY,
          tipo TEXT,
          valor TEXT
        )
        ''');
      },
    );
  }

  //Forma larga de hacer querys
  Future<int> nuevoScanRaw(ScannerModel nuevoScan) async {
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;
    // Verificar la base de datos
    final db = await database;
    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor )
        VALUES( $id, '$tipo', '$valor' )
    ''');
    return res;
  }

  //Forma corta de hacer insert a la tabla Scanner
  Future<int> insertScanner(ScannerModel oScanner) async {
    final db = await database;
    final response = await db.insert('Scanner', oScanner.toJson());
    //Retorna el último ID del registro insertado
    return response;
  }

  //Retornamos toda la lista de nuestra Base de datos
  Future<List<ScannerModel>> getAllScanner() async {
    final db = await database;
    final response = await db.query("Scanner");

    print(response);
    
    //Lo obtenido de nuestra BD, lo estamos mapeando en nuestro modelo
    return response.isNotEmpty
        ? response.map((scanner) => ScannerModel.fromJson(scanner)).toList()
        : [];
  }

  //Eliminar por ID
  Future<int> deleteScanner(int id) async {
    final db = await database;
    final response =
        await db.delete('Scanner', where: 'id = ?', whereArgs: [id]);
    return response;
  }

  Future<int> deleteAllScanner() async {
    final db = await database;
    final response = await db.delete('Scanner');
    return response;
  }

  //Adicionales
  Future<int> updateScan(ScannerModel oScanner) async {
    final db = await database;
    final response = await db.update('Scanner', oScanner.toJson(),
        where: 'id = ?', whereArgs: [oScanner.id]);
    return response;
  }

  Future<ScannerModel> getScannerById(int id) async {
    final db = await database;
    final response =
        await db.query('Scanner', where: 'id = ?', whereArgs: [id]);

    return response.isNotEmpty
        ? ScannerModel.fromJson(response.first)
        : new ScannerModel();
  }
}
