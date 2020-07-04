import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
     return Container(
      padding: EdgeInsets.all(100),
      color: Colors.blueGrey,
      child: Text(
        'Upload',
      style: TextStyle(color: Colors.white, fontSize: 40,
      ),
    ));
  }
}