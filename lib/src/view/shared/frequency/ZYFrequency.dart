import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './graphic/ZYGraphic.dart';

class ZYFrequency extends StatelessWidget {
  int hz;
  int hzMax;
  int hzMin;

  ZYFrequency({
    this.hz,
    this.hzMax,
    this.hzMin,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(right: 20.0,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                "${this.hzMax}",
                style: TextStyle(
                  fontFamily: 'Quebec Black',
                  fontSize: 15.0
                ),
              ),
              Text(
                "Hz",
                style: TextStyle(
                  color: Colors.lightBlue, 
                  fontFamily: 'Quebec Black', 
                  fontSize: 15.0,
                ),
              ),
            ],
          ),
        ),
        Stack(
          alignment: Alignment(0, 0),
          children: <Widget>[
            ZYGraphic(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${this.hz}",
                  style: TextStyle(
                    fontFamily: 'Quebec Black',
                    fontSize: 40.0
                  ),
                ),
                Text(
                  "Hz",
                  style: TextStyle(
                    color: Colors.lightBlue, 
                    fontFamily: 'Quebec Black', 
                    fontSize: 40.0
                  ),
                ),
              ],
            ),
          ]
        ),
        Container(
          margin: const EdgeInsets.only(right: 20.0,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${this.hzMin}",
                style: TextStyle(
                  fontFamily: 'Quebec Black',
                  fontSize: 15.0
                ),
              ),
              Text(
                "Hz",
                style: TextStyle(
                  color: Colors.lightBlue, 
                  fontFamily: 'Quebec Black', 
                  fontSize: 15.0
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}