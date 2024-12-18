import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kopilism/backend/services/shared_preference_service.dart';
import 'package:kopilism/frontend/screens/admin/products/admin_archived_categories.dart';
import 'package:kopilism/frontend/widgets/logout/logout_button.dart'; // Add this import
import 'package:kopilism/backend/services/authentication.dart';

class BranchSidebar extends StatelessWidget {
  const BranchSidebar({super.key});

  Future<Map<String, dynamic>> _fetchUserData() async {
    try {
      // Check SharedPreferences for stored data using SharedPreferencesService
      final prefsData =
          await SharedPreferencesService.getMultiple(['fullName', 'email']);
      String? fullName = prefsData['fullName'];
      String? email = prefsData['email'];

      // If all data is available in SharedPreferences, use it
      if (fullName != null && email != null) {
        return {
          'fullName': fullName,
          'email': email,
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
                    title: const Text('Home'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/BranchHome');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people),
                    title: const Text('Orders'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/BranchOrders');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.qr_code),
                    title: const Text('Category'),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/BranchCategory');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('History'),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/BranchHistory');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.shopping_cart),
                    title: const Text('Notifications'),
                    onTap: () {
                      Navigator.pushReplacementNamed(
                          context, '/BranchNotifications');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.archive),
                    title: const Text('Sales Report'),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminArchivedCategories(),
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
