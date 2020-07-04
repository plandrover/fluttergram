import 'package:flutter/material.dart';
import 'pages/home.dart';
// import 'package:google_sign_in/google_sign_in.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluttergram',
      theme: ThemeData(
        //swatch sets some custome properties and uses custom shades for colour so do not have to do it manually
        primarySwatch: Colors.deepPurple,
        accentColor: Colors.teal
      ),
      home: Home(),
    );
  }
}
