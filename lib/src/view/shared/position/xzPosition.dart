// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:sismic_stream/src/view/shared/position/drawing/xzRadar.dart';
// import './drawing/circleMachine.dart';
// import 'drawing/xzLimit.dart';

// class XZPosition extends StatelessWidget {
//   final int xValue;
//   final int zValue;
//   final double gValue;
//   XZPosition({this.xValue, this.zValue, this.gValue});

//   _position(int xValue, int zValue, double gValue) {
//     return Stack(
//       alignment: Alignment(0, 0),
//       children: <Widget>[
//         Image(
//           image: AssetImage('assets/images/FRONT.png'),
//         ),
//         Stack(
//           alignment: Alignment(0, 0),
//           children: <Widget>[
//             CustomPaint(
//               painter: XZRadar(
//                 xValue: xValue,
//                 zValue: -zValue,
//               ),
//               child: Center(),
//             ),
//             // Marker(
//             //   x: xValue,
//             //   z: zValue,
//             // ),
//           ],
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               "$gValue",
//               style: TextStyle(fontFamily: 'Quebec Black', fontSize: 40.0),
//             ),
//             Text(
//               "G",
//               style: TextStyle(
//                 fontFamily: 'Quebec Black',
//                 color: Colors.lightBlue,
//                 fontSize: 40.0,
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _position(
//       xValue,
//       zValue,
//       gValue,
//     );
//   }
// }

// class Marker extends StatelessWidget {
//   final int x;
//   final int z;

//   Marker({this.x: 0, this.z: 0});

//   @override
//   Widget build(BuildContext context) {
//     // print("x: $x, z: $z");
//     return Transform(
//       transform: Matrix4.translationValues(x.toDouble(), -z.toDouble(), 0.0),
//       // child: CircleAvatar(radius: 100, backgroundColor: Colors.lightGreen,));
//       child: CustomPaint(
//         painter: CircleMachine(),
//         child: Center(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'drawing/xzRadar.dart';

class XZPosition extends StatelessWidget {
  final int xValue;
  final int zValue;
  final double gValue;
  final List<List> points;
  XZPosition({
    this.xValue,
    this.zValue,
    this.gValue,
    this.points,
  });

  Widget _position(
    int xValue,
    int zValue,
    double gValue,
    // BuildContext c
  ) {
    
    return Stack(
      alignment: Alignment(0, 0),
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/FRONT.png'),
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
              painter: XZRadar(points: points),
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
      zValue,
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

