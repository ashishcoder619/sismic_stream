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

    var ticks = [5, 10, 20];

    var ticksPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;

    // var features = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12", "A13", "A14", "A15", "A16", "A17", "A18", "A19", "A20"];
    var features = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8"];
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
    
    double quadrant = sqrt((xValue * xValue) + (yValue * yValue));
    MaterialColor graphColorSatate = quadrant >= 20 ? Colors.red : Colors.green;
    List<MaterialColor> graphColors = [graphColorSatate];
    var scale = radius / ticks.last;

    List data = [
      [
        10,
        10,
        xValue,
        quadrant,
        yValue,
        10,
        10,
        10,
      ],
    ];

    data.asMap().forEach(
      (index, graph) {
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

        graph.sublist(1).asMap().forEach(
          (index, point) {
            var xAngle = cos(angle * (index + 1) - pi / 2);
            var yAngle = sin(angle * (index + 1) - pi / 2);
            var scaledPoint = scale * point;

            path.lineTo(
              centerX + scaledPoint * xAngle,
              centerY + scaledPoint * yAngle,
            );
          },
        );

        path.close();
        canvas.drawPath(path, graphPaint);
        canvas.drawPath(path, graphOutlinePaint);
      },
    );
  }

  @override
  bool shouldRepaint(XYRadar oldDelegate) {
    return false;
  }
}
