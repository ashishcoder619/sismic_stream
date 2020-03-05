// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'xz.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$XZController on _XZControllerBase, Store {
  final _$xAtom = Atom(name: '_XZControllerBase.x');

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

  final _$zAtom = Atom(name: '_XZControllerBase.z');

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

  final _$_XZControllerBaseActionController =
      ActionController(name: '_XZControllerBase');

  @override
  dynamic changeX(int newX) {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.changeX(newX);
    } finally {
      _$_XZControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeZ(int newZ) {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.changeZ(newZ);
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
  dynamic verifyHzXZ(int newHz) {
    final _$actionInfo = _$_XZControllerBaseActionController.startAction();
    try {
      return super.verifyHzXZ(newHz);
    } finally {
      _$_XZControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'x: ${x.toString()},z: ${z.toString()},g: ${g.toString()},hzXZ: ${hzXZ.toString()},hzMaxXZ: ${hzMaxXZ.toString()},hzMinXZ: ${hzMinXZ.toString()}';
    return '{$string}';
  }
}
