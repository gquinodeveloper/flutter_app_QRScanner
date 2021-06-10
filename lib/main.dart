import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home/home_page.dart';
import 'providers/scanner_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new ScannerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: HomePage(),
      ),
    );
  }
}
