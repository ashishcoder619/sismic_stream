import 'package:mobx/mobx.dart';
part 'xy.controller.g.dart';

class XYController = _XYControllerBase with _$XYController;

abstract class _XYControllerBase with Store {
  int cont = 0;
  bool firstPoints = true;
  @observable
  int x = 0;
  @observable
  int y = 0;
  @observable
  List<List> points = [];

  @observable
  double g = 0;
  @observable
  int hzXY = 0;
  @observable
  int hzMaxXY = 0;
  @observable
  int hzMinXY;

  @observable
  int _contHz = 0;

  @action
  changePoints(int newX, int newY) {
    if (cont < 16 && firstPoints) {
      points.add([newX, newY]);
      if (cont == 15) {
        cont = 0;
        firstPoints = false;
      }else{
        cont++;
      }
    } else {
      points[cont] = [newX, newY];
      cont++;
      if (cont == 15) cont = 0;
    }
  }

  @action
  changeX(int newX) => x = newX;
  @action
  changeY(int newY) => y = newY;
  @action
  changeG(double newG) => g = newG;
  @action
  changeHzXY(int newHzXY) => hzXY = newHzXY;
  @action
  changeHzMaxXY(int newHzMaxXY) => hzMaxXY = newHzMaxXY;
  @action
  changeHzMinXY(int newHzMinXY) => hzMinXY = newHzMinXY;
  @action
  verifyHzXY(int newHz) {
    if (_contHz == 0) {
      hzMaxXY = newHz;
      hzMinXY = newHz;
      _contHz++;
    } else {
      if (newHz > hzMaxXY) hzMaxXY = newHz;
      if (newHz < hzMinXY) hzMinXY = newHz;
    }
  }
}
