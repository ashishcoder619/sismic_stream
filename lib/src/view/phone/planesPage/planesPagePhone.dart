import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_blue/flutter_blue.dart';
import 'package:sismic_stream/src/view/shared/frequency/XYFrequency.dart';
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

  // View Functions
  _viewXY(Stream<List<int>> myStream) {
    return Column(
      children: <Widget>[
        // XYPosition(stream: myStream),
        XYFrequency(stream: myStream),
      ],
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      actions: <Widget>[],
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
    return TabBarView(
      children: <Widget>[
        // XYPosition(stream: stream,),
        _viewXY(stream),
        XZPosition(
          stream: stream,
        ),
        ZYPosition(
          stream: stream,
        ),
      ],
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
