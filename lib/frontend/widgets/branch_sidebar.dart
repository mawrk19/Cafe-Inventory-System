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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.brown,
            ),
            child: Text(
              'Branch Name', // You can replace this with the actual branch name
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          _buildDrawerItem(context, Icons.notifications, 'Notifications', '/BranchNotifications'),
          _buildDrawerItem(context, Icons.history, 'Order History', '/BranchHistory'),
          _buildDrawerItem(context, Icons.home, 'Home', '/BranchHome'),
          _buildDrawerItem(context, Icons.category, 'Categories', '/BranchCategory'),
          _buildDrawerItem(context, Icons.list, 'Orders', '/BranchOrders'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, String routeName) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
    );
  }
}
