import 'package:flutter/material.dart';
import 'view/phone/blueAndLocationPage/blueAndLocation.dart';

class SismicHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double shortestSlide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSlide < 600;

    return useMobileLayout ? BluetoothAndLocationPagePhone() : Container();
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _showPassword = true;
  Widget textField({
    double width,
    double height,
    String label,
  }) =>
      Container(
        width: width,
        height: height,
        child: TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Insert username",
            labelStyle: TextStyle(color: Colors.black),
          ),
        ),
      );

  Widget pswdFormField({
    double width,
    double height,
  }) =>
      Container(
        width: width,
        height: height,
        child: TextFormField(
          autofocus: true,
          decoration: InputDecoration(
            hintText: "Insert passord",
            labelStyle: TextStyle(color: Colors.black),
            suffixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  _showPassword = !_showPassword;
                });
              },
              child: ButtonTheme(
                minWidth: 50,
                height: 50,
                child: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          obscureText: !_showPassword,
          validator: (String name) => "Insert password",
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
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SismicHome(),
            ),
          ),
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
            textField(
              width: screen.width / 1.5,
              height: screen.height / 8,
            ),
            pswdFormField(
              width: screen.width / 1.5,
              height: screen.height / 8,
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
