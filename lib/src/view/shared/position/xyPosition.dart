import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'drawing/drawRoundAngle/size_const.dart';
import 'drawing/xyRadar.dart';

class XYPosition extends StatelessWidget {
  final int xValue;
  final int yValue;
  final double gValue;
  final List<List> points;
  final List<List> pointsWithRange;
  XYPosition({
    this.xValue,
    this.yValue,
    this.gValue,
    this.points,
    this.pointsWithRange,
  });

  Widget _position(
    int xValue,
    int yValue,
    double gValue,
    // BuildContext c
  ) {
    return Stack(
      alignment: Alignment(0, 0),
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/TOP.png'),
        ),
        Stack(
          alignment: Alignment(0, 0),
          children: <Widget>[
            // Stack(
            //   alignment: Alignment(0, 0),
            //   children: points
            //       .map(
            //         (point) => Marker(
            //           index: points.indexOf(point),
            //           x: point[0],
            //           y: point[1],
            //         ),
            //       )
            //       .toList(),
            // ),
            CustomPaint(
              painter: XYRadar(points: points),
            ),
            pointsWithRange.length != 0
                ? CustomPaint(
                    painter: XYRadarWithRange(pointsWithRange: pointsWithRange),
                  )
                : Container(),
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
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeUtil.getInstance().logicSize = MediaQuery.of(context).size;
    SizeUtil.initDesignSize();
    return _position(
      xValue,
      yValue,
      gValue,
      // context
    );
    // return Container(
    //   width: 400,
    //   height: 400,
    //   child: Stack(
    //     alignment: Alignment(0, 0),
    //     children: <Widget>[
    //       Image(
    //         image: AssetImage('assets/images/TOP.png'),
    //       ),
    //       Stack(
    //         alignment: Alignment(0, 0),
    //         children: <Widget>[
    //           // Stack(
    //           //   alignment: Alignment(0, 0),
    //           //   children: points
    //           //       .map(
    //           //         (point) => Marker(
    //           //           index: points.indexOf(point),
    //           //           x: point[0],
    //           //           y: point[1],
    //           //         ),
    //           //       )
    //           //       .toList(),
    //           // ),
    //           CustomPaint(
    //             painter: RoundPolygonPainter(),
    //           ),
    //         ],
    //       ),
    //     ],
    //   ),
    // );
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
