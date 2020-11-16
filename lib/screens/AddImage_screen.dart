import 'dart:io';
import 'dart:typed_data';
import 'package:ArApp/screens/AugImage_screen.dart';
import 'package:ArApp/screens/start_screen.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
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
  ArCoreController arCoreController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    con = _Controller(this);
  }

  render(fn) => setState(fn);

  @override
  Widget build(BuildContext context) {
    Map args = ModalRoute.of(context).settings.arguments;
    bytesMap ??= args['bytesMap'];
    arCoreController ??= args['arCoreController'];

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
                            value: 'Gallery',
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.photo_album),
                                Text("Gallery"),
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
              //Text('$bytesMap'),
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

  String validate(String s) {
    if(s == null){
      return "Name must not be empty";
    }
    return null;
  }

  void save(Map<String, Uint8List> map) async {
    if(_state.formKey.currentState.validate()){
        _state.formKey.currentState.save();
    }
    
    if (_state.image != null) {
      try {
        map[name] = _state.image.readAsBytesSync();
        //Uint8List data = _state.image.readAsBytesSync(); debug statements
        //print("Name: $name, Dat: $data");
        //print(map['earth']);
        _state.arCoreController.loadMultipleAugmentedImage(bytesMap: map);
      } catch (e) {
        print("****************************************");
        print("$e");
      }
      Navigator.pop(_state.context);
    }
    else if(_state.image == null){
      print("*******************");
      print("image is null");
    }
    else{
      print("*******************");
      print("name is null");
    }
  }

  void getPicture(String cam) async {
    PickedFile _image;
    ImagePicker picker = ImagePicker();
    try {
      _image = await picker.getImage(source: ImageSource.gallery);
      _state.render(() {
        _state.image = File(_image.path);
      });
    } catch (e) {}
  }
}
