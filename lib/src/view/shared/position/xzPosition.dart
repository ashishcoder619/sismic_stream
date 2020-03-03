import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './drawing/circleMachine.dart';
import 'drawing/xzLimit.dart';

class XZPosition extends StatelessWidget {
  // int x;
  // int y;
  // double g;

  // XZPosition({
  //   this.x,
  //   this.y,
  //   this.g,
  // });
  final Stream<List<int>> stream;
  XZPosition({this.stream});

  // PARSES
  String _dataParser(List<int> dataFromDevice) {
    return utf8.decode(dataFromDevice);
  }

  List _listParser(String stringData) {
    List arrString = stringData.split('|');
    print('*************ARRAY DE DADOS: $arrString****************');
    // double.parse(arrString[3]); //TestFunction
    return arrString;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<int>>(
      stream: stream,
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot?.connectionState == ConnectionState.active) {
          String currentValue = _dataParser(snapshot.data);
          List arrString = _listParser(currentValue);
          int xValue = int.parse(arrString[0]);
          int zValue = int.parse(arrString[2]);
          double gValue = double.parse(arrString[3]);

          return Stack(alignment: Alignment(0, 0), children: <Widget>[
            Image(
              image: AssetImage('assets/images/TOP.png'),
            ),
            Stack(
              alignment: Alignment(0, 0),
              children: <Widget>[
                CustomPaint(
                  painter: CircleXZ(
                    x: xValue,
                    z: zValue,
                  ),
                  child: Center(),
                ),
                Marker(
                  x: xValue,
                  z: zValue,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "$gValue",
                  style: TextStyle(fontFamily: 'Quebec Black', fontSize: 40.0),
                ),
                Text(
                  "G",
                  style: TextStyle(
                      fontFamily: 'Quebec Black',
                      color: Colors.lightBlue,
                      fontSize: 40.0),
                ),
              ],
            ),
          ]);
        }
        return Container();
      },
    );
  }
}

class Marker extends StatelessWidget {
  final int x;
  final int z;

  Marker({this.x: 0, this.z: 0});

  @override
  Widget build(BuildContext context) {
    print("x: $x, z: $z");
    return Transform(
      transform: Matrix4.translationValues(x.toDouble(), z.toDouble(), 0.0),
      // child: CircleAvatar(radius: 100, backgroundColor: Colors.lightGreen,));
      child: CustomPaint(
        painter: CircleMachine(),
        child: Center(),
      ),
    );
  }
}
