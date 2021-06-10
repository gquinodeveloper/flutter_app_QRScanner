import 'package:flutter/material.dart';
import 'package:flutter_application_qrscanner/utils/utils.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_qrscanner/models/scanner_model.dart';
import 'package:flutter_application_qrscanner/providers/scanner_provider.dart';

class ScannerButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Dibujandoooo FloatingActionButton");
    return FloatingActionButton(
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF',
          'Cancelar',
          false,
          ScanMode.QR,
        );

        if (barcodeScanRes == '-1') return;
        ScannerModel oScanner = ScannerModel(
          tipo: "http",
          valor: barcodeScanRes,
        );

        final _scannerProvider =
            Provider.of<ScannerProvider>(context, listen: false);
        final response = await _scannerProvider.insertScanner(oScanner);
        launchURL(url: response.valor);
        print(response.id);
      },
      child: Icon(Icons.filter_center_focus_rounded),
    );
  }
}
