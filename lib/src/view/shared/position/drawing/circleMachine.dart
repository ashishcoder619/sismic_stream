import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircleMachine extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.blue[200];
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = size.width/35;
    var center = Offset(size.width / 2, size.height / 2);
    
    for(int i=0; i<36; i++){
      canvas.drawArc(
        Rect.fromCircle(center: center,radius: size.width / 3),
        (-90.0 + i*10)*0.0174533, 8*0.0174533,
        false,
        paint
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
  CircleMachine();
}