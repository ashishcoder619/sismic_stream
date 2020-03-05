import 'package:mobx/mobx.dart';
part 'xy.controller.g.dart';

class XYController = _XYControllerBase with _$XYController;

abstract class _XYControllerBase with Store {
  @observable
  int x;
  @observable
  int y;
  @observable
  double g;
  @observable
  int hzXY;
  @observable
  int hzMaxXY;
  @observable
  int hzMinXY;
  int _contHz = 0;

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
      if (newHz > hzMaxXY)
        hzMaxXY = newHz;
      if (newHz < hzMinXY)
        hzMinXY = newHz;
    }
  }
}