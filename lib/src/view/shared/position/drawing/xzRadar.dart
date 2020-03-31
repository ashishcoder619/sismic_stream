// import "package:flutter/material.dart";

// class XZRadar extends CustomPainter {
//   List<List<int>> points;
//   XZRadar({this.points});
//   @override
//   void paint(Canvas canvas, Size size) {
//     Path path = new Path();
//     var coord = points
//         .map((point) => Offset(point[0].toDouble(), -point[2].toDouble()))
//         .toList();
//     path.addPolygon(coord, true);

//     var graphOutlinePaint = Paint()
//       ..color = Colors.red
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0
//       ..isAntiAlias = false;

//     Paint paint = Paint();
//     paint.style = PaintingStyle.fill;
//     paint.color = Colors.red.withOpacity(0.5);
//     paint.strokeWidth = 1.0;
//     paint.strokeJoin = StrokeJoin.round;

//     canvas.drawPath(path, paint);
//     canvas.drawPath(path, graphOutlinePaint);

//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
import "package:flutter/material.dart";

import 'dart:math';
import 'drawRoundAngle/PolygonUtil.dart';
import 'drawRoundAngle/size_const.dart';

const List<Point> POINT = [Point(100, 100)];

SizeUtil get _sizeUtil {
  return SizeUtil.getInstance(key: SizeKeyConst.ROUND_ANGLE_KEY);
}

class XZRadar extends CustomPainter {
  List<List<int>> points;
  XZRadar({this.points});

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width > 1.0 && size.height > 1.0) {
      _sizeUtil.logicSize = size;
      print(">1.9");
    }
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.green[600].withOpacity(0.5)
      ..isAntiAlias = true;
    List<Point> list1 =
        points.map((e) => Point(e[0].toDouble(), -e[2].toDouble())).toList();

    var graphOutlinePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = false;
    _drawWithPoint(canvas, paint, list1);
    _drawWithPoint(canvas, graphOutlinePaint, list1);
    canvas.save();
    canvas.restore();
  }

  void _drawWithPoint(canvas, paint, list, {hasShadow = false}) {
    var path = PolygonUtil.drawRoundPolygon(list, canvas, paint, distance: 2.0);
    if (hasShadow) {
      canvas.drawShadow(path, Colors.black26, 10.0, true);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class XZAngle extends CustomPainter {
  final double angle;
  XZAngle({this.angle});
  @override
  void paint(Canvas canvas, Size size) {
    var ticksPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true;

    double centerX = size.width / 2.0;
    double centerY = size.height / 2.0;
    double useAngle = (angle - 90) * 0.0174533;
    // var centerOffset = Offset(centerX, centerY);
    double xAngle(double newAngle) => cos(newAngle * 1 - pi / 2);
    double yAngle(double newAngle) => sin(newAngle * 1 - pi / 2);

    Offset featureOffset(int value) => Offset(
        centerX + value * xAngle(useAngle), centerY + value * yAngle(useAngle));
    int cont = 1;
    int init = 5;
    int end = 10;
    while (cont < 13) {
      if (cont == 1) {
        canvas.drawCircle(featureOffset(0), 2.0, ticksPaint);
      }
      canvas.drawLine(
        featureOffset(init),
        featureOffset(end),
        ticksPaint,
      );
      canvas.drawLine(
        featureOffset(-init),
        featureOffset(-end),
        ticksPaint,
      );
      init = init + 10;
      end = end + 10;
      cont++;
    }
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      ticksPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
