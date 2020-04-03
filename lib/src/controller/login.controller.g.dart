// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  final _$pswdAtom = Atom(name: '_LoginControllerBase.pswd');

  @override
  String get pswd {
    _$pswdAtom.context.enforceReadPolicy(_$pswdAtom);
    _$pswdAtom.reportObserved();
    return super.pswd;
  }

  @override
  set pswd(String value) {
    _$pswdAtom.context.conditionallyRunInAction(() {
      super.pswd = value;
      _$pswdAtom.reportChanged();
    }, _$pswdAtom, name: '${_$pswdAtom.name}_set');
  }

  final _$showPswdAtom = Atom(name: '_LoginControllerBase.showPswd');

  @override
  bool get showPswd {
    _$showPswdAtom.context.enforceReadPolicy(_$showPswdAtom);
    _$showPswdAtom.reportObserved();
    return super.showPswd;
  }

  @override
  set showPswd(bool value) {
    _$showPswdAtom.context.conditionallyRunInAction(() {
      super.showPswd = value;
      _$showPswdAtom.reportChanged();
    }, _$showPswdAtom, name: '${_$showPswdAtom.name}_set');
  }

  final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase');

  @override
  dynamic changePswd(String pswdWrited) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction();
    try {
      return super.changePswd(pswdWrited);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeShowPswd() {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction();
    try {
      return super.changeShowPswd();
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'pswd: ${pswd.toString()},showPswd: ${showPswd.toString()}';
    return '{$string}';
  }
}
