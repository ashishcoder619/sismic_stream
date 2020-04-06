import 'dart:async';
import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
// BLUETOOTH
import 'package:flutter_blue/flutter_blue.dart';
import 'package:sismic_stream/src/controller/login.controller.dart';
// CONTROLLERS
import 'package:sismic_stream/src/controller/xy.controller.dart';
import 'package:sismic_stream/src/controller/xz.controller.dart';
import 'package:sismic_stream/src/controller/zy.controller.dart';
import 'package:sismic_stream/src/login.dart';
import 'package:sismic_stream/src/view/phone/planesPage/planesPageLayout.dart';

class PlanesPagePhone extends StatefulWidget {
  const PlanesPagePhone({Key key, this.device}) : super(key: key);
  final BluetoothDevice device;

  @override
  _PlanesPagePhoneState createState() => _PlanesPagePhoneState();
}

class _PlanesPagePhoneState extends State<PlanesPagePhone> {
  final String SERVICE_UUID = "4fafc201-1fb5-459e-8fcc-c5c9c331914b";
  final String CHARACTERISTIC_UUID = "beb5483e-36e1-4688-b7f5-ea07361b26a8";
  final _controllerXY = GetIt.I.get<XYController>();
  final _controllerXZ = GetIt.I.get<XZController>();
  final _controllerZY = GetIt.I.get<ZYController>();
  final _controllerLogin = GetIt.I.get<LoginController>();
  Stream<List<int>> stream;
  bool isReady;
  BluetoothCharacteristic targetCharacteristic;

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
                  _controllerLogin.changeWrongPswd(false);
                  _controllerLogin.resetContWrongPswd();
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

  Widget _stream({BuildContext context, Stream<List<int>> stream}) {
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
              // Size screen = MediaQuery.of(context).size;
              List arrData = _listParser(snapshot.data);
              if (arrData.length == 1) {
                if (_controllerLogin.contWrongPswd > 1)
                  _controllerLogin.changeWrongPswd(true);
                return UserLogin(writeData: writeData);
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
                return PlanesLayout();
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
              : _stream(
                  context: context,
                  stream: stream,
                ),
        ),
      ),
    );
  }
}
