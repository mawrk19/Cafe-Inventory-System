import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/employee_bottom_nav_bar.dart'; // Import your custom widget
import 'package:kopilism/frontend/widgets/employee_sidebar.dart';
import 'package:kopilism/frontend/widgets/exit.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart'; // Import your exit confirmation function

class EmployeeDashboard extends StatelessWidget {
  static final EmployeeDashboard _instance = EmployeeDashboard._internal();

  factory EmployeeDashboard() {
    return _instance;
  }

  EmployeeDashboard._internal({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showExitPopup(context); // Call your exit confirmation function
      },
      child: Scaffold(
        appBar: const TopNavBar(), // Use the custom TopNavBar
        drawer: const EmployeeSidebar(), // Add the Sidebar as the drawer
        body: const Center(
          child: Text('This is the Employee Dashboard Screen'),
        ),
        bottomNavigationBar: const EmployeeBottomNavBar(), // Use your custom widget
      ),
    );
  }
}
