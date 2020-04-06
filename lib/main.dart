import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sismic_stream/src/view/phone/blueAndLocationPage/blueAndLocation.dart';
import 'src/controller/login.controller.dart';
import 'src/controller/xy.controller.dart';
import 'src/controller/xz.controller.dart';
import 'src/controller/zy.controller.dart';

void main(){
  GetIt getIt = GetIt.I;
  getIt.registerSingleton<XYController>(XYController());
  getIt.registerSingleton<XZController>(XZController());
  getIt.registerSingleton<ZYController>(ZYController());
  getIt.registerSingleton<LoginController>(LoginController());
  runApp(MyApp());
} 

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
      home: BluetoothAndLocationPagePhone(),
    );
  }
}

