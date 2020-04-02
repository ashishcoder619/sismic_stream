import 'package:mobx/mobx.dart';
part 'xz.controller.g.dart';

class XZController = _XZControllerBase with _$XZController;

abstract class _XZControllerBase with Store {
  int cont = 0;
  bool firstPoints = true;
  @observable
  List<List<int>> points = [];
  @observable
  double g;
  @observable
  int hzXZ;
  @observable
  int hzMaxXZ;
  @observable
  int hzMinXZ;
  @observable
  int angleXZ = 0;

  @observable
  int fakeRange = 0;
  @observable
  int realRange = 0;

  int _contHz = 0;

  @action
  changePoints(int newX, int newZ) {
    if (cont <= 20 && firstPoints) {
      points.add([newX, newZ]);
      cont++;
      if (cont == 20) {
        cont = 0;
        firstPoints = false;
      }
    } else {
      points[cont] = [newX, newZ];
      cont++;
      if (cont == 20) cont = 0;
    }
  }

  @action
  changeG(double newG) => g = newG;
  @action
  changeHzXZ(int newHzXZ) => hzXZ = newHzXZ;
  @action
  changeHzMaxXZ(int newHzMaxXZ) => hzMaxXZ = newHzMaxXZ;
  @action
  changeHzMinXZ(int newHzMinXZ) => hzMinXZ = newHzMinXZ;
  @action
  changeAngleXZ(int newAngleXZ) => angleXZ = newAngleXZ;
  @action
  verifyHzXZ(int newHz) {
    if (_contHz == 0) {
      hzMaxXZ = newHz;
      hzMinXZ = newHz;
      _contHz++;
    } else {
      if (newHz > hzMaxXZ)
        hzMaxXZ = newHz;
      if (newHz < hzMinXZ)
        hzMinXZ = newHz;
    }
  }
  @action
  changeFakeRange(int newRange) => fakeRange = newRange;
  @action
  changeRealRange() => realRange = fakeRange;

}