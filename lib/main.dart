import 'package:flutter/material.dart';
import 'src/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SISMIC',
      theme: ThemeData(
        fontFamily: 'Quebec Black',
        primaryColor: Colors.white,  
      ),
      home: SismicHome(),
    );
  }
}

