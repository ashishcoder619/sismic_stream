import 'package:mobx/mobx.dart';
part 'login.controller.g.dart';

class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  @observable
  String pswd = '' ;
  @observable
  bool showPswd = false;
  @observable
  bool rememberPswd = false;
  @observable
  bool wrongPswd = false;
  @observable
  int contWrongPswd = 0;
  @action
  changePswd(String pswdWrited) => pswd = pswdWrited;
  @action
  changeShowPswd() => showPswd = !showPswd;
  @action
  changeRememberPswd() => rememberPswd = !rememberPswd;
  @action
  changeWrongPswd(bool state) => wrongPswd = state;
  @action
  changeContWrongPswd() => contWrongPswd++;
}