import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sismic_stream/src/view/shared/position/drawing/zyRadar.dart';
import './drawing/circleMachine.dart';
import 'drawing/zyLimit.dart';

class ZYPosition extends StatelessWidget {
  final int zValue;
  final int yValue;
  final double gValue;
  ZYPosition({this.zValue, this.yValue, this.gValue});
  _position(int zValue, int yValue, double gValue) {
    return Stack(
      alignment: Alignment(0, 0),
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/LAT.png'),
        ),
        Stack(
          alignment: Alignment(0, 0),
          children: <Widget>[
            CustomPaint(
              painter: ZYRadar(
                zValue: zValue,
                yValue: yValue,
              ),
              child: Center(),
            ),
            // Marker(
            //   z: zValue,
            //   y: yValue,
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
                  fontSize: 40.0),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _position(
      zValue,
      yValue,
      gValue,
    );
  }
}

class Marker extends StatelessWidget {
  final int z;
  final int y;

  Marker({this.z: 0, this.y: 0});

  @override
  Widget build(BuildContext context) {
    // print("z: $z, y: $y");
    return Transform(
      transform: Matrix4.translationValues(z.toDouble(), -y.toDouble(), 0.0),
      // child: CircleAvatar(radius: 100, backgroundColor: Colors.lightGreen,));
      child: CustomPaint(
        painter: CircleMachine(),
        child: Center(),
      ),
    );
  }
}
