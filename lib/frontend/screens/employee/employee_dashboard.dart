import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/employee_bottom_nav_bar.dart'; // Import your custom widget

class EmployeeDashboard extends StatelessWidget {
  const EmployeeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard Screens'),
      ),
      body: const Center(
        child: Text('This is the Employee Dashboard Screen'),
      ),
      bottomNavigationBar: const EmployeeBottomNavBar(), // Use your custom widget
    );
  }
}
