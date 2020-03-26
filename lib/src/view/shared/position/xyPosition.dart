import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'drawing/xyRadar.dart';

class XYPosition extends StatelessWidget {
  final int xValue;
  final int yValue;
  final double gValue;
  final List<List> points;
  XYPosition({
    this.xValue,
    this.yValue,
    this.gValue,
    this.points,
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
              painter: RoundPolygonPainter(points: points),
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
    return _position(
      xValue,
      yValue,
      gValue,
      // context
    );
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
