import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/shared_preference_service.dart';
import 'package:kopilism/frontend/screens/admin/products/archived_products.dart'; // Import the correct screen
import 'package:kopilism/frontend/widgets/logout/logout_button.dart'; // Add this import
import 'package:kopilism/backend/services/authentication.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  Future<Map<String, dynamic>> _fetchUserData() async {
    try {
      // Check SharedPreferences for stored data using SharedPreferencesService
      final prefsData = await SharedPreferencesService.getMultiple(['fullName', 'email', 'userRole']);
      String? fullName = prefsData['fullName'];
      String? email = prefsData['email'];
      String? role = prefsData['userRole'];

      // If all data is available in SharedPreferences, use it
      if (fullName != null && email != null && role != null) {
        return {
          'fullName': fullName,
          'email': email,
          'role': role,
        };
      }

      // If not, fetch from Firestore
      AuthenticationService authService = AuthenticationService();
      DocumentSnapshot userDoc = await authService.getCurrentUserData();

      if (userDoc.data() != null) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        // Save the fetched data to SharedPreferences
        await SharedPreferencesService.saveMultiple({
          'fullName': userData['fullName'],
          'email': userData['email'],
          'userRole': userData['role'],
        });

        return userData;
      } else {
        throw Exception('User data is null');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          var userData = snapshot.data!;
          return SizedBox(
            width: 250, // Adjust the width as needed
            child: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  UserAccountsDrawerHeader(
                    accountName: Text(userData['fullName']),
                    accountEmail: Text(userData['email']),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        userData['fullName'][0],
                        style: const TextStyle(fontSize: 40.0),
                      ),
                    ),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 117, 90, 79),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.category),
                    title: const Text('Products'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/AdminCategory');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text('Customers'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/Customer');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.qr_code),
                    title: const Text('Barcode'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/Barcode');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Dashboard'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/Home');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text('Orders'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/Orders');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person_add),
                    title: const Text('Registration'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/Registration');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.archive),
                    title: const Text('Archived Categories'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ArchiveProductsScreen(), // Navigate to ArchivedProducts
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Log out'),
                    onTap: () {
                      // Show the logout confirmation dialog
                      const LogoutButton().showLogoutConfirmation(context);
                    },
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}