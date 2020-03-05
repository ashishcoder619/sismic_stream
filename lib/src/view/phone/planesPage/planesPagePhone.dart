import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:sismic_stream/src/view/shared/frequency/XYFrequency.dart';
import 'package:sismic_stream/src/view/shared/frequency/XZFrequency.dart';
import 'package:sismic_stream/src/view/shared/frequency/ZYFrequency.dart';
import 'package:sismic_stream/src/view/shared/position/xyPosition.dart';
import 'package:sismic_stream/src/view/shared/position/xzPosition.dart';
import 'package:sismic_stream/src/view/shared/position/zyPosition.dart';

class PlanesPagePhone extends StatefulWidget {
  const PlanesPagePhone({Key key, this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  _PlanesPagePhoneState createState() => _PlanesPagePhoneState();
}

class _PlanesPagePhoneState extends State<PlanesPagePhone> {
  final String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String CHARACTERISTIC_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  Stream<List<int>> stream;
  bool isReady;

  int _x;
  int _y;
  int _z;
  double _g;
  int _hz;
  int _hzMax;
  int _hzMin;
  int _contHz = 0;

  _verifyHz(int newHz) {
    if (_contHz == 0) {
      _hzMax = newHz;
      _hzMin = newHz;
      _contHz++;
    } else {
      if (newHz > _hzMax)
        _hzMax = newHz;
      if (newHz < _hzMin)
        _hzMin = newHz;
    }
  }

  @override
  void initState() {
    super.initState();
    isReady = false;
    connectToDevice();
  }

  connectToDevice() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    Timer(const Duration(seconds: 15), () {
      if (!isReady) {
        disconnectFromDevice();
        _Pop();
      }
    });

    await widget.device.connect();
    discoverServices();
  }

  disconnectFromDevice() {
    if (widget.device == null) {
      _Pop();
      return;
    }

    widget.device.disconnect();
  }

  discoverServices() async {
    if (widget.device == null) {
      _Pop();
      return;
    }

    List<BluetoothService> services = await widget.device.discoverServices();
    services.forEach(
      (service) {
        if (service.uuid.toString() == SERVICE_UUID) {
          service.characteristics.forEach(
            (characteristic) {
              if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
                characteristic.setNotifyValue(!characteristic.isNotifying);
                stream = characteristic.value.asBroadcastStream();
                if (mounted) {
                  setState(
                    () {
                      isReady = true;
                    },
                  );
                }
              }
            },
          );
        }
      },
    );
    if (!isReady) {
      _Pop();
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Are you sure?'),
            content: Text('Do you want to disconnect device and go back?'),
            actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No')),
              FlatButton(
                onPressed: () {
                  disconnectFromDevice();
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes'),
              ),
            ],
          ) ??
          false,
    );
  }

  _Pop() {
    Navigator.of(context).pop(true);
  }

  List<num> _listParser(List<int> dataFromDevice) {
    String stringData = utf8.decode(dataFromDevice);
    return stringData.split('|').map((e) => num.parse(e)).toList();
  }

  // View Functions
  _viewXY() {
    return Column(
      children: <Widget>[
        XYPosition(
          xValue: this._x,
          yValue: this._y,
          gValue: this._g,
        ),
        XYFrequency(
          hzMax: this._hzMax,
          hz: this._hz,
          hzMin: this._hzMin,
        )
      ],
    );
  }

  _viewXZ(){
    return Column(
      children: <Widget>[
        XZPosition(
          xValue: this._x,
          zValue: this._z,
          gValue: this._g,
        ),
        XZFrequency(
          hzMax: this._hzMax,
          hz: this._hz,
          hzMin: this._hzMin,
        )
      ],
    );
  }

  _viewZY(){
    return Column(
      children: <Widget>[
        ZYPosition(
          zValue: this._z,
          yValue: this._y,
          gValue: this._g,
        ),
        ZYFrequency(
          hzMax: this._hzMax,
          hz: this._hz,
          hzMin: this._hzMin,
        )
      ],
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        'SISMIC',
        style: TextStyle(
          color: Colors.black,
          fontSize: 26,
        ),
      ),
      bottom: TabBar(
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(color: Colors.grey),
        tabs: <Widget>[
          Tab(
            text: "X : Y",
          ),
          Tab(
            text: "X : Z",
          ),
          Tab(
            text: "Z : Y",
          ),
        ],
      ),
    );
  }

  _body() {
    return StreamBuilder<List<int>>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot?.connectionState == ConnectionState.active) {
          List<num> arrData = _listParser(snapshot.data);
          _x = arrData[0];
          _y = arrData[1];
          _z = arrData[2];
          _g = arrData[3];
          _hz = arrData[4];
          _verifyHz(_hz);
          return TabBarView(
            children: <Widget>[
              _viewXY(),
              _viewXZ(),
              _viewZY(),
            ],
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          child: !isReady
              ? Center(
                  child: Text(
                    'SISMIC',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Quebec Black',
                      fontSize: 26,
                    ),
                  ),
                )
              : DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: _appBar(),
                    body: _body(),
                  ),
                ),
        ),
      ),
    );
  }
}
