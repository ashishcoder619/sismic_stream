import 'package:mobx/mobx.dart';
part 'login.controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  String pswd = '' ;
  @observable
  bool showPswd = false;
  @action
  changePswd(String pswdWrited) => pswd = pswdWrited;
  @action
  changeShowPswd() => showPswd = !showPswd;
}