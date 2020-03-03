import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './graphic/XYGraphic.dart';

class HzMetric {
  int _hzMax;
  int _hzMin;
  set changeHzMax(int newHzMax) => newHzMax > _hzMax ? _hzMax = newHzMax : _hzMax;
  set changeHzMin(int newHzMin) => newHzMin < _hzMin ? _hzMin = newHzMin : _hzMin;
  int get hzMax => _hzMax;
  int get hzMin => _hzMin;
}

class XYFrequency extends StatelessWidget {
  final Stream<List<int>> stream;
  XYFrequency({this.stream});
  int hzMax = 0;
  int hzMin = 0;
  int contHz = 0;

  List<num> _listParser(List<int> dataFromDevice) {
    String stringData = utf8.decode(dataFromDevice);
    return stringData.split('|').map((e) => num.parse(e)).toList();
  }

  _hzMax(int hz) {
    if (this.contHz == 1) {
        hzMax = hz;
    } else if (hz > hzMax) {
        hzMax = hz;
    }
      contHz++;
    return Container(
      margin: const EdgeInsets.only(
        right: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            "${this.hzMax}",
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

  _hz(int hz) {
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

  _hzMin(int hz) {
    if (this.contHz == 1) {
        hzMin = hz;
    } else if (hz > hzMin) {
        hzMin = hz;
    }
      contHz++;
    return Container(
      margin: const EdgeInsets.only(
        right: 20.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "${this.hzMin}",
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
    return StreamBuilder<List<int>>(
      stream: stream,
      initialData: [],
      builder: (BuildContext context, AsyncSnapshot<List<int>> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot?.connectionState == ConnectionState.active) {
          int hz = _listParser(snapshot.data)[4];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _hzMax(hz),
              _hz(hz),
              _hzMin(hz),
            ],
          );
        }
        return Container();
      },
    );
  }
}


