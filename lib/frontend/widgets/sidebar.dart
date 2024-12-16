import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kopilism/frontend/widgets/logout/logout_button.dart'; // Add this import
import 'package:kopilism/backend/services/authentication.dart'; // Add this import

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  Future<Map<String, dynamic>> _fetchUserData() async {
    AuthenticationService authService = AuthenticationService();
    DocumentSnapshot userDoc = await authService.getCurrentUserData();
    return userDoc.data() as Map<String, dynamic>;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          var userData = snapshot.data!;
          return Drawer(
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
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.category),
                  title: const Text('Admin Category'),
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
                  leading: const Icon(Icons.logout),
                  title: const Text('Log out'),
                  onTap: () {
                    // Add your logout logic here
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
