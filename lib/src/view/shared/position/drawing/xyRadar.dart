import 'dart:math';

import 'package:flutter/material.dart';

class XYRadar extends CustomPainter {
  int xValue;
  int yValue;
  XYRadar({this.xValue, this.yValue});

  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2.0;
    var centerY = size.height / 2.0;
    var centerOffset = Offset(centerX, centerY);
    var radius = centerX * 0.8;

    var outlinePaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..isAntiAlias = true;

    canvas.drawCircle(centerOffset, radius, outlinePaint);

    var ticks = [8, 10, 13];

    var ticksPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;

    var features = ["AA", "BB", "CC", "DD", "EE", "CC", "DD", "EE"];
    var angle = (2 * pi) / features.length;
    const double featureLabelFontSize = 16;
    const double featureLabelFontWidth = 12;

    features.asMap().forEach((index, feature) {
      var xAngle = cos(angle * index - pi / 2);
      var yAngle = sin(angle * index - pi / 2);

      var featureOffset =
          Offset(centerX + radius * xAngle, centerY + radius * yAngle);

      canvas.drawLine(centerOffset, featureOffset, ticksPaint);

      var labelYOffset = yAngle < 0 ? -featureLabelFontSize : 0;
      var labelXOffset =
          xAngle < 0 ? -featureLabelFontWidth * feature.length : 0;

      TextPainter(
        text: TextSpan(
          text: feature,
          style: TextStyle(color: Colors.grey, fontSize: featureLabelFontSize),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )
        ..layout(minWidth: 0, maxWidth: size.width)
        ..paint(
            canvas,
            Offset(featureOffset.dx + labelXOffset,
                featureOffset.dy + labelYOffset));
    });
    const graphColors = [Colors.green, Colors.blue];
    var scale = radius / ticks.last;
    var data = [
      [
        yValue,
        yValue/cos(0.785398),
        xValue,
        xValue/cos(0.785398) ,
        yValue,
        28,
        15,
        16,
      ],
    ];

    data.asMap().forEach((index, graph) {
      var graphPaint = Paint()
        ..color = graphColors[index % graphColors.length].withOpacity(0.3)
        ..style = PaintingStyle.fill;

      var graphOutlinePaint = Paint()
        ..color = graphColors[index % graphColors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..isAntiAlias = true;

      // Start the graph on the initial point
      var scaledPoint = scale * graph[0];
      var path = Path();

      path.moveTo(centerX, centerY - scaledPoint);

      graph.sublist(1).asMap().forEach((index, point) {
        var xAngle = cos(angle * (index + 1) - pi / 2);
        var yAngle = sin(angle * (index + 1) - pi / 2);
        var scaledPoint = scale * point;

        path.lineTo(
            centerX + scaledPoint * xAngle, centerY + scaledPoint * yAngle);
      });

      path.close();
      canvas.drawPath(path, graphPaint);
      canvas.drawPath(path, graphOutlinePaint);
    });
  }

  @override
  bool shouldRepaint(XYRadar oldDelegate) {
    return false;
  }
}
