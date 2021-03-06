import 'dart:math';

import 'package:flutter/material.dart';

class XZRadar extends CustomPainter {
  int xValue;
  int zValue;
  XZRadar({this.xValue, this.zValue});

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

    var features = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12", "A13", "A14", "A15", "A16"];
    // var features = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8"];
    var angle = (2 * pi) / features.length;
    const double featureLabelFontSize = 16;
    const double featureLabelFontWidth = 12;

    features.asMap().forEach((index, feature) {
      var xAngle = cos(angle * index - pi / 2);
      var yAngle = sin(angle * index - pi / 2);

      var featureOffset =
          Offset(centerX + radius * xAngle, centerY + radius * yAngle);
      
      // LINES OF AXIS
      // canvas.drawLine(centerOffset, featureOffset, ticksPaint);

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

    Map<String, bool> quadrant = {
      "first": xValue > 0 && zValue > 0,
      "second": xValue < 0 && zValue > 0,
      "third": xValue < 0 && zValue < 0,
      "fourth": xValue > 0 && zValue < 0,
    };


    // fourth quadrant
    num a1 = quadrant["fourth"] || quadrant["third"] ? -zValue : 13;
    num a2 = quadrant["fourth"] ? -zValue / cos(22.5 * 0.0174533) : 13;
    num a3 = quadrant["fourth"] ? sqrt((xValue * xValue)+(zValue*zValue)) : 13;
    num a4 = quadrant["fourth"] ? xValue / cos(22.5 * 0.0174533) : 13;

    // first quadrant
    num a5 = quadrant["first"] || quadrant["fourth"] ? xValue : 13;                                                                                         
    num a6 = quadrant["first"] ? zValue / cos(22.5 * 0.0174533) : 13;                                                                                                                                                               
    num a7 = quadrant["first"] ? sqrt((xValue * xValue)+(zValue*zValue)) : 13;                                                                                                                                                               
    num a8 = quadrant["first"] ? xValue / cos(22.5 * 0.0174533) : 13;                                                                                         
    
    // second quadrant
    num a9 = quadrant["second"] || quadrant["first"] ? zValue : 13;
    num a10 = quadrant["second"] ? zValue / cos(22.5 * 0.0174533) : 13;
    num a11 = quadrant["second"] ? sqrt((xValue * xValue)+(zValue*zValue)) : 13;
    num a12 = quadrant["second"] ? -xValue / cos(22.5 * 0.0174533) : 13;
    
    // third quadrant
    num a13 = quadrant["third"] || quadrant["second"] ? -xValue : 13;
    num a14 = quadrant["third"] ? -xValue / cos(22.5 * 0.0174533) : 13;
    num a15 = quadrant["third"] ? sqrt((xValue * xValue)+(zValue*zValue)) : 13;
    num a16 = quadrant["third"] ? -zValue / cos(22.5 * 0.0174533)  : 13;

    // MaterialColor graphColorSatate = quadrant >= 20 ? Colors.red : Colors.green;

    List data = [
      [
        a1,
        a2,
        a3,
        a4,
        a5,
        a6,
        a7,
        a8,
        a9,
        a10,
        a11,
        a12,
        a13,
        a14,
        a15,
        a16,
      ],
    ];
    MaterialColor _invalidPosition(){
      List positions = [...data[0], xValue, zValue];
      List invalids = positions.where((e) => e > 20).toList();
      return invalids.length > 0 ? Colors.red : Colors.green;
    }
      
    
    MaterialColor graphColorSatate = _invalidPosition();
    List<MaterialColor> graphColors = [graphColorSatate];
    var scale = radius / ticks.last;

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
  bool shouldRepaint(XZRadar oldDelegate) {
    return false;
  }
}
