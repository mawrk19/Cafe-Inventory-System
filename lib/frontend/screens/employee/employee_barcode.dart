import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/employee_bottom_nav_bar.dart';
import 'package:kopilism/frontend/widgets/employee_sidebar.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart';

class EmployeeBarcode extends StatelessWidget {
  const EmployeeBarcode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(), // Use the custom TopNavBar
        drawer: const EmployeeSidebar(), 
      body: const Center(
        child: Text('This is the Employee Barcode Screen'),
      ),
      bottomNavigationBar: const EmployeeBottomNavBar(), // Use your custom widget  
    );
  }
}
