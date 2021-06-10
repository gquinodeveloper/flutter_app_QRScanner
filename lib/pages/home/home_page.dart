import 'package:flutter/material.dart';
import 'package:flutter_application_qrscanner/providers/scanner_provider.dart';
import 'package:provider/provider.dart';
import 'widgets/scanner_button.dart';
import 'widgets/scanners.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Dibujando Widgets");
    return Scaffold(
      appBar: AppBar(
        title: Text("QR - Scanner"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              Provider.of<ScannerProvider>(context, listen: false)
                  .deleteAllScanner();
            },
          ),
        ],
      ),
      body: HomeBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ScannerButton(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _scannerProdiver =
        Provider.of<ScannerProvider>(context, listen: false);
    _scannerProdiver.getAllScanner();
    return Scanners();
  }
}
