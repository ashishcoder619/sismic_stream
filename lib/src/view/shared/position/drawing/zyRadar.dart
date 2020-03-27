// import 'dart:math';

// import 'package:flutter/material.dart';

// class ZYRadar extends CustomPainter {
//   int zValue;
//   int yValue;
//   ZYRadar({this.zValue, this.yValue});

//   @override
//   void paint(Canvas canvas, Size size) {
//     var centerX = size.width / 2.0;
//     var centerY = size.height / 2.0;
//     var centerOffset = Offset(centerX, centerY);
//     var radius = centerX * 0.8;

//     var outlinePaint = Paint()
//       ..color = Colors.grey
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.0
//       ..isAntiAlias = true;

//     canvas.drawCircle(centerOffset, radius, outlinePaint);

//     var ticks = [5, 10, 20];

//     var ticksPaint = Paint()
//       ..color = Colors.grey
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0
//       ..isAntiAlias = true;

//     var features = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8", "A9", "A10", "A11", "A12", "A13", "A14", "A15", "A16"];
//     // var features = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8"];
//     var angle = (2 * pi) / features.length;
//     const double featureLabelFontSize = 16;
//     const double featureLabelFontWidth = 12;

//     features.asMap().forEach((index, feature) {
//       var xAngle = cos(angle * index - pi / 2);
//       var yAngle = sin(angle * index - pi / 2);

//       var featureOffset =
//           Offset(centerX + radius * xAngle, centerY + radius * yAngle);
      
//       // LINES OF AXIS
//       // canvas.drawLine(centerOffset, featureOffset, ticksPaint);

//       var labelYOffset = yAngle < 0 ? -featureLabelFontSize : 0;
//       var labelXOffset =
//           xAngle < 0 ? -featureLabelFontWidth * feature.length : 0;

//       TextPainter(
//         text: TextSpan(
//           text: feature,
//           style: TextStyle(color: Colors.grey, fontSize: featureLabelFontSize),
//         ),
//         textAlign: TextAlign.center,
//         textDirection: TextDirection.ltr,
//       )
//         ..layout(minWidth: 0, maxWidth: size.width)
//         ..paint(
//             canvas,
//             Offset(featureOffset.dx + labelXOffset,
//                 featureOffset.dy + labelYOffset));
//     });

//     Map<String, bool> quadrant = {
//       "first": zValue > 0 && yValue > 0,
//       "second": zValue < 0 && yValue > 0,
//       "third": zValue < 0 && yValue < 0,
//       "fourth": zValue > 0 && yValue < 0,
//     };


//     // fourth quadrant
//     num a1 = quadrant["fourth"] || quadrant["third"] ? -yValue : 13;
//     num a2 = quadrant["fourth"] ? -yValue / cos(22.5 * 0.0174533) : 13;
//     num a3 = quadrant["fourth"] ? sqrt((zValue * zValue)+(yValue*yValue)) : 13;
//     num a4 = quadrant["fourth"] ? zValue / cos(22.5 * 0.0174533) : 13;

//     // first quadrant
//     num a5 = quadrant["first"] || quadrant["fourth"] ? zValue : 13;                                                                                         
//     num a6 = quadrant["first"] ? zValue / cos(22.5 * 0.0174533) : 13;                                                                                                                                                               
//     num a7 = quadrant["first"] ? sqrt((zValue * zValue)+(yValue*yValue)) : 13;                                                                                                                                                               
//     num a8 = quadrant["first"] ? yValue / cos(22.5 * 0.0174533) : 13;                                                                                         
    
//     // second quadrant
//     num a9 = quadrant["second"] || quadrant["first"] ? yValue : 13;
//     num a10 = quadrant["second"] ? zValue / cos(22.5 * 0.0174533) : 13;
//     num a11 = quadrant["second"] ? sqrt((zValue * zValue)+(yValue*yValue)) : 13;
//     num a12 = quadrant["second"] ? -yValue / cos(22.5 * 0.0174533) : 13;
    
//     // third quadrant
//     num a13 = quadrant["third"] || quadrant["second"] ? -zValue : 13;
//     num a14 = quadrant["third"] ? -zValue / cos(22.5 * 0.0174533) : 13;
//     num a15 = quadrant["third"] ? sqrt((zValue * zValue)+(yValue*yValue)) : 13;
//     num a16 = quadrant["third"] ? -yValue / cos(22.5 * 0.0174533)  : 13;

//     List data = [
//       [
//         a1,
//         a2,
//         a3,
//         a4,
//         a5,
//         a6,
//         a7,
//         a8,
//         a9,
//         a10,
//         a11,
//         a12,
//         a13,
//         a14,
//         a15,
//         a16,
//       ],
//     ];

//     MaterialColor _invalidPosition(){
//       List positions = [...data[0], zValue, yValue];
//       List invalids = positions.where((e) => e > 20).toList();
//       return invalids.length > 0 ? Colors.red : Colors.green;
//     }
      
    
//     MaterialColor graphColorSatate = _invalidPosition();
//     List<MaterialColor> graphColors = [graphColorSatate];
//     var scale = radius / ticks.last;

//     data.asMap().forEach(
//       (index, graph) {
//         var graphPaint = Paint()
//           ..color = graphColors[index % graphColors.length].withOpacity(0.3)
//           ..style = PaintingStyle.fill;

//         var graphOutlinePaint = Paint()
//           ..color = graphColors[index % graphColors.length]
//           ..style = PaintingStyle.stroke
//           ..strokeWidth = 2.0
//           ..isAntiAlias = true;

//         // Start the graph on the initial point
//         var scaledPoint = scale * graph[0];
//         var path = Path();

//         path.moveTo(centerX, centerY - scaledPoint);

//         graph.sublist(1).asMap().forEach(
//           (index, point) {
//             var xAngle = cos(angle * (index + 1) - pi / 2);
//             var yAngle = sin(angle * (index + 1) - pi / 2);
//             var scaledPoint = scale * point;

//             path.lineTo(
//               centerX + scaledPoint * xAngle,
//               centerY + scaledPoint * yAngle,
//             );
//           },
//         );

//         path.close();
//         canvas.drawPath(path, graphPaint);
//         canvas.drawPath(path, graphOutlinePaint);
//       },
//     );
//   }

//   @override
//   bool shouldRepaint(ZYRadar oldDelegate) {
//     return false;
//   }
// }

import "package:flutter/material.dart";

import 'dart:math';
import 'drawRoundAngle/PolygonUtil.dart';
import 'drawRoundAngle/size_const.dart';

const List<Point> POINT = [Point(100, 100)];

SizeUtil get _sizeUtil {
  return SizeUtil.getInstance(key: SizeKeyConst.ROUND_ANGLE_KEY);
}

class ZYRadar extends CustomPainter {
  List<List<int>> points;
  ZYRadar({this.points});

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
    List<Point> list1 = points.map((e) => Point(e[2].toDouble(), -e[1].toDouble())).toList();
    
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

