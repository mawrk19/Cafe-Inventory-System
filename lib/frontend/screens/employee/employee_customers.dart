import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/employee_bottom_nav_bar.dart';

class EmployeeCustomers extends StatelessWidget {
  const EmployeeCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Customers Screen'),
      ),
      body: const Center(
        child: Text('This is the Employee Customers Screen'),
      ),
      bottomNavigationBar: const EmployeeBottomNavBar(), // Use your custom widget
    );
  }
}
