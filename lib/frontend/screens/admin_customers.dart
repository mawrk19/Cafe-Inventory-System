import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart'; // Import your custom widget

class AdminCustomers extends StatelessWidget {
  const AdminCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customers Screen'),
      ),
      body: const Center(
        child: Text('This is the Customers Screen'),
      ),
      bottomNavigationBar: const BottomNavBar(), // Use your custom widget
    );
  }
}
