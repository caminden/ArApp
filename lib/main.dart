import 'package:ArApp/screens/AugImage_screen.dart';
import 'package:ArApp/screens/HelloWorld_screen.dart';
import 'package:ArApp/screens/start_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => HomePage(),
        HelloWorld.routeName: (context) => HelloWorld(),
        AugImages.routeName: (context) => AugImages(),
        
      },
    );
  }
}
