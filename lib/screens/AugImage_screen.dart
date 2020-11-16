import 'dart:typed_data';

import 'package:ArApp/Maps/AugImageMap.dart';
import 'package:ArApp/screens/AddImage_screen.dart';
import 'package:ArApp/screens/print_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';

class AugImages extends StatefulWidget {
  static const routeName = '/homePage/AugImages';
  @override
  State<StatefulWidget> createState() {
    return _AugImagesState();
  }
}

class _AugImagesState extends State<AugImages> {
  ArCoreController arCoreController;
  Map<String, ArCoreAugmentedImage> augmentedImagesMap = Map();
  AugImageMap map;
  _Controller con;

  @override
  void initState() {
    super.initState();
    con = _Controller(this);
  }

  void render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    //get AugImageMap from homescreen, which contains the bytesMap
    map = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('AugmentedPage'),
        actions: <Widget>[
          FlatButton(
            child: Text("Add Image"),
            onPressed: con.loadAddImageScreen,
            color: Color.fromARGB(100, 100, 50, 50),
          ),
          FlatButton(
            child: Text("View Database"),
            onPressed: con.viewMap,
            color: Color.fromARGB(100, 100, 50, 50),
          ),
        ],
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        type: ArCoreViewType.AUGMENTEDIMAGES,
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) async {
    arCoreController = controller;
    arCoreController.onTrackingImage = _handleOnTrackingImage;
    loadImages();
    //OR
    //loadImagesDatabase();
  }

  loadImages() async {
    final ByteData bytes1 = await rootBundle.load('assets/images/earth.jpg');
    final ByteData bytes2 = await rootBundle.load('assets/images/flowers.jpg');

    //add into AugImageMap bytesMap the data for each bytes and
    //the corresponding string
    map.bytesMap['earth'] = bytes1.buffer.asUint8List();
    map.bytesMap['flowers'] = bytes2.buffer.asUint8List();

    arCoreController.loadMultipleAugmentedImage(bytesMap: map.bytesMap);
  }

  _handleOnTrackingImage(ArCoreAugmentedImage augmentedImage) {
    if (!augmentedImagesMap.containsKey(augmentedImage.name)) {
      augmentedImagesMap[augmentedImage.name] = augmentedImage;
      _addSphere(augmentedImage, augmentedImage.name);
    }
  }

  Future _addSphere(ArCoreAugmentedImage augmentedImage, String imgName) async {

    final material = ArCoreMaterial(
      color: Color.fromARGB(255, 66, 134, 244),
      textureBytes: map.bytesMap[imgName],
      metallic: 1.0,
    );

    final sphere = ArCoreSphere(
      materials: [material],
      radius: augmentedImage.extentX / 2,
    );
    final node = ArCoreNode(
      shape: sphere,
    );
    arCoreController.addArCoreNodeToAugmentedImage(node, augmentedImage.index);
  }


  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}

class _Controller {
  _AugImagesState _state;
  _Controller(this._state);

  void loadAddImageScreen() async {
    final value = await Navigator.pushNamed(_state.context, AddImageScreen.routeName,
        arguments: {
          "bytesMap": _state.map.bytesMap,
          "arCoreController": _state.arCoreController
        });
    _state.augmentedImagesMap = Map();
  }

  void viewMap() {
    Navigator.pushNamed(_state.context, PrintScreen.routeName,
        arguments: _state.map.bytesMap);
  }
}
