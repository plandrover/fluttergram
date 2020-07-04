import 'package:cloud_firestore/cloud_firestore.dart';

class User {
final String id;
final String username;
final String email;
final String photoUrl;
final String displayName;
final String bio;

User({this.id, this.username,this.photoUrl, this.displayName, this.bio, this.email});

//method for deserialisation. Takes doc of typedocument snapshot and turns it into an instance of user class.Can think of it as a static method, availible on user class.
factory User.fromDocument(DocumentSnapshot doc){
  return User(
    id: doc['id'],
    email: doc['email'],
    username: doc['username'],
    photoUrl: doc['photoUrl'],
    displayName: doc['displayName'],
    bio: doc['bio']
  );
}
}
