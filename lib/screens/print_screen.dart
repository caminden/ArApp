import 'dart:typed_data';
import 'package:flutter/material.dart';

class PrintScreen extends StatelessWidget {
  static const routeName = '/AugImages/printScreen';
  Map<String, Uint8List> bytesMap;

  @override
  Widget build(BuildContext context) {
    bytesMap = ModalRoute.of(context).settings.arguments;

    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.memory(bytesMap['flowers']),
            Image.memory(bytesMap['earth']),
            bytesMap['car'] == null ? SizedBox() : Image.memory(bytesMap['car']),
          ],
        ),
      ),
    );
  }
}
