import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sismic_stream/src/controller/xz.controller.dart';

import 'frequency/XZFrequency.dart';
import 'position/xzPosition.dart';

class ViewXZ extends StatelessWidget {
  final _controllerXZ = GetIt.I.get<XZController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 7,
          child: Center(
            child: XZPosition(
              gValue: _controllerXZ.g,
              points: _controllerXZ.points,
              angle: _controllerXZ.angleXZ,
            ),
          ),
        ),
        Flexible(
          flex: 3,
          child: Center(
            child: XZFrequency(
              hzMax: _controllerXZ.hzMaxXZ,
              hz: _controllerXZ.hzXZ,
              hzMin: _controllerXZ.hzMinXZ,
            ),
          ),
        ),
      ],
    );
  }
}