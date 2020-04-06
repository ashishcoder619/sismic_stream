import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sismic_stream/src/controller/zy.controller.dart';

import 'frequency/ZYFrequency.dart';
import 'position/zyPosition.dart';

class ViewZY extends StatelessWidget {
  final _controllerZY = GetIt.I.get<ZYController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Flexible(
          flex: 7,
          child: Center(
            child: ZYPosition(
              gValue: _controllerZY.g,
              points: _controllerZY.points,
              angle: _controllerZY.angleZY,
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Center(
            child: ZYFrequency(
              hzMax: _controllerZY.hzMaxZY,
              hz: _controllerZY.hzZY,
              hzMin: _controllerZY.hzMinZY,
            ),
          ),
        ),
      ],
    );
  }
}