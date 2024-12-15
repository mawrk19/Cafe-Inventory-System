import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/products/bottom_nav_bar.dart'; // Import your custom widget

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard Screens'),
      ),
      body: const Center(
        child: Text('This is the Dashboard Screen'),
      ),
      bottomNavigationBar: const BottomNavBar(), // Use your custom widget
    );
  }
}
