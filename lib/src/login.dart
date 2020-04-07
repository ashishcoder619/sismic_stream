import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'controller/login.controller.dart';

class UserLogin extends StatelessWidget {
  final _controllerLogin = GetIt.I.get<LoginController>();
  final Function writeData;
  final errorRed = Colors.red;
  UserLogin({this.writeData});

  OutlineInputBorder errorBorder() => OutlineInputBorder(
        borderSide: BorderSide(
          color: errorRed,
          width: 1.5,
        ),
      );

  OutlineInputBorder normalBorder() => OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      );

  Widget pswdFormField({
    double width,
    double height,
  }) =>
      Container(
        width: width,
        height: height,
        child: TextField(
          onChanged: (pswdWrited) => _controllerLogin.changePswd(pswdWrited),
          autofocus: true,
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () {
                _controllerLogin.changeShowPswd();
              },
              child: Container(
                child: Icon(
                  _controllerLogin.showPswd
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: _controllerLogin.wrongPswd ? errorRed : Colors.black,
                ),
              ),
            ),
            errorText: _controllerLogin.wrongPswd ? "wrong password" : null,
            errorStyle: TextStyle(
              color: errorRed,
            ),
            focusedErrorBorder: errorBorder(),
            focusedBorder: normalBorder(),
            enabledBorder: normalBorder(),
            labelText: "Password",
            labelStyle: TextStyle(
              fontSize: 20,
              color: _controllerLogin.wrongPswd ? errorRed : Colors.black,
            ),
          ),
          obscureText: !_controllerLogin.showPswd,
        ),
      );

  Widget submitButton({
    String label,
    double width,
    double height,
  }) =>
      Container(
        width: width,
        height: height,
        child: FlatButton(
          onPressed: () {
            _controllerLogin.changeContWrongPswd();
            writeData(_controllerLogin.pswd);
          },
          color: Colors.black,
          child: Text(
            "$label",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Image.asset(
                "assets/images/SBAGUIA.png",
                width: screen.width / 2.5,
                height: screen.width / 2.5,
              ),
            ),
            pswdFormField(
              width: screen.width / 1.5,
              height: screen.height / 10,
            ),
            SizedBox(
              height: screen.height / 50,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Remember password",
                  style: TextStyle(fontSize: 18),
                ),
                Checkbox(
                  value: _controllerLogin.rememberPswd,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    _controllerLogin.changeRememberPswd();
                  },
                ),
              ],
            ),
            SizedBox(
              height: screen.width / 18,
            ),
            submitButton(
              label: "Enter",
              width: screen.width / 3,
              height: screen.width / 9,
            ),
          ],
        ),
      ),
    );
  }
}
