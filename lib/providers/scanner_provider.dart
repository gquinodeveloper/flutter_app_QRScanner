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

  getAllScanner() async {
    final response = await DBProvider.db.getAllScanner();
    this.scanners = [...response];
    notifyListeners();

    return scanners;
  }

  deleteScanner(int id) async {
    await DBProvider.db.deleteScanner(id);
    getAllScanner();
  }

  deleteAllScanner() async {
    await DBProvider.db.deleteAllScanner();
    this.scanners = [];
    notifyListeners();
  }
}
