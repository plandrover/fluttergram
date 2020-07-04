import 'dart:async';

import 'package:flutter/material.dart';
import 'package:social_app/widgets/header.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  //responsible for executing on saved and getting current state of form.
 final _formkey = GlobalKey<FormState>();
 final _scaffoldKey = GlobalKey<ScaffoldState>();
  String username;

 submit(){
   final form = _formkey.currentState;

//validate will go through all of our validator functions one more time to check all of the text form fields are valid. If it is true, can save text value to state and return username to previous route.
if(form.validate()){
  form.save();
  SnackBar snackbar = SnackBar(content:Text('Welcome $username'));
  _scaffoldKey.currentState.showSnackBar(snackbar);
  Timer(Duration(seconds: 2), (){
     Navigator.pop(context, username);

  });

}
   
  //  _formkey.currentState.save();
   //can pass value back in second argument.
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: header(context, titleText: "set up your profile"),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top:25),
            child: Center(
              child: Text(
                'create a username',
                style: TextStyle(
                  fontSize: 25.0
                ),
              )
              ),
            ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              child: Form(
                key: _formkey,
                child: TextFormField(
                  autovalidate: true,
                  validator: (val){
                    if(val.trim().length < 3 || val.isEmpty){
                      return 'username is too short';
                    }else if(val.trim().length > 12){
                      return 'username is too long';
                    }else{
                      return null;
                    }

                  },
                  //only execute fun when can access current state of form. Do that with formkey.
                  onSaved: (val) => username = val,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'username',
                    labelStyle: TextStyle(
                      fontSize: 15.0
                    ),
                    hintText: ('Must be atleast 3 characters')
                  ),
                ),
              ),
            ),
            ),
            GestureDetector(
              onTap: (){
                submit();
              },
              child: Container(
                height: 50.0,
                width: 350.0,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(7.0)
                  ),
                child: Center(
                  child: Text('submit',
                  style: TextStyle(fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                  ),
                  ),
                ),
              ),
              )
        ],),
    );
  }
}