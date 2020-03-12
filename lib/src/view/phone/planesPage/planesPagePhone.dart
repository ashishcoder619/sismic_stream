import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
// BLUETOOTH
import 'package:flutter_blue/flutter_blue.dart';
// CONTROLLERS
import 'package:sismic_stream/src/controller/xy.controller.dart';
import 'package:sismic_stream/src/controller/xz.controller.dart';
import 'package:sismic_stream/src/controller/zy.controller.dart';

// POSITIONS
import 'package:sismic_stream/src/view/shared/frequency/XYFrequency.dart';
import 'package:sismic_stream/src/view/shared/frequency/XZFrequency.dart';
import 'package:sismic_stream/src/view/shared/frequency/ZYFrequency.dart';

// FREQUENCY
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
  final XYController _controllerXY = XYController();
  final XZController _controllerXZ = XZController();
  final ZYController _controllerZY = ZYController();
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
                // stream = characteristic.value.asBroadcastStream();
                stream = characteristic.value;
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

  // View Functions //
  Widget _viewXY() {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 7,
          child: Center(
            child: XYPosition(
              xValue: _controllerXY.x,
              yValue: _controllerXY.y,
              gValue: _controllerXY.g,
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

  Widget _viewXZ() {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 7,
          child: Center(
            child: XZPosition(
              xValue: _controllerXZ.x,
              zValue: _controllerXZ.z,
              gValue: _controllerXZ.g,
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

  Widget _viewZY() {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 7,
          child: Center(
            child: ZYPosition(
              zValue: _controllerZY.z,
              yValue: _controllerZY.y,
              gValue: _controllerZY.g,
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

  Widget _appBar() {
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

  Widget _body(c) {
    return StreamBuilder<List<int>>(
      stream: stream,
      initialData: [],
      builder: (c, AsyncSnapshot<List<int>> snapshot) {
        print("CONNECTION STATE: ${snapshot.connectionState}");
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.data.isEmpty == false) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              // XY PLANE
              List<num> arrData = _listParser(snapshot.data);
              _controllerXY.changeX(arrData[0]);
              _controllerXY.changeY(arrData[1]);
              _controllerXY.changeG(arrData[3]);
              _controllerXY.changeHzXY(arrData[4]);
              _controllerXY.verifyHzXY(arrData[4]);
              // XZ PLANE
              _controllerXZ.changeX(arrData[0]);
              _controllerXZ.changeZ(arrData[1]);
              _controllerXZ.changeG(arrData[3]);
              _controllerXZ.changeHzXZ(arrData[4]);
              _controllerXZ.verifyHzXZ(arrData[4]);
              // ZYPLANE
              _controllerZY.changeZ(arrData[0]);
              _controllerZY.changeY(arrData[1]);
              _controllerZY.changeG(arrData[3]);
              _controllerZY.changeHzZY(arrData[4]);
              _controllerZY.verifyHzZY(arrData[4]);
              return TabBarView(
                children: <Widget>[
                  _viewXY(),
                  _viewXZ(),
                  _viewZY(),
                ],
              );
              break;
            case ConnectionState.none:
              return Container(
                child: Center(
                  child: Text("bluetooth disconected"),
                ),
              );
              break;
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        }else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // print(
        //     "*******************************this is the data: ${snapshot.data}************************");
        // if (snapshot.hasError) {
        //   return Text('Error: ${snapshot.error}');
        // } else if (snapshot.connectionState == ConnectionState.active &&
        //     snapshot.data.isEmpty == false) {
        //   // XY PLANE
        //   List<num> arrData = _listParser(snapshot.data);
        //   _controllerXY.changeX(arrData[0]);
        //   _controllerXY.changeY(arrData[1]);
        //   _controllerXY.changeG(arrData[3]);
        //   _controllerXY.changeHzXY(arrData[4]);
        //   _controllerXY.verifyHzXY(arrData[4]);
        //   // XZ PLANE
        //   _controllerXZ.changeX(arrData[0]);
        //   _controllerXZ.changeZ(arrData[1]);
        //   _controllerXZ.changeG(arrData[3]);
        //   _controllerXZ.changeHzXZ(arrData[4]);
        //   _controllerXZ.verifyHzXZ(arrData[4]);
        //   // ZYPLANE
        //   _controllerZY.changeZ(arrData[0]);
        //   _controllerZY.changeY(arrData[1]);
        //   _controllerZY.changeG(arrData[3]);
        //   _controllerZY.changeHzZY(arrData[4]);
        //   _controllerZY.verifyHzZY(arrData[4]);
        //   return TabBarView(
        //     children: <Widget>[
        //       _viewXY(),
        //       _viewXZ(),
        //       _viewZY(),
        //     ],
        //   );
        // } else {
        //   return Center(
        //     child: CircularProgressIndicator(),
        //   );
        // }
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
                  child: Image(
                    height: 150,
                    width: 150,
                    image: AssetImage('assets/images/SBAGUIA.png'),
                  ),

                  // child: Text(
                  //   'SISMIC',
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontFamily: 'Quebec Black',
                  //     fontSize: 26,
                  //   ),
                  // ),
                )
              : DefaultTabController(
                  length: 3,
                  child: Scaffold(
                    appBar: _appBar(),
                    body: _body(context),
                  ),
                ),
        ),
      ),
    );
  }
}
