import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/branch_nav_bar.dart'; // Import BranchNavBar
import 'package:kopilism/frontend/widgets/branch_top_nav_bar.dart'; // Import BranchTopNavBar
import 'package:kopilism/frontend/widgets/branch_sidebar.dart'; // Import BranchSidebar

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
      drawer: const BranchSidebar(), // Add the BranchSidebar here
      body: Column(
        children: [
          const BranchTopNavBar(), // Add BranchTopNavBar here
          Expanded(
            child: Center(
              child: Text('No notifications available.'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BranchNavBar(), // Add BranchNavBar here
    );
  }
}
