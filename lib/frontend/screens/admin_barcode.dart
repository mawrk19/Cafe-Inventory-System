import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart';

class AdminBarcode extends StatelessWidget {
  const AdminBarcode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Barcode Screen'),
      ),
      body: const Center(
        child: Text('This is the Barcode Screen'),
      ),
      bottomNavigationBar: const BottomNavBar(), // Use your custom widget  
    );
  }
}
