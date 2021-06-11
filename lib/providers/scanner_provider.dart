import 'package:flutter/material.dart';
import 'package:flutter_application_qrscanner/models/scanner_model.dart';
import 'package:flutter_application_qrscanner/providers/db_provider.dart';

class ScannerProvider extends ChangeNotifier {
  List<ScannerModel> scanners = [];
  
  Future<ScannerModel> insertScanner(ScannerModel oScanner) async {
    final response = await DBProvider.db.insertScanner(oScanner);

    oScanner.id = response;
    this.scanners.add(oScanner);
    notifyListeners();
    return oScanner;
  }

  //Lista todos los registros y lo carga a nuestra lista Scanners y notifica
  getAllScanner() async {
    final response = await DBProvider.db.getAllScanner();
    this.scanners = [...response];
    notifyListeners();

    return scanners;
  }

  deleteScanner(int id) async {
    await DBProvider.db.deleteScanner(id);
    //Al eliminar un registro llamamos al listar todos donde tiene el notify para informar que cambio la lista
    getAllScanner();
  }
  
  //Eliminamos toda la información de nuestra base de datos
  deleteAllScanner() async {
    await DBProvider.db.deleteAllScanner();
    this.scanners = [];
    notifyListeners();
  }
}
