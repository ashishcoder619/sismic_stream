import 'dart:math';

import 'package:mobx/mobx.dart';
part 'xy.controller.g.dart';

class XYController = _XYControllerBase with _$XYController;

abstract class _XYControllerBase with Store {
  int cont = 0;
  bool firstPoints = true;
  @observable
  List<List<int>> points = [];
  @observable
  List<List<double>> pointsWithRange = [];
  @observable
  double g = 0;
  @observable
  int hzXY = 0;
  @observable
  int hzMaxXY = 0;
  @observable
  int hzMinXY;
  @observable
  int fakeRange = 10;
  @observable
  int realRange = 10;

  @observable
  bool isInRange = true;

  @observable
  int _contHz = 0;

  List<double> newPointWithRange(List<int> point, int range) => [
        // using pythagorean theorem
        point[0] *
            (sqrt(pow(point[0], 2) + pow(point[1], 2)) + range) /
            (sqrt(pow(point[0], 2) + pow(point[1], 2))),
        point[1] *
            (sqrt(pow(point[0], 2) + pow(point[1], 2)) + range) /
            (sqrt(pow(point[0], 2) + pow(point[1], 2))),
      ];
  @action
  addPointsWithRange(List<List<int>> points) {
    pointsWithRange =
        points.map((point) => newPointWithRange(point, realRange)).toList();
  }

  @action
  changePoints(int newX, int newY) {
    if (cont <= 20 && firstPoints) {
      points.add([newX, newY]);
      cont++;
      if (cont == 20) {
        cont = 0;
        firstPoints = false;
      }
    } else {
      points[cont] = [newX, newY];
      if (pointsWithRange.length > 0)
        sqrt(pow(newX, 2) + pow(newY, 2)) >
                sqrt(pow(pointsWithRange[cont][0], 2) +
                    pow(pointsWithRange[cont][1], 2))
            ? isInRange = false
            : isInRange = true;
      cont++;
      if (cont == 20) cont = 0;
    }
  }

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

  @action
  changeFakeRange(int newRange) => fakeRange = newRange;
  @action
  changeRealRange() => realRange = fakeRange;
}
