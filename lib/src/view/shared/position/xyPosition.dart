import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
// import './drawing/circleMachine.dart';
// import './drawing/xyLimit.dart';
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

  Widget _position(int xValue, int yValue, double gValue) {
    return Stack(
      alignment: Alignment(0, 0),
      children: <Widget>[
        Image(
          image: AssetImage('assets/images/TOP.png'),
        ),
        Stack(alignment: Alignment(0, 0),
            // children: <Widget>[
            //   Center(
            //     child: Text("POINTS: $points"),
            //   ),
            // ],
            // children:
            //   points
            //       .map(
            //         (point) => Marker(
            //           x: point[0],
            //           y: point[1],
            //         ),
            //       )
            //       .toList(),
            // children: <Widget>[
            //   Marker(
            //     x: 0,
            //     y: 0,
            //   ),
            // ],
            children: <Widget>[
              Stack(
                alignment: Alignment(0, 0),
                children: points
                    .map(
                      (point) => Marker(
                        x: point[0],
                        y: point[1],
                      ),
                    )
                    .toList(),
              ),
              CustomPaint(
                painter: XYRadar(
                  // xValue: -xValue,
                  // yValue: yValue,
                  points: points,
                ),
                child: Center(),
              ),
            ]
            // CustomPaint(
            //   painter: XYRadar(
            //     points: points,
            //   ),
            //   child: Center(),
            // ),

            //   // Column(
            //   //   crossAxisAlignment: CrossAxisAlignment.stretch,
            //   //   children: points.map(
            //   //     (point) => Marker(
            //   //       x: point[0],
            //   //       y: point[1],
            //   //     ),
            //   //   ).toList(),
            //   // )
            //   // CustomPaint(
            //   //   painter: XYLimit(
            //   //     x: xValue,
            //   //     y: yValue,
            //   //   ),
            //   //   child: Center(),
            //   // ),
            //   // Marker(
            //   //   x: -xValue,
            //   //   y: yValue,
            //   // ),
            // ],
            ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: <Widget>[
        //     Text(
        //       "$gValue",
        //       style: TextStyle(fontFamily: 'Quebec Black', fontSize: 40.0),
        //     ),
        //     Text(
        //       "G",
        //       style: TextStyle(
        //         fontFamily: 'Quebec Black',
        //         color: Colors.lightBlue,
        //         fontSize: 40.0,
        //       ),
        //     ),
        //   ],
        // ),
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
    // print("x: $x, y: $y");
    return Transform(
      transform: Matrix4.translationValues(x.toDouble(), -y.toDouble(), 0.0),
      child: CustomPaint(
        // painter: CircleMachine(x: this.x, y: this.y),
        child: CircleAvatar(
          radius: 5,
          backgroundColor: Colors.green,
        ),
      ),
    );
  }
}
