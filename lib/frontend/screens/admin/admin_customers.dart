import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';
import 'package:kopilism/frontend/widgets/sidebar.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart'; // Import your custom widget

class AdminCustomers extends StatelessWidget {
  const AdminCustomers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNavBar(), // Use the custom TopNavBar
      drawer: const Sidebar(), // Add the Sidebar as the drawer
      body: const Center(
        child: Text('This is the Customers Screen'),
      ),
      bottomNavigationBar: const BottomNavBar(), // Use your custom widget
    );
  }
}
