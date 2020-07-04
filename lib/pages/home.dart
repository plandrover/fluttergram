import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_app/models/user.dart';
import 'package:social_app/pages/activity_feed.dart';
import 'package:social_app/pages/create_account.dart';
import 'package:social_app/pages/profile.dart';
import 'package:social_app/pages/upload.dart';
// import 'package:social_app/pages/timeline.dart';
import 'package:social_app/pages/search.dart';





//splash screen with title + user sign-in btn.
//using state, will show authenticates screen for athenticated users and unauthenticated screen for ...

//allows us to use number of methodds where user can login etc
final GoogleSignIn googleSignIn = GoogleSignIn();
final usersRef = Firestore.instance.collection('users');
final DateTime timestamp = DateTime.now();
//will store all user data so can be passed to different pages.
User currentUser;


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isAuth = false;
  PageController pageController;
  int pageIndex = 0;
  

login(){
  googleSignIn.signIn();
}
logout(){
  googleSignIn.disconnect();
}

@override
void initState(){
  super.initState();

  //want to reference the controller so that we can dispose of it later when not needed. 
  pageController = PageController();

  googleSignIn.onCurrentUserChanged.listen((account) {
    if(account != null){
      createUserInFirestore();
      setState(() {
        isAuth = true;
      });
    } else{
      setState(() {
        isAuth = false;
      });
    }
   });
   googleSignIn.signInSilently();
}

createUserInFirestore() async {
// 1) check is user exists in users colleciton in DB according to their ID
final GoogleSignInAccount user = googleSignIn.currentUser;
 DocumentSnapshot doc = await usersRef.document(user.id).get();


if(!doc.exists){
  // 2) if user does not exists, take them to create account page.
  //use await to wait for username value.
  final username = await Navigator.push(context, MaterialPageRoute(builder: (context)=> CreateAccount()));
  
// 3) get username from create account and use it to make a new user document in users collection.
usersRef.document(user.id).setData({
    'id': user.id,
    'username': username,
    'photoUrl': user.photoUrl,
    'email': user.email,
    'dispayName': user.displayName,
    'bio': "",
    "timestamp": timestamp
  });
  //if doc does not exist and we are creating a new document then we want to refetch and update doc variable after.
  doc = await usersRef.document(user.id).get();
  
}
currentUser = User.fromDocument(doc);
print(currentUser);
print(currentUser.username);

  
}

@override
void dispose(){
  //common for widgtes need to inititalise with initState.
  pageController.dispose();
super.dispose();
}

//we want current index valye in state so we can pass value to other areas of app such as nav bar. 
onPageChanged(int pageIndex){
  setState(() {
    //as value we're attempting to put in state has same name as state variable, use this.
    this.pageIndex = pageIndex;

  });
}
//responsible for changing pageview
onTap(int pageIndex){
  setState(() {
     this.pageIndex = pageIndex;
 
  });
 
}

//func that returns widget
Scaffold buildAuthScreen (){
  return Scaffold(
    body: PageView(children: <Widget>[
      // Timeline(),
      RaisedButton(
        onPressed: (){
          logout();
        },
        child: Text('Logout')
      ),
      ActivityFeed(),
      Upload(),
      Search(),
      Profile(),
    ],
    //controller allows switching between pages
    controller: pageController,
    //Takes index we are on, (Timeline is at index 0)
    onPageChanged: onPageChanged(pageIndex),
    //do not want page view to scroll, just scrollable widgets within.
    // physics: NeverScrollableScrollPhysics(),
    ),
    bottomNavigationBar: CupertinoTabBar(
      currentIndex: pageIndex,
      //responsible for changing page in pageview
      onTap: (index){
        pageController.animateToPage(
          index,
          duration: Duration(milliseconds: 300),
          //easing curve
          curve: Curves.easeInOut,
          );
        setState(() {
          pageIndex = index;
        });
        
      },
      
      activeColor: Theme.of(context).primaryColor,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.whatshot) ),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active)),
        BottomNavigationBarItem(icon: Icon(Icons.photo_camera, size: 35.0,)),
        BottomNavigationBarItem(icon: Icon(Icons.search)),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle)),
        
      ]
      ),
    );
  
  
}


Widget buildUnAuthScreen(){
return Scaffold(
  body: Container(
    //bg gradient
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          // Color(0xff090979),
          // Color(0xff00d4ff)
          //context contains a lot of info including theme data
          Theme.of(context).accentColor,
          Theme.of(context).primaryColor,
               ]
      )
    ),
    alignment: Alignment.center,
    child: Column(
      mainAxisAlignment:  MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
      Text(
        'Fluttergram',
        style: TextStyle(
          fontFamily: 'signatra',
          fontSize: 60,
          color: Colors.white,
        ),
      ),
      SizedBox(height: 20),
      //image for a button
      GestureDetector(
        onTap: (){
          login();
          print('btn pressed');
        },
        child: Container(
          width: 260,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(
              //as reading from asset folder
              image: AssetImage('assets/images/google_signin_button.png'),
              fit: BoxFit.cover,
            )
          ),
        ),
      )
    ],),
  )
);
}


  @override
  Widget build(BuildContext context) {
    //make sure appropriate widget returned.
    return isAuth ? buildAuthScreen() : buildUnAuthScreen();
  }
}
