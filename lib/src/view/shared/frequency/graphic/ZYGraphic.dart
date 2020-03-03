import 'dart:math';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ZYGraphic extends StatefulWidget {
  @override
  _ZYGraphicState createState() => _ZYGraphicState();
}

class _ZYGraphicState extends State<ZYGraphic> {
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
                
                LineSeries<SalesData,double>(
                  animationDuration: 0,
                  color: Colors.grey[300],
                  dataSource: getDynamicData(),
                  
                  xValueMapper: (SalesData sales,_) => sales.x,
                  yValueMapper: (SalesData sales,_) => sales.y,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}


class SalesData{
  double x,y;
  SalesData(this.x, this.y);
}

List<SalesData> dynamicData = <SalesData>[];
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

  dynamicData.add(SalesData(j.toDouble(), value));

  return dynamicData;
}


