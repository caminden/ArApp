import 'dart:io';
import 'dart:typed_data';

import 'package:ArApp/Maps/AugImageMap.dart';
import 'package:ArApp/screens/AugImage_screen.dart';
import 'package:ArApp/screens/HelloWorld_screen.dart';
import 'package:ArApp/screens/addimage_screen.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
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
  AugImageMap map = AugImageMap();

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
              onPressed: con.loadHelloWorldScreen,
              color: Color.fromARGB(100, 100, 50, 50),
            ),
            SizedBox(
              height: 10.0,
            ),
            FlatButton(
              child: Text("Augmented Image"),
              onPressed: con.loadAugImagesScreen,
              color: Color.fromARGB(100, 100, 50, 50),
            ),
            //Container(child: Image.asset('assets/images/earth.jpg')),      
          ],
        ),
      ),
    );
  }
}

class _Controller {
  _HomePage _state;
  _Controller(this._state);

  void loadHelloWorldScreen() {
    Navigator.pushNamed(_state.context, HelloWorld.routeName);
  }

  void loadAugImagesScreen() {
    Navigator.pushNamed(_state.context, AugImages.routeName);
  }

  void loadAddImageScreen() {
    Navigator.pushNamed(_state.context, AddImageScreen.routeName);
  }
}
