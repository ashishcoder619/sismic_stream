import 'package:mobx/mobx.dart';
part 'zy.controller.g.dart';

class ZYController = _ZYControllerBase with _$ZYController;

abstract class _ZYControllerBase with Store {
  @observable
  int z;
  @observable
  int y;
  @observable
  double g;
  @observable
  int hzZY;
  @observable
  int hzMaxZY;
  @observable
  int hzMinZY;
  int _contHz = 0;

  @action
  changeZ(int newZ) => z = newZ;
  @action
  changeY(int newY) => y = newY;
  @action
  changeG(double newG) => g = newG;
  @action
  changeHzZY(int newHzZY) => hzZY = newHzZY;
  @action
  changeHzMaxZY(int newHzMaxZY) => hzMaxZY = newHzMaxZY;
  @action
  changeHzMinZY(int newHzMinZY) => hzMinZY = newHzMinZY;
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
}