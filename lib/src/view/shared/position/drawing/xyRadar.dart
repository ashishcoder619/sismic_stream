import "package:flutter/material.dart";

class XYRadar extends CustomPainter {
  List<List<int>> points;
  XYRadar({this.points});
  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();
    var coord = points
        .map((point) => Offset(point[0].toDouble(), -point[1].toDouble()))
        .toList();
    path.addPolygon(coord, true);

    var graphOutlinePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = false;

    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = Colors.red.withOpacity(0.5);
    paint.strokeWidth = 1.0;
    paint.strokeJoin = StrokeJoin.round;

    canvas.drawPath(path, paint);
    canvas.drawPath(path, graphOutlinePaint);


  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}


