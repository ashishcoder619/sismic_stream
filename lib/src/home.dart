import 'package:flutter/material.dart';

import 'view/phone/blueAndLocationPage/blueAndLocation.dart';

class SismicHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double shortestSlide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSlide < 600;

    return useMobileLayout ?  BluetoothAndLocationPagePhone() : Container();
  }
}