import 'dart:typed_data';

import 'package:ArApp/screens/HelloWorld_screen.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:vector_math/vector_math_64.dart" as vector;

class HomePage extends StatefulWidget {
  static const routeName = '/homePage';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> {
  _Controller con;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AR App"),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Text("Buttons for different screens"),
              FlatButton(
                child: Text("3D objects"),
                onPressed: con.loadScreen,
                color: Color.fromARGB(100, 100, 50, 50),
              ),
            ],
          ),
        ),
      );
  }
}

class _Controller{
  _HomePage _state;
_Controller(this._state);

void loadScreen(){
  Navigator.pushNamed(_state.context, HelloWorld.routeName);
}
}