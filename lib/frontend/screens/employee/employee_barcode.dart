import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/employee_bottom_nav_bar.dart';

class EmployeeBarcode extends StatelessWidget {
  const EmployeeBarcode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Barcode Screen'),
      ),
      body: const Center(
        child: Text('This is the Employee Barcode Screen'),
      ),
      bottomNavigationBar: const EmployeeBottomNavBar(), // Use your custom widget  
    );
  }
}
