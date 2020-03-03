import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './drawing/circleMachine.dart';
import './drawing/xyLimit.dart';

class XYPosition extends StatelessWidget {
  final Stream<List<int>> stream;
  XYPosition({this.stream});

  List<num> _listParser(List<int> dataFromDevice) {
    String stringData = utf8.decode(dataFromDevice);
    return stringData.split('|').map((e) => num.parse(e)).toList();
  }

  Widget _position(int xValue, int yValue, double gValue) {
    return Stack(
      alignment: Alignment(0, 0),
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/TOP.png'),
        ),
        Stack(
          alignment: Alignment(0, 0),
          children: <Widget>[
            CustomPaint(
              painter: CircleXY(
                x: xValue,
                y: yValue,
              ),
              child: Center(),
            ),
            Marker(
              x: xValue,
              y: yValue,
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
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      ],
    );
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
          int xValue = _listParser(snapshot.data)[0];
          int yValue = _listParser(snapshot.data)[1];
          double gValue = _listParser(snapshot.data)[3];

          return _position(xValue, yValue, gValue);
        }
        return Container();
      },
    );
  }
}

class Marker extends StatelessWidget {
  final int x;
  final int y;

  Marker({this.x: 0, this.y: 0});

  @override
  Widget build(BuildContext context) {
    print("x: $x, y: $y");
    return Transform(
      transform: Matrix4.translationValues(x.toDouble(), y.toDouble(), 0.0),
      child: CustomPaint(
        painter: CircleMachine(),
        child: Center(),
      ),
    );
  }
}
