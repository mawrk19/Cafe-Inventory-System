import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: const Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
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
            title: const Text('Logout'),
            onTap: () {
              // Perform logout action
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
