// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zy.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ZYController on _ZYControllerBase, Store {
  final _$zAtom = Atom(name: '_ZYControllerBase.z');

  @override
  int get z {
    _$zAtom.context.enforceReadPolicy(_$zAtom);
    _$zAtom.reportObserved();
    return super.z;
  }

  @override
  set z(int value) {
    _$zAtom.context.conditionallyRunInAction(() {
      super.z = value;
      _$zAtom.reportChanged();
    }, _$zAtom, name: '${_$zAtom.name}_set');
  }

  final _$yAtom = Atom(name: '_ZYControllerBase.y');

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

  final _$gAtom = Atom(name: '_ZYControllerBase.g');

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

  final _$hzZYAtom = Atom(name: '_ZYControllerBase.hzZY');

  @override
  int get hzZY {
    _$hzZYAtom.context.enforceReadPolicy(_$hzZYAtom);
    _$hzZYAtom.reportObserved();
    return super.hzZY;
  }

  @override
  set hzZY(int value) {
    _$hzZYAtom.context.conditionallyRunInAction(() {
      super.hzZY = value;
      _$hzZYAtom.reportChanged();
    }, _$hzZYAtom, name: '${_$hzZYAtom.name}_set');
  }

  final _$hzMaxZYAtom = Atom(name: '_ZYControllerBase.hzMaxZY');

  @override
  int get hzMaxZY {
    _$hzMaxZYAtom.context.enforceReadPolicy(_$hzMaxZYAtom);
    _$hzMaxZYAtom.reportObserved();
    return super.hzMaxZY;
  }

  @override
  set hzMaxZY(int value) {
    _$hzMaxZYAtom.context.conditionallyRunInAction(() {
      super.hzMaxZY = value;
      _$hzMaxZYAtom.reportChanged();
    }, _$hzMaxZYAtom, name: '${_$hzMaxZYAtom.name}_set');
  }

  final _$hzMinZYAtom = Atom(name: '_ZYControllerBase.hzMinZY');

  @override
  int get hzMinZY {
    _$hzMinZYAtom.context.enforceReadPolicy(_$hzMinZYAtom);
    _$hzMinZYAtom.reportObserved();
    return super.hzMinZY;
  }

  @override
  set hzMinZY(int value) {
    _$hzMinZYAtom.context.conditionallyRunInAction(() {
      super.hzMinZY = value;
      _$hzMinZYAtom.reportChanged();
    }, _$hzMinZYAtom, name: '${_$hzMinZYAtom.name}_set');
  }

  final _$_ZYControllerBaseActionController =
      ActionController(name: '_ZYControllerBase');

  @override
  dynamic changeZ(int newZ) {
    final _$actionInfo = _$_ZYControllerBaseActionController.startAction();
    try {
      return super.changeZ(newZ);
    } finally {
      _$_ZYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeY(int newY) {
    final _$actionInfo = _$_ZYControllerBaseActionController.startAction();
    try {
      return super.changeY(newY);
    } finally {
      _$_ZYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeG(double newG) {
    final _$actionInfo = _$_ZYControllerBaseActionController.startAction();
    try {
      return super.changeG(newG);
    } finally {
      _$_ZYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHzZY(int newHzZY) {
    final _$actionInfo = _$_ZYControllerBaseActionController.startAction();
    try {
      return super.changeHzZY(newHzZY);
    } finally {
      _$_ZYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHzMaxZY(int newHzMaxZY) {
    final _$actionInfo = _$_ZYControllerBaseActionController.startAction();
    try {
      return super.changeHzMaxZY(newHzMaxZY);
    } finally {
      _$_ZYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeHzMinZY(int newHzMinZY) {
    final _$actionInfo = _$_ZYControllerBaseActionController.startAction();
    try {
      return super.changeHzMinZY(newHzMinZY);
    } finally {
      _$_ZYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic verifyHzZY(int newHz) {
    final _$actionInfo = _$_ZYControllerBaseActionController.startAction();
    try {
      return super.verifyHzZY(newHz);
    } finally {
      _$_ZYControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'z: ${z.toString()},y: ${y.toString()},g: ${g.toString()},hzZY: ${hzZY.toString()},hzMaxZY: ${hzMaxZY.toString()},hzMinZY: ${hzMinZY.toString()}';
    return '{$string}';
  }
}
