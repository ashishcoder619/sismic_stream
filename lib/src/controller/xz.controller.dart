import 'package:mobx/mobx.dart';
part 'xz.controller.g.dart';

class XZController = _XZControllerBase with _$XZController;

abstract class _XZControllerBase with Store {
  @observable
  int x;
  @observable
  int z;
  @observable
  double g;
  @observable
  int hzXZ;
  @observable
  int hzMaxXZ;
  @observable
  int hzMinXZ;
  int _contHz = 0;

  @action
  changeX(int newX) => x = newX;
  @action
  changeZ(int newZ) => z = newZ;
  @action
  changeG(double newG) => g = newG;
  @action
  changeHzXZ(int newHzXZ) => hzXZ = newHzXZ;
  @action
  changeHzMaxXZ(int newHzMaxXZ) => hzMaxXZ = newHzMaxXZ;
  @action
  changeHzMinXZ(int newHzMinXZ) => hzMinXZ = newHzMinXZ;
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
}