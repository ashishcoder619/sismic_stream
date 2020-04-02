import 'package:mobx/mobx.dart';
part 'zy.controller.g.dart';

class ZYController = _ZYControllerBase with _$ZYController;

abstract class _ZYControllerBase with Store {
  int cont = 0;
  bool firstPoints = true;
  @observable
  List<List<int>> points = [];
  @observable
  double g;
  @observable
  int hzZY;
  @observable
  int hzMaxZY;
  @observable
  int hzMinZY;
  @observable
  int angleZY = 0;

  @observable 
  int fakeRange = 0;
  @observable
  int realRange = 0;

  int _contHz = 0;

  @action
  changePoints(int newZ, int newY) {
    if (cont <= 20 && firstPoints) {
      points.add([newZ, newY]);
      cont++;
      if (cont == 20) {
        cont = 0;
        firstPoints = false;
      }
    } else {
      points[cont] = [newZ, newY];
      cont++;
      if (cont == 20) cont = 0;
    }
  }

  @action
  changeG(double newG) => g = newG;
  @action
  changeHzZY(int newHzZY) => hzZY = newHzZY;
  @action
  changeHzMaxZY(int newHzMaxZY) => hzMaxZY = newHzMaxZY;
  @action
  changeHzMinZY(int newHzMinZY) => hzMinZY = newHzMinZY;
  @action
  changeAngleZY(int newAngleZY) => angleZY = newAngleZY;
  @action
  verifyHzZY(int newHz) {
    if (_contHz == 0) {
      hzMaxZY = newHz;
      hzMinZY = newHz;
      _contHz++;
    } else {
      if (newHz > hzMaxZY)
        hzMaxZY = newHz;
      if (newHz < hzMinZY)
        hzMinZY = newHz;
    }
  }
  @action
  changeFakeRange(int newRange) => fakeRange = newRange;
  @action
  changeRealRange() => realRange = fakeRange;
}