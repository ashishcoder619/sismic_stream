import 'package:flutter/material.dart';
import 'package:sismic_stream/src/controller/xy.controller.dart';

class GettingData extends StatefulWidget {
  final XYController controllerXY;
  GettingData({
    this.controllerXY,
  });

  @override
  _GettingDataState createState() => _GettingDataState();
}

class _GettingDataState extends State<GettingData> {
  _saveData() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("Actual values:\n"),
          Text("X: ${widget.controllerXY}.x || Y: ${widget.controllerXY.y}"),
          RaisedButton(
            child: Text("save"),
            color: Colors.blue[300],
            onPressed: _saveData(),
          )
        ],
      ),
    );
  }
}
