import 'package:flutter/material.dart';
import 'package:websafe_svg/websafe_svg.dart';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  AppBar buildSearchFeild(){
    return AppBar(
      backgroundColor: Colors.white,
      title: TextFormField(
        decoration: InputDecoration(
          hintText: "Search for a user...",
          filled: true,
          prefixIcon: Icon(
            Icons.account_box,
            size: 28.0,
          ),
          suffixIcon: IconButton(
           icon: Icon(Icons.clear),
            onPressed: ()=>print('cleared'),
          ),
        ),
      ),
    );
  }
buildNoContent(){
  return Container(
    child: Center(child: ListView(
      children: <Widget>[
        WebsafeSvg.asset('search.svg')
      ],),),
  );
}
  @override
  Widget build(BuildContext context) {
       return Scaffold(
         appBar: buildSearchFeild(),
         body: buildNoContent(),
       );
  }
}

class UserResult extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("User Result");
  }
}