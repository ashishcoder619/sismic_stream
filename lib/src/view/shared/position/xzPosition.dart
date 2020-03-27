import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'drawing/xzRadar.dart';

class XZPosition extends StatelessWidget {
  final int xValue;
  final int zValue;
  final double gValue;
  final double angle;
  final List<List> points;
  XZPosition({
    this.xValue,
    this.zValue,
    this.gValue,
    this.points,
    this.angle,
  });

  Widget _position(int xValue, int zValue, double gValue, BuildContext c) {
    double width = MediaQuery.of(c).size.shortestSide;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: Stack(
            alignment: Alignment(0, 0),
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/FRONT.png'),
              ),
              Stack(
                alignment: Alignment(0, 0),
                children: <Widget>[
                  CustomPaint(
                    painter: XZRadar(points: points),
                  ),
                ],
              ),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            Center(
              child: CustomPaint(
                size: Size(width / 2, 0),
                painter: XZAngle(angle: angle),
              ),
            ),
            Center(
              child: Text(
                "${angle.toInt()}º",
                style: TextStyle(
                  color: angle.toInt() > 15 ? Colors.red : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // SizeUtil.getInstance(key: SizeKeyConst.DEVICE_KEY).logicSize = MediaQuery.of(context).size;
    // SizeUtil.initDesignSize();
    return _position(xValue, zValue, gValue, context);
  }
}

// class Marker extends StatelessWidget {
//   final int x;
//   final int y;
//   final int index;

//   Marker({this.index, this.x: 0, this.y: 0});

//   @override
//   Widget build(BuildContext context) {
//     // print("x: $x, y: $y");
//     return Transform(
//       transform: Matrix4.translationValues(x.toDouble(), -y.toDouble(), 0.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Text(
//             // "[$x|$y]",
//             "[$index]",
//             style: TextStyle(fontSize: 7),
//           ),
//           CustomPaint(
//             // painter: CircleMachine(x: this.x, y: this.y),
//             child: CircleAvatar(
//               radius: 2,
//               backgroundColor: Colors.green,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
