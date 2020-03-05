import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './graphic/XYGraphic.dart';

class XYFrequency extends StatelessWidget {
  final int hz;
  final int hzMax;
  final int hzMin;
  XYFrequency({
    this.hzMax,
    this.hz,
    this.hzMin,
  });

  _hzMax() {
    return Container(
      margin: const EdgeInsets.only(
        right: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "$hzMax",
            style: TextStyle(fontFamily: 'Quebec Black', fontSize: 15.0),
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
    );
  }

  _hz() {
    return Stack(
      alignment: Alignment(0, 0),
      children: <Widget>[
        XYGraphic(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "$hz",
              style: TextStyle(fontFamily: 'Quebec Black', fontSize: 40.0),
            ),
            Text(
              "Hz",
              style: TextStyle(
                color: Colors.lightBlue,
                fontFamily: 'Quebec Black',
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      ],
    );
  }

  _hzMin() {
    return Container(
      margin: const EdgeInsets.only(
        right: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "$hzMin",
            style: TextStyle(fontFamily: 'Quebec Black', fontSize: 15.0),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _hzMax(),
        _hz(),
        _hzMin(),
      ],
    );
  }
}
