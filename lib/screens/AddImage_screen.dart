import 'dart:io';
import 'dart:typed_data';
import 'package:ArApp/screens/AugImage_screen.dart';
import 'package:ArApp/screens/start_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImageScreen extends StatefulWidget {
  static const routeName = '/AugImage/AddImage';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddImage();
  }
}

class _AddImage extends State<AddImageScreen> {
  _Controller con;
  File image;
  var formKey = GlobalKey<FormState>();
  Map<String, Uint8List> bytesMap;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    bytesMap ??= ModalRoute.of(context).settings.arguments;
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Add"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.check),
            onPressed: () => con.save(bytesMap),
          ),
        ],
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: image == null
                        ? Icon(
                            Icons.photo_library,
                            size: 300.0,
                          )
                        : Image.file(image, fit: BoxFit.fill),
                  ),
                  Positioned(
                    right: 0.0,
                    bottom: 0.0,
                    child: Container(
                      color: Colors.blue[100],
                      child: PopupMenuButton<String>(
                        onSelected: con.getPicture,
                        itemBuilder: (context) => <PopupMenuEntry<String>>[
                          PopupMenuItem(
                            value: 'camera',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.photo_camera),
                                Text("Camera"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Name",
                ),
                autocorrect: true,
                onSaved: con.onSavedName,
                validator: con.validate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Controller {
  _AddImage _state;
  _Controller(this._state);
  String name;

  void onSavedName(String value) {
    this.name = value;
  }

  String validate(String s){
    return null;
  }

  void save(Map<String, Uint8List> map) async {
    _state.formKey.currentState.save();

    if (_state.image != null && name != null) {
      Uint8List data = _state.image.readAsBytesSync();
      map[name] = _state.image.readAsBytesSync();
      //print("Name: $name, Dat: $data");
      print(map['earth']);
      Navigator.pushReplacementNamed(_state.context, HomePage.routeName);
    }
  }

  void getPicture(String cam) async {
    PickedFile _image;
    ImagePicker picker = ImagePicker();
    try {
      _image = await picker.getImage(source: ImageSource.camera);
      _state.render(() {
        _state.image = File(_image.path);
      });
    } catch (e) {}
  }
}
