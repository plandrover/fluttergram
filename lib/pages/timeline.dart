import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/widgets/header.dart';

final usersRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {


@override
  void initState() {
    // getUsers();
    deleteUser();
    super.initState();
  }

// getUserById() async {
//   final String id = "IYtnpdiZDrODa8YBS6ml";
//   final DocumentSnapshot doc = await usersRef.document(id).get();
//   print(doc.data);
// }


void createUser() {
  usersRef.document("niewdnewidniwdn").setData({
    'username': "Jeff",
    "postCount": 0,
    "isAdmin": false
  });
}
void updateUser()async{
  final DocumentSnapshot doc = await usersRef.document("niewdnewidniwdn").get();
  
  if(doc.exists){
    doc.reference.updateData({
    'username': "Joanna",
    "postCount": 0,
    "isAdmin": false
  });
  }

  
}
void deleteUser()async{
  final DocumentSnapshot doc = await usersRef.document("niewdnewidniwdn").get();

  if(doc.exists){
    doc.reference.delete();
  }
}

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: Container(
        // FUTURE BUILDER NOTES---------
        //can be used in stateful and stateless widgets
        // child: FutureBuilder<QuerySnapshot>(
          //request we want to make. No need for await. Just a future it needs to resolve. When resolved, will get a query snapshot. 
          // future: usersRef.getDocuments(),
          //func determining how snapshot data dislpayed when resolved from future.
          //snapshot here different from get users. Different properties such as has data. 
          // END
          //streambuilder allows us to get live data. Can still use all same logic as FutureBuilder.
          child: StreamBuilder<QuerySnapshot>(
            //return stream of querysnapshots.
            stream: usersRef.snapshots(),
          builder: (context, snapshot){
            //no data means we are still in loading state
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }
            final List<Text> children =snapshot.data.documents.map((doc) => Text(doc['username'])).toList();
              return Container(
                child: ListView(children: children),
              );
          },
            ),
            )
            );
  }}