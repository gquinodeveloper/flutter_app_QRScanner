import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/home/home_page.dart';
import 'providers/scanner_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Cuando usamos provider es importante mencionar aqui los providers 
    //para que sean escuchados cada vez que surga un cambio
    return MultiProvider(
      //Mencionar todos los providers creados, en este caso solo tenemos ScannerProvider
      //Que extiende de ChangeNotifier
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
