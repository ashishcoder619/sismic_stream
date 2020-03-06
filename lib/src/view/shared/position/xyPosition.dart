import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './drawing/circleMachine.dart';
// import './drawing/xyLimit.dart';
import 'drawing/xyRadar.dart';

class XYPosition extends StatelessWidget {
  final int xValue;
  final int yValue;
  final double gValue;
  XYPosition({this.xValue, this.yValue, this.gValue});

  Widget _position(int xValue, int yValue, double gValue) {
    print("*********************x: $xValue y: $yValue************************");
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
              painter: XYRadar(
                // xValue: xValue,
                // yValue: yValue,
                xValue: 0,
                yValue: 0,
              ),
              child: Center(),
            ),
            // CustomPaint(
            //   painter: XYLimit(
            //     x: xValue,
            //     y: yValue,
            //   ),
            //   child: Center(),
            // ),
            Marker(
              // x: xValue,
              // y: yValue,
              x: 19,
              y: 0,
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
    return _position(
      xValue,
      yValue,
      gValue,
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
        painter: CircleMachine(x: this.x, y: this.y),
        child: Center(),
      ),
    );
  }
}
