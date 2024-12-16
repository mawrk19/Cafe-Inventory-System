import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/employee_bottom_nav_bar.dart';
import 'package:kopilism/frontend/widgets/employee_sidebar.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart';

class EmployeeCustomers extends StatelessWidget {
  const EmployeeCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopNavBar(), // Use the custom TopNavBar
      drawer: EmployeeSidebar(), 
      body: Center(
        child: Text('This is the Employee Customers Screen'),
      ),
      bottomNavigationBar: EmployeeBottomNavBar(), // Use your custom widget
    );
  }
}
