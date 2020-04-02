// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xz.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$XZController on _XZControllerBase, Store {
  final _$pointsAtom = Atom(name: '_XZControllerBase.points');

  @override
  List<List<int>> get points {
    _$pointsAtom.context.enforceReadPolicy(_$pointsAtom);
    _$pointsAtom.reportObserved();
    return super.points;
  }

  @override
  set points(List<List<int>> value) {
    _$pointsAtom.context.conditionallyRunInAction(() {
      super.points = value;
      _$pointsAtom.reportChanged();
    }, _$pointsAtom, name: '${_$pointsAtom.name}_set');
  }

  final _$gAtom = Atom(name: '_XZControllerBase.g');

  @override
  double get g {
    _$gAtom.context.enforceReadPolicy(_$gAtom);
    _$gAtom.reportObserved();
    return super.g;
  }

  @override
  set g(double value) {
    _$gAtom.context.conditionallyRunInAction(() {
      super.g = value;
      _$gAtom.reportChanged();
    }, _$gAtom, name: '${_$gAtom.name}_set');
  }

  final _$hzXZAtom = Atom(name: '_XZControllerBase.hzXZ');

  @override
  int get hzXZ {
    _$hzXZAtom.context.enforceReadPolicy(_$hzXZAtom);
    _$hzXZAtom.reportObserved();
    return super.hzXZ;
  }

  @override
  set hzXZ(int value) {
    _$hzXZAtom.context.conditionallyRunInAction(() {
      super.hzXZ = value;
      _$hzXZAtom.reportChanged();
    }, _$hzXZAtom, name: '${_$hzXZAtom.name}_set');
  }

  final _$hzMaxXZAtom = Atom(name: '_XZControllerBase.hzMaxXZ');

  @override
  int get hzMaxXZ {
    _$hzMaxXZAtom.context.enforceReadPolicy(_$hzMaxXZAtom);
    _$hzMaxXZAtom.reportObserved();
    return super.hzMaxXZ;
  }

  @override
  set hzMaxXZ(int value) {
    _$hzMaxXZAtom.context.conditionallyRunInAction(() {
      super.hzMaxXZ = value;
      _$hzMaxXZAtom.reportChanged();
    }, _$hzMaxXZAtom, name: '${_$hzMaxXZAtom.name}_set');
  }

  final _$hzMinXZAtom = Atom(name: '_XZControllerBase.hzMinXZ');

  @override
  int get hzMinXZ {
    _$hzMinXZAtom.context.enforceReadPolicy(_$hzMinXZAtom);
    _$hzMinXZAtom.reportObserved();
    return super.hzMinXZ;
  }

  @override
  set hzMinXZ(int value) {
    _$hzMinXZAtom.context.conditionallyRunInAction(() {
      super.hzMinXZ = value;
      _$hzMinXZAtom.reportChanged();
    }, _$hzMinXZAtom, name: '${_$hzMinXZAtom.name}_set');
  }

  final _$angleXZAtom = Atom(name: '_XZControllerBase.angleXZ');

  @override
  int get angleXZ {
    _$angleXZAtom.context.enforceReadPolicy(_$angleXZAtom);
    _$angleXZAtom.reportObserved();
    return super.angleXZ;
  }

  @override
  set angleXZ(int value) {
    _$angleXZAtom.context.conditionallyRunInAction(() {
      super.angleXZ = value;
      _$angleXZAtom.reportChanged();
    }, _$angleXZAtom, name: '${_$angleXZAtom.name}_set');
  }

  final _$fakeRangeAtom = Atom(name: '_XZControllerBase.fakeRange');

  @override
  int get fakeRange {
    _$fakeRangeAtom.context.enforceReadPolicy(_$fakeRangeAtom);
    _$fakeRangeAtom.reportObserved();
    return super.fakeRange;
  }

  @override
  set fakeRange(int value) {
    _$fakeRangeAtom.context.conditionallyRunInAction(() {
      super.fakeRange = value;
      _$fakeRangeAtom.reportChanged();
    }, _$fakeRangeAtom, name: '${_$fakeRangeAtom.name}_set');
  }

  final _$realRangeAtom = Atom(name: '_XZControllerBase.realRange');

  @override
  int get realRange {
    _$realRangeAtom.context.enforceReadPolicy(_$realRangeAtom);
    _$realRangeAtom.reportObserved();
    return super.realRange;
  }

  @override
  set realRange(int value) {
    _$realRangeAtom.context.conditionallyRunInAction(() {
      super.realRange = value;
      _$realRangeAtom.reportChanged();
    }, _$realRangeAtom, name: '${_$realRangeAtom.name}_set');
  }

  final _$_XZControllerBaseActionController =
      ActionController(name: '_XZControllerBase');

  @override
  dynamic changePoints(int newX, int newZ) {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.changePoints(newX, newZ);
    } finally {
      _$_XZControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeG(double newG) {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.changeG(newG);
    } finally {
      _$_XZControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHzXZ(int newHzXZ) {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.changeHzXZ(newHzXZ);
    } finally {
      _$_XZControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHzMaxXZ(int newHzMaxXZ) {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.changeHzMaxXZ(newHzMaxXZ);
    } finally {
      _$_XZControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHzMinXZ(int newHzMinXZ) {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.changeHzMinXZ(newHzMinXZ);
    } finally {
      _$_XZControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeAngleXZ(int newAngleXZ) {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.changeAngleXZ(newAngleXZ);
    } finally {
      _$_XZControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic verifyHzXZ(int newHz) {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.verifyHzXZ(newHz);
    } finally {
      _$_XZControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeFakeRange(int newRange) {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.changeFakeRange(newRange);
    } finally {
      _$_XZControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeRealRange() {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.changeRealRange();
    } finally {
      _$_XZControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'points: ${points.toString()},g: ${g.toString()},hzXZ: ${hzXZ.toString()},hzMaxXZ: ${hzMaxXZ.toString()},hzMinXZ: ${hzMinXZ.toString()},angleXZ: ${angleXZ.toString()},fakeRange: ${fakeRange.toString()},realRange: ${realRange.toString()}';
    return '{$string}';
  }
}
