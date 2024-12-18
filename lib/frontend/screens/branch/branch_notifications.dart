import 'package:flutter/material.dart';

class BranchNotifications extends StatefulWidget {
  const BranchNotifications({Key? key}) : super(key: key);

  @override
  _BranchNotificationsState createState() => _BranchNotificationsState();
}

class _BranchNotificationsState extends State<BranchNotifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Branch Notifications'),
      ),
      body: Center(
        child: Text('No notifications available.'),
      ),
    );
  }
}
