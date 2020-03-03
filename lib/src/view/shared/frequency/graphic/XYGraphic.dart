// import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class XYGraphic extends StatefulWidget {
  @override
  _XYGraphicState createState() => _XYGraphicState();
}

class _XYGraphicState extends State<XYGraphic> {
  // Stopwatch watch = Stopwatch();
  // Timer timer;
  

  // startWatch() {
    // watch.start();
    // timer = Timer.periodic(Duration(milliseconds: 500), getDynamicData());
  // }

  @override
  Widget build(BuildContext context) {


    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 100,
            child: SfCartesianChart(
              
              primaryXAxis: NumericAxis( 
                isVisible: false,
              ), 

              primaryYAxis: NumericAxis(
                minimum: 18,
                maximum: 24, 
                //Hide the gridlines of y-axis 
                majorGridLines: MajorGridLines(width: 0), 
                //Hide the axis line of y-axis 
                axisLine: AxisLine(width: 0),
                interval: 1,
              ),
              series: <ChartSeries>[
                
                LineSeries<PositionData,double>(
                  animationDuration: 0,
                  color: Colors.grey[300],
                  dataSource: getDynamicData(),
                  xValueMapper: (PositionData position,_) => position.x,
                  yValueMapper: (PositionData position,_) => position.y,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class PositionData{
  double x,y;
  PositionData(this.x, this.y);
}

List<PositionData> dynamicData = <PositionData>[];
int j = 0;

dynamic getDynamicData() {
  j++;
  double value = 22;
  Random rand = Random();
  double k = (rand.nextInt(4).toDouble());

  if (k > 20) {
    value += k;
  } else {
    value -= k;
  }
  if (j > 30) {
    dynamicData.removeAt(0);
  }

  dynamicData.add(PositionData(j.toDouble(), value));

  return dynamicData;
}


