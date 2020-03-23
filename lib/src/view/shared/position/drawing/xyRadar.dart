// import 'dart:math';

// import 'package:flutter/material.dart';

// class XYRadar extends CustomPainter {
//   List<List<int>> points;
//   XYRadar({
//     this.points,
//   });

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

//     var ticks = [0, 100, 150];

//     var ticksPaint = Paint()
//       ..color = Colors.grey
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 1.0
//       ..isAntiAlias = true;

//     var features = [
//       "A1",
//       "A2",
//       "A3",
//       "A4",
//       "A5",
//       "A6",
//       "A7",
//       "A8",
//       "A9",
//       "A10",
//       "A11",
//       "A12",
//       "A13",
//       "A14",
//       "A15",
//       "A16"
//     ];
//     var angle = (2 * pi) / features.length;
//     // var features = ["A1", "A2", "A3", "A4", "A5", "A6", "A7", "A8"];
//     // const double featureLabelFontSize = 16;
//     // const double featureLabelFontWidth = 12;

//     // points.asMap().forEach(
//       // (index, point) {
//         // Offset firstPoint = Offset(point[0].toDouble(), point[1].toDouble());
//     //     var xAngle = cos(angle * index - pi / 2);
//     //     var yAngle = sin(angle * index - pi / 2);

//     //     var featureOffset =
//     //         Offset(centerX + radius * xAngle, centerY + radius * yAngle);

//     //     // LINES OF AXIS
//         // canvas.drawLine(centerOffset, featureOffset, ticksPaint);
//         // canvas.drawLine(centerOffset, firstPoint, ticksPaint);

//     //     var labelYOffset = yAngle < 0 ? -featureLabelFontSize : 0;
//     //     var labelXOffset =
//     //         xAngle < 0 ? -featureLabelFontWidth * feature.length : 0;

//     //     TextPainter(
//     //       text: TextSpan(
//     //         text: feature,
//     //         style:
//     //             TextStyle(color: Colors.grey, fontSize: featureLabelFontSize),
//     //       ),
//     //       textAlign: TextAlign.center,
//     //       textDirection: TextDirection.ltr,
//     //     )
//     //       ..layout(minWidth: 0, maxWidth: size.width)
//     //       ..paint(
//     //         canvas,
//     //         Offset(featureOffset.dx + labelXOffset,
//     //             featureOffset.dy + labelYOffset),
//     //       );
//       // },
//     // );

//     // Map<String, bool> quadrant = {
//     //   "first": xValue > 0 && yValue > 0,
//     //   "second": xValue < 0 && yValue > 0,
//     //   "third": xValue < 0 && yValue < 0,
//     //   "fourth": xValue > 0 && yValue < 0,
//     // };
//     // Map<String, bool> quadrant = {
//     //   "first": xValue > 0 && yValue > 0,
//     //   "second": xValue < 0 && yValue > 0,
//     //   "third": xValue < 0 && yValue < 0,
//     //   "fourth": xValue > 0 && yValue < 0,
//     // };

//     // // fourth quadrant
//     // num a1 = quadrant["fourth"] || quadrant["third"] ? -yValue : 13;
//     // num a2 = quadrant["fourth"] ? -yValue / cos(22.5 * 0.0174533) : 13;
//     // num a3 = quadrant["fourth"] ? sqrt((xValue * xValue) + (yValue * yValue)) : 13;
//     // num a4 = quadrant["fourth"] ? xValue / cos(22.5 * 0.0174533) : 13;

//     // // first quadrant
//     // num a5 = quadrant["first"] || quadrant["fourth"] ? xValue : 13;
//     // num a6 = quadrant["first"] ? yValue / cos(22.5 * 0.0174533) : 13;
//     // num a7 =
//     //     quadrant["first"] ? sqrt((xValue * xValue) + (yValue * yValue)) : 13;
//     // num a8 = quadrant["first"] ? xValue / cos(22.5 * 0.0174533) : 13;

//     // // second quadrant
//     // num a9 = quadrant["second"] || quadrant["first"] ? yValue : 13;
//     // num a10 = quadrant["second"] ? yValue / cos(22.5 * 0.0174533) : 13;
//     // num a11 =
//     //     quadrant["second"] ? sqrt((xValue * xValue) + (yValue * yValue)) : 13;
//     // num a12 = quadrant["second"] ? -xValue / cos(22.5 * 0.0174533) : 13;

//     // // third quadrant
//     // num a13 = quadrant["third"] || quadrant["second"] ? -xValue : 13;
//     // num a14 = quadrant["third"] ? -xValue / cos(22.5 * 0.0174533) : 13;
//     // num a15 =
//     //     quadrant["third"] ? sqrt((xValue * xValue) + (yValue * yValue)) : 13;
//     // num a16 = quadrant["third"] ? -yValue / cos(22.5 * 0.0174533) : 13;

//     // MaterialColor graphColorSatate = quadrant >= 20 ? Colors.red : Colors.green;

//     // num a1 =
//     //     sqrt((points[0][0] * points[0][0]) + (points[0][1] * points[0][1]));
//     // num a2 =
//     //     sqrt((points[1][0] * points[1][0]) + (points[1][1] * points[1][1]));
//     // num a3 =
//     //     sqrt((points[2][0] * points[2][0]) + (points[2][1] * points[2][1]));
//     // num a4 =
//     //     sqrt((points[3][0] * points[3][0]) + (points[3][1] * points[3][1]));
//     // num a5 =
//     //     sqrt((points[4][0] * points[4][0]) + (points[4][1] * points[4][1]));
//     // num a6 =
//     //     sqrt((points[5][0] * points[5][0]) + (points[5][1] * points[5][1]));
//     // num a7 =
//     //     sqrt((points[6][0] * points[6][0]) + (points[6][1] * points[6][1]));
//     // num a8 =
//     //     sqrt((points[7][0] * points[7][0]) + (points[7][1] * points[7][1]));
//     // num a9 =
//     //     sqrt((points[8][0] * points[8][0]) + (points[8][1] * points[8][1]));
//     // num a10 =
//     //     sqrt((points[9][0] * points[9][0]) + (points[9][1] * points[9][1]));
//     // num a11 =
//     //     sqrt((points[10][0] * points[10][0]) + (points[10][1] * points[10][1]));
//     // num a12 =
//     //     sqrt((points[11][0] * points[11][0]) + (points[11][1] * points[11][1]));
//     // num a13 =
//     //     sqrt((points[12][0] * points[12][0]) + (points[12][1] * points[12][1]));
//     // num a14 =
//     //     sqrt((points[13][0] * points[13][0]) + (points[13][1] * points[13][1]));
//     // num a15 =
//     //     sqrt((points[14][0] * points[14][0]) + (points[14][1] * points[14][1]));
//     // num a16 =
//     //     sqrt((points[15][0] * points[15][0]) + (points[15][1] * points[15][1]));


//     List<List<num>> data = [points.map((e) => sqrt(e[0] * e[0] + e[1] * e[1])).toList()];

//     // List<List<num>> data = [
//     //   [
//     //     a1,
//     //     a2,
//     //     a3,
//     //     a4,
//     //     a5,
//     //     a6,
//     //     a7,
//     //     a8,
//     //     a9,
//     //     a10,
//     //     a11,
//     //     a12,
//     //     a13,
//     //     a14,
//     //     a15,
//     //     a16,
//     //   ],
//     // ];

//     // var angle = (2 * pi) / points.length;
//     // const double featureLabelFontSize = 16;
//     // const double featureLabelFontWidth = 12;

//     // points.asMap().forEach(
//     //   (index, feature) {
//     //     var xAngle = cos(angle * index - pi / 2);
//     //     var yAngle = sin(angle * index - pi / 2);

//         // var featureOffset =
//         //     Offset(centerX + radius * xAngle, centerY + radius * yAngle);
//         // var featureOffset =
//         //     Offset(points[index][0].toDouble(), points[index][1].toDouble());

//         // LINES OF AXIS
//         // canvas.drawLine(centerOffset, featureOffset, ticksPaint);
//         // canvas.drawLine(centerOffset, featureOffset, ticksPaint);

//         // var labelYOffset = yAngle < 0 ? -featureLabelFontSize : 0;
//         // var labelXOffset =
//         //     xAngle < 0 ? -featureLabelFontWidth * feature.length : 0;

//         // TextPainter(
//         //   text: TextSpan(
//         //     text: feature,
//         //     style:
//         //         TextStyle(color: Colors.grey, fontSize: featureLabelFontSize),
//         //   ),
//         //   textAlign: TextAlign.center,
//         //   textDirection: TextDirection.ltr,
//         // )
//           // ..layout(minWidth: 0, maxWidth: size.width)
//           // ..paint(
//           //   canvas,
//           //   Offset(featureOffset.dx + labelXOffset,
//           //       featureOffset.dy + labelYOffset),
//           // );
//       // },
//     // );

    

//     MaterialColor _invalidPosition() {
//       List positions = [...data[0]];
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
//             // var xAngle = cos(angle * (index + 1) - pi / 2);
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
//   bool shouldRepaint(XYRadar oldDelegate) {
//     return false;
//   }
// }
import "package:flutter/material.dart";

class RoundPolygonPainter extends CustomPainter {
  List<List<int>> points;
  RoundPolygonPainter({this.points});
  @override
  void paint(Canvas canvas, Size size) {
    Path path = new Path();
    var coord = points.map((point) => Offset(point[0].toDouble(), -point[1].toDouble())).toList();
    path.addPolygon(coord, true);
    
    var graphOutlinePaint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..isAntiAlias = true;

    Paint paint = Paint();
    paint.style = PaintingStyle.fill;
    paint.color = Colors.red.withOpacity(0.5);
    paint.strokeWidth = 1.0;
    paint.strokeJoin = StrokeJoin.round;
    canvas.drawPath(path, graphOutlinePaint);
    canvas.drawPath(path, paint);


    Path staticPath = new Path();
    var staticCoord = [
      Offset(-150, 0),
      Offset(-120, 60),
      Offset(-90, 80),
      Offset(-60, 91.6515138991168),
      Offset(-30, 97.97958971132712),
      Offset(0, 100),
      Offset(30, 97.97958971132712),
      Offset(60, 91.6515138991168),
      Offset(90, 80),
      Offset(120, 60),
      Offset(150, 0),
      Offset(120, -60),
      Offset(90, -80),
      Offset(60, -91.6515138991168),
      Offset(30, -97.97958971132712),
      Offset(0, -100),
      Offset(-30, -97.97958971132712),
      Offset(-60, -91.6515138991168),
      Offset(-90, -80),
      Offset(-120, -60),
      Offset(-150, 0)
    ];
    staticPath.addPolygon(staticCoord, true);
    
    var outlinePaint = Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4.0
        ..isAntiAlias = true;

    canvas.drawPath(staticPath, outlinePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
