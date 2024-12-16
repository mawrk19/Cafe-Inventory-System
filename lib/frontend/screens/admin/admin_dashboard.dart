import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';
import 'package:kopilism/frontend/widgets/sidebar.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart'; // Import your custom widget
import 'package:kopilism/frontend/widgets/exit.dart'; // Import your exit confirmation function

class AdminDashboard extends StatelessWidget {
  static final AdminDashboard _instance = AdminDashboard._internal();

  factory AdminDashboard() {
    return _instance;
  }

  const AdminDashboard._internal();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showExitPopup(context); // Call your exit confirmation function
      },
      child: const Scaffold(
        appBar: TopNavBar(), // Use the custom TopNavBar
        drawer: Sidebar(), // Add the Sidebar as the drawer
        body: Center(
          child: Text('This is the Dashboard Screen'),
        ),
        bottomNavigationBar: BottomNavBar(), // Use your custom widget
      ),
    );
  }
}
