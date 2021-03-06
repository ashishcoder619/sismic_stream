// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xy.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$XYController on _XYControllerBase, Store {
  final _$xAtom = Atom(name: '_XYControllerBase.x');

  @override
  int get x {
    _$xAtom.context.enforceReadPolicy(_$xAtom);
    _$xAtom.reportObserved();
    return super.x;
  }

  @override
  set x(int value) {
    _$xAtom.context.conditionallyRunInAction(() {
      super.x = value;
      _$xAtom.reportChanged();
    }, _$xAtom, name: '${_$xAtom.name}_set');
  }

  final _$yAtom = Atom(name: '_XYControllerBase.y');

  @override
  int get y {
    _$yAtom.context.enforceReadPolicy(_$yAtom);
    _$yAtom.reportObserved();
    return super.y;
  }

  @override
  set y(int value) {
    _$yAtom.context.conditionallyRunInAction(() {
      super.y = value;
      _$yAtom.reportChanged();
    }, _$yAtom, name: '${_$yAtom.name}_set');
  }

  final _$gAtom = Atom(name: '_XYControllerBase.g');

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

  final _$hzXYAtom = Atom(name: '_XYControllerBase.hzXY');

  @override
  int get hzXY {
    _$hzXYAtom.context.enforceReadPolicy(_$hzXYAtom);
    _$hzXYAtom.reportObserved();
    return super.hzXY;
  }

  @override
  set hzXY(int value) {
    _$hzXYAtom.context.conditionallyRunInAction(() {
      super.hzXY = value;
      _$hzXYAtom.reportChanged();
    }, _$hzXYAtom, name: '${_$hzXYAtom.name}_set');
  }

  final _$hzMaxXYAtom = Atom(name: '_XYControllerBase.hzMaxXY');

  @override
  int get hzMaxXY {
    _$hzMaxXYAtom.context.enforceReadPolicy(_$hzMaxXYAtom);
    _$hzMaxXYAtom.reportObserved();
    return super.hzMaxXY;
  }

  @override
  set hzMaxXY(int value) {
    _$hzMaxXYAtom.context.conditionallyRunInAction(() {
      super.hzMaxXY = value;
      _$hzMaxXYAtom.reportChanged();
    }, _$hzMaxXYAtom, name: '${_$hzMaxXYAtom.name}_set');
  }

  final _$hzMinXYAtom = Atom(name: '_XYControllerBase.hzMinXY');

  @override
  int get hzMinXY {
    _$hzMinXYAtom.context.enforceReadPolicy(_$hzMinXYAtom);
    _$hzMinXYAtom.reportObserved();
    return super.hzMinXY;
  }

  @override
  set hzMinXY(int value) {
    _$hzMinXYAtom.context.conditionallyRunInAction(() {
      super.hzMinXY = value;
      _$hzMinXYAtom.reportChanged();
    }, _$hzMinXYAtom, name: '${_$hzMinXYAtom.name}_set');
  }

  final _$_XYControllerBaseActionController =
      ActionController(name: '_XYControllerBase');

  @override
  dynamic changeX(int newX) {
    final _$actionInfo = _$_XYControllerBaseActionController.startAction();
    try {
      return super.changeX(newX);
    } finally {
      _$_XYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeY(int newY) {
    final _$actionInfo = _$_XYControllerBaseActionController.startAction();
    try {
      return super.changeY(newY);
    } finally {
      _$_XYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeG(double newG) {
    final _$actionInfo = _$_XYControllerBaseActionController.startAction();
    try {
      return super.changeG(newG);
    } finally {
      _$_XYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHzXY(int newHzXY) {
    final _$actionInfo = _$_XYControllerBaseActionController.startAction();
    try {
      return super.changeHzXY(newHzXY);
    } finally {
      _$_XYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHzMaxXY(int newHzMaxXY) {
    final _$actionInfo = _$_XYControllerBaseActionController.startAction();
    try {
      return super.changeHzMaxXY(newHzMaxXY);
    } finally {
      _$_XYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHzMinXY(int newHzMinXY) {
    final _$actionInfo = _$_XYControllerBaseActionController.startAction();
    try {
      return super.changeHzMinXY(newHzMinXY);
    } finally {
      _$_XYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic verifyHzXY(int newHz) {
    final _$actionInfo = _$_XYControllerBaseActionController.startAction();
    try {
      return super.verifyHzXY(newHz);
    } finally {
      _$_XYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'x: ${x.toString()},y: ${y.toString()},g: ${g.toString()},hzXY: ${hzXY.toString()},hzMaxXY: ${hzMaxXY.toString()},hzMinXY: ${hzMinXY.toString()}';
    return '{$string}';
  }
}
