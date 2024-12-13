import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart'; // Import your custom widget

class AdminOrders extends StatelessWidget {
  const AdminOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders Screen'),
      ),
      body: const Center(
        child: Text('This is the Orders Screen'),
      ),
      bottomNavigationBar: const BottomNavBar(), // Use your custom widget
    );
  }
}
