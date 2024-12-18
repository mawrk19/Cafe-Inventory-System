import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/products/deleted_product.dart';
import 'package:kopilism/frontend/widgets/top_nav_bar.dart'; // Import your custom widget
import 'package:kopilism/frontend/widgets/bottom_nav_bar.dart'; // Import the BottomNavBar
import 'package:kopilism/frontend/widgets/sidebar.dart'; // Import your custom Sidebar

class ArchiveProductsScreen extends StatelessWidget {
  const ArchiveProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove the back button
        title: const TopNavBar(), // Add the TopNavBar to the appBar
      ),
      drawer: const Sidebar(), // Use your custom Sidebar
      body: SingleChildScrollView(
        child: Center( // Center content for small screens
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 180), // Adjusted padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // Search Bar with Filter Icon beside it
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 228,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(9999),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                          ),
                        ],
                        border: Border.all(color: const Color(0xFFD9D9D9)),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Search...',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const Icon(
                            Icons.search,
                            size: 16,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.filter_alt,
                      size: 25,
                    ),
                  ],
                ),
                // Header
                Container(
                  margin: const EdgeInsets.only(top: 25, left: 12),
                  child: const Text(
                    'ARCHIVE PRODUCTS',
                    style: TextStyle(
                      color: Color(0xFF240C10),
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.2,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Deleted Products List
                const DeletedProduct(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(), // Add the BottomNavBar at the bottom of the screen
    );
  }
}