import 'package:flutter/material.dart';

class ActivityFeed extends StatefulWidget {
  @override
  _ActivityFeedState createState() => _ActivityFeedState();
}

class _ActivityFeedState extends State<ActivityFeed> {
  @override
  Widget build(BuildContext context) {
       return Container(
      padding: EdgeInsets.all(100),
      color: Colors.pink,
      child: Text(
        'Activity feed',
      style: TextStyle(color: Colors.white, fontSize: 40,
      ),
    ));
  }
}

class ActivityFeedItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Activity Feed Item');
  }
}