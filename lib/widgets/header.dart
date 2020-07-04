import 'package:flutter/material.dart';

header(context, {bool isAppTitle = false, titleText, removeBackButton = false}) { 
  return AppBar(
    automaticallyImplyLeading: removeBackButton ? false : true,
    title: Text(
      isAppTitle ? 'Fluttergram' : titleText,
      style: TextStyle(
        color: Colors.white,
        fontFamily: isAppTitle ? "Signatra" :"",//"" is default font.
        fontSize: isAppTitle ? 50.0 :22.0
      ),
    ),
    centerTitle: true,
    //need to pass context as an argument for header function. Cannot find context as using reusable function. Need to pass from build method of timeline widget.
    backgroundColor: Theme.of(context).accentColor,
  );
}