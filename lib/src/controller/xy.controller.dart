import 'dart:async';
import 'dart:convert';

class XYController {
  int _x;
  int _y;
  double _g;
  int _hz;
  int _hzMax;
  int _hzMin;
  int _contHz = 0;
  
  // getters
  int get x => _x;
  int get y => _y;
  double get g => _g;
  int get hz => _hz;
  int get hzMax => _hzMax;
  int get hzMin => _hzMin;

  _verifyHz(int newHz) {
    if (_contHz == 0) {
      _hzMax = newHz;
      _hzMin = newHz;
      _contHz++;
    } else {
      if (newHz > _hzMax) _hzMax = newHz;
      if (newHz < _hzMin) _hzMin = newHz;
    }
  }
  
  Stream<List<int>> stream;
  List<num> _listParser(List<int> dataFromDevice) {
    String stringData = utf8.decode(dataFromDevice);
    return stringData.split('|').map((e) => num.parse(e)).toList();
  }
  
  XYController({this.stream}){
    stream.listen((value) { 
      _x = _listParser(value)[0];
      _y = _listParser(value)[1];
      _g = _listParser(value)[3];
      _hz = _listParser(value)[4];
      _verifyHz(_hz);
    });
  }
  
}

