import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
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
  ArCoreController con;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("AR App"),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ));
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    con = controller;

    _addSphere(con);
  }

  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.lime,
      reflectance: 10.0,
    );

    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.2,
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    con.dispose();
    super.dispose();
  }
}