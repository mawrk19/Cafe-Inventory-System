import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';
import 'package:kopilism/frontend/widgets/sidebar.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart';

class AdminBarcode extends StatelessWidget {
  const AdminBarcode({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: TopNavBar(), // Use the custom TopNavBar
      drawer: Sidebar(), // Add the Sidebar as the drawer
      body: Center(
        child: Text('This is the Barcode Screen'),
      ),
      bottomNavigationBar: BottomNavBar(), // Use your custom widget  
    );
  }
}
