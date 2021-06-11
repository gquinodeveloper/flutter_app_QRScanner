import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:meta/meta.dart';
import 'package:flutter_application_qrscanner/models/scanner_model.dart';
import 'package:flutter_application_qrscanner/providers/scanner_provider.dart';
import 'package:flutter_application_qrscanner/utils/utils.dart';

class Scanners extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Cuando el provider es llamado despues del build el 99.99% es no asignarte el listen
    final _scannerProvider = Provider.of<ScannerProvider>(context);
    final _scanners = _scannerProvider.scanners;

    print("Dibujandoooo");
    return ListView.builder(
      itemCount: _scanners.length,
      itemBuilder: (_, index) => Dismissible(
        key: UniqueKey(),
        direction: DismissDirection.endToStart,
        background: Container(
          color: Colors.red,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete_outline,
            color: Colors.white,
          ),
        ),
        onDismissed: (DismissDirection direction) {
          Provider.of<ScannerProvider>(context, listen: false)
              .deleteScanner(_scanners[index].id);
        },
        child: ItemScanner(scanner: _scanners[index]),
      ),
    );
  }
}

class ItemScanner extends StatelessWidget {
  ItemScanner({
    @required this.scanner,
  });

  final ScannerModel scanner;
  @override
  Widget build(BuildContext context) {
    final random = Random();
    Color color = Color.fromRGBO(
      random.nextInt(255),
      random.nextInt(255),
      random.nextInt(255),
      1.0,
    );
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(
          "${scanner.id}",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      title: Text(scanner.valor),
      trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
      onTap: () => launchURL(url: scanner.valor),
    );
  }
}
