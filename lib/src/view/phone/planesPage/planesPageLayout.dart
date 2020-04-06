import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:sismic_stream/src/controller/xy.controller.dart';
import 'package:sismic_stream/src/view/shared/viewXY.dart';
import 'package:sismic_stream/src/view/shared/viewXZ.dart';
import 'package:sismic_stream/src/view/shared/viewZY.dart';

class PlanesLayout extends StatelessWidget {
  final _controllerXY = GetIt.I.get<XYController>();
  Widget _appBar({BuildContext context}) {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(
        'SISMIC',
        style: TextStyle(
          color: Colors.black,
          fontSize: 26,
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.settings),
          onPressed: () => showDialog(
            context: context,
            builder: (context) =>
                AlertDialog(
                  title: Text(
                    'Select amplitude\n(mm)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  content: Observer(
                    builder: (_) {
                      return NumberPicker.integer(
                        initialValue: _controllerXY.fakeRange,
                        minValue: 1,
                        maxValue: 100,
                        onChanged: (newValue) {
                          _controllerXY.changeFakeRange(newValue);
                        },
                      );
                    },
                  ),
                  actions: <Widget>[
                    Row(
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            _controllerXY.changeRealRange();
                            _controllerXY
                                .addPointsWithRange(_controllerXY.points);
                            Navigator.pop(context);
                          },
                          child: Text('Save amplitude'),
                        ),
                      ],
                    ),
                  ],
                ) ??
                false,
          ),
        ),
      ],
      bottom: TabBar(
        unselectedLabelColor: Colors.black,
        indicator: BoxDecoration(color: Colors.grey),
        tabs: <Widget>[
          Tab(
            text: "X : Y",
          ),
          Tab(
            text: "X : Z",
          ),
          Tab(
            text: "Z : Y",
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: _appBar(context: context),
          body: TabBarView(
            children: <Widget>[
              ViewXY(),
              ViewXZ(),
              ViewZY(),
            ],
          ),
        ),
      );
  }
}
