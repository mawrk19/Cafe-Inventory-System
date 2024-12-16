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

  AdminDashboard._internal({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showExitPopup(context); // Call your exit confirmation function
      },
      child: Scaffold(
        appBar: const TopNavBar(), // Use the custom TopNavBar
        drawer: const Sidebar(), // Add the Sidebar as the drawer
        body: const Center(
          child: Text('This is the Dashboard Screen'),
        ),
        bottomNavigationBar: const BottomNavBar(), // Use your custom widget
      ),
    );
  }
}
