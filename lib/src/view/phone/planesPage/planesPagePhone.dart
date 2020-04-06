import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/material.dart';
// BLUETOOTH
import 'package:flutter_blue/flutter_blue.dart';
import 'package:sismic_stream/src/controller/login.controller.dart';
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
  final _controllerXY = XYController();
  final _controllerXZ = XZController();
  final _controllerZY = ZYController();
  final _controllerLogin = LoginController();
  Stream<List<int>> stream;
  bool isReady;
  BluetoothCharacteristic targetCharacteristic;
  AnimationController animationController;

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

    List<BluetoothService> servicesSending =
        await widget.device.discoverServices();
    servicesSending.forEach(
      (service) {
        if (service.uuid.toString() == SERVICE_UUID) {
          service.characteristics.forEach(
            (characteristic) {
              if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
                targetCharacteristic = characteristic;
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
    List<BluetoothService> servicesReceiving =
        await widget.device.discoverServices();
    servicesReceiving.forEach(
      (service) {
        if (service.uuid.toString() == SERVICE_UUID) {
          service.characteristics.forEach(
            (characteristic) {
              if (characteristic.uuid.toString() == CHARACTERISTIC_UUID) {
                characteristic.setNotifyValue(!characteristic.isNotifying);
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
      setState(() {
        isReady = false;
      });
      print("disconnected");
      _Pop();
    }
  }

  Future<bool> _onWillPop() {
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Are you sure?'),
            content: Container(
              child: Text('Do you want to disconnect device and go back?'),
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  !_controllerLogin.rememberPswd ? writeData("Wrong") : false;
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

  writeData(String data) {
    if (targetCharacteristic == null) return;

    List<int> bytes = utf8.encode(data);
    targetCharacteristic.write(bytes, withoutResponse: false);
  }

  // View Functions //
  Widget _viewXY() {
    return Column(
      children: <Widget>[
        Flexible(
          flex: 7,
          child: Center(
            child: XYPosition(
                gValue: _controllerXY.g,
                points: _controllerXY.points,
                pointsWithRange: _controllerXY.pointsWithRange,
                isInRange: _controllerXY.isInRange),
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

  Widget _viewZY() {
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

  Widget _appBar({BuildContext context}) {
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
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text(
                    'Select amplitude\n(mm)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  content: Observer(
                    builder: (_) {
                      return NumberPicker.integer(
                        initialValue: _controllerXY.fakeRange,
                        minValue: 1,
                        maxValue: 100,
                        onChanged: (newValue) {
                          _controllerXY.changeFakeRange(newValue);
                        },
                      );
                    },
                  ),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _controllerXY.changeRealRange();
                            _controllerXY
                                .addPointsWithRange(_controllerXY.points);
                            Navigator.pop(context);
                          },
                          child: Text('Save amplitude'),
                        ),
                      ],
                    ),
                  ],
                ) ??
                false,
          ),
        ),
      ],
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
  // final animation = Tween(begin: 0, end: 2 * pi).animate(animationController);

  Widget _stream({BuildContext context}) {
    return StreamBuilder<List<int>>(
      stream: stream,
      initialData: [],
      builder: (context, AsyncSnapshot<List> snapshot) {
        print("snapshot.data: ${snapshot.data}");
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.data.isEmpty == false) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
              Size screen = MediaQuery.of(context).size;
              List arrData = _listParser(snapshot.data);
              if (arrData.length == 1) {
                if (_controllerLogin.contWrongPswd > 1)
                  _controllerLogin.changeWrongPswd(true);
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Center(
                          child: Image.asset(
                            "assets/images/SBAGUIA.png",
                            width: screen.width / 2.5,
                            height: screen.width / 2.5,
                          ),
                        ),
                        pswdFormField(
                          width: screen.width / 2,
                          height: screen.height / 8,
                        ),
                        SizedBox(
                          height: screen.height / 50,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Remember password",
                              style: TextStyle(fontSize: 18),
                            ),
                            Checkbox(
                              value: _controllerLogin.rememberPswd,
                              activeColor: Colors.black,
                              onChanged: (value) {
                                _controllerLogin.changeRememberPswd();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: screen.width / 18,
                        ),
                        submitButton(
                          label: "Enter",
                          width: screen.width / 3,
                          height: screen.width / 9,
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                // XY PLANE
                _controllerXY.changeG(arrData[3]);
                _controllerXY.changeHzXY(arrData[4]);
                _controllerXY.verifyHzXY(arrData[4]);
                _controllerXY.changePoints(arrData[0], arrData[1]);
                // XZ PLANE
                _controllerXZ.changeG(arrData[3]);
                _controllerXZ.changeHzXZ(arrData[4]);
                _controllerXZ.verifyHzXZ(arrData[4]);
                _controllerXZ.changePoints(arrData[0], arrData[2]);
                // _controllerXZ.changeAngleXZ(arrData[5]);
                // ZYPLANE
                _controllerZY.changeG(arrData[3]);
                _controllerZY.changeHzZY(arrData[4]);
                _controllerZY.verifyHzZY(arrData[4]);
                _controllerZY.changePoints(arrData[1], arrData[2]);
                // _controllerZY.changeAngleZY(arrData[6]);
                return planes();
              }
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
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
  // =========================================================================

  Widget submitButton({
    String label,
    double width,
    double height,
  }) =>
      Container(
        width: width,
        height: height,
        child: FlatButton(
          onPressed: () {
            _controllerLogin.changeContWrongPswd();
            writeData(_controllerLogin.pswd);
          },
          color: Colors.black,
          child: Text(
            "$label",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      );

  Widget pswdFormField({
    double width,
    double height,
  }) =>
      Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: width,
            height: height,
            child: TextFormField(
              onChanged: (pswdWrited) =>
                  _controllerLogin.changePswd(pswdWrited),
              autofocus: true,
              decoration: InputDecoration(
                hintText: "Insert passord",
                labelText: "Password",
                labelStyle: TextStyle(
                  color: _controllerLogin.wrongPswd ? Colors.red : Colors.black,
                  fontSize: 20,
                ),
              ),
              obscureText: !_controllerLogin.showPswd,
              validator: (String name) => "Insert password",
            ),
          ),
          GestureDetector(
            onTap: () {
              _controllerLogin.changeShowPswd();
            },
            child: Container(
              child: Icon(
                _controllerLogin.showPswd
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: _controllerLogin.wrongPswd ? Colors.red : Colors.black,
              ),
            ),
          ),
        ],
      );

  // =========================================================================

  Widget planes() => DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: _appBar(context: context),
          body: TabBarView(
            children: <Widget>[
              _viewXY(),
              _viewXZ(),
              _viewZY(),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Container(
          child: !isReady
              ? Center(
                  child: Image(
                    height: screen.height / 5,
                    width: screen.height / 5,
                    image: AssetImage('assets/images/SBAGUIA.png'),
                  ),
                )
              : _stream(context: context),
        ),
      ),
    );
  }
}
