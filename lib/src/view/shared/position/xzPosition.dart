import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sismic_stream/src/view/shared/position/drawing/xzRadar.dart';
import './drawing/circleMachine.dart';
import 'drawing/xzLimit.dart';

class XZPosition extends StatelessWidget {
  final int xValue;
  final int zValue;
  final double gValue;
  XZPosition({this.xValue, this.zValue, this.gValue});

  _position(int xValue, int zValue, double gValue) {
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
              painter: XZRadar(
                xValue: xValue,
                zValue: -zValue,
              ),
              child: Center(),
            ),
            // Marker(
            //   x: xValue,
            //   z: zValue,
            // ),
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
    return _position(
      xValue,
      zValue,
      gValue,
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
