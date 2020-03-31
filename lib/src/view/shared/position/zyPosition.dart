import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:sismic_stream/src/view/shared/position/drawing/zyRadar.dart';

class ZYPosition extends StatelessWidget {
  final int zValue;
  final int yValue;
  final double gValue;
  final double angle;
  final List<List<int>> points;
  ZYPosition({
    this.zValue,
    this.yValue,
    this.gValue,
    this.points,
    this.angle,
  });
  _position(int zValue, int yValue, double gValue, BuildContext c) {
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
                image: AssetImage('assets/images/LAT.png'),
              ),
              Stack(
                alignment: Alignment(0, 0),
                children: <Widget>[
                  CustomPaint(
                    painter: ZYRadar(
                      points: points,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "$gValue",
                    style:
                        TextStyle(fontFamily: 'Quebec Black', fontSize: 40.0),
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
          ),
        ),
        Column(
          children: <Widget>[
            Center(
              child: CustomPaint(
                size: Size(width / 1.7, 0),
                painter: ZYAngle(angle: angle),
              ),
            ),
            Center(
              child: Text(
                "\n${angle.toInt()}°",
                style: TextStyle(
                  color: angle.toInt() > 15 ? Colors.red : Colors.black,
                  fontSize: 25,
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
    return _position(
      zValue,
      yValue,
      gValue,
      context
    );
  }
}

// class Marker extends StatelessWidget {
//   final int z;
//   final int y;

//   Marker({this.z: 0, this.y: 0});

//   @override
//   Widget build(BuildContext context) {
//     // print("z: $z, y: $y");
//     return Transform(
//       transform: Matrix4.translationValues(z.toDouble(), -y.toDouble(), 0.0),
//       // child: CircleAvatar(radius: 100, backgroundColor: Colors.lightGreen,));
//       child: CustomPaint(
//         painter: CircleMachine(),
//         child: Center(),
//       ),
//     );
//   }
// }
