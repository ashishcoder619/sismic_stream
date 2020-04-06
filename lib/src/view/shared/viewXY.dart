import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sismic_stream/src/controller/xy.controller.dart';

import 'frequency/XYFrequency.dart';
import 'position/xyPosition.dart';

class ViewXY extends StatelessWidget {
  final _controllerXY = GetIt.I.get<XYController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 7,
          child: Center(
            child: XYPosition(
              gValue: _controllerXY.g,
              points: _controllerXY.points,
              pointsWithRange: _controllerXY.pointsWithRange,
              isInRange: _controllerXY.isInRange,
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Center(
            child: XYFrequency(
              hzMax: _controllerXY.hzMaxXY,
              hz: _controllerXY.hzXY,
              hzMin: _controllerXY.hzMinXY,
            ),
          ),
        ),
      ],
    );
  }
}