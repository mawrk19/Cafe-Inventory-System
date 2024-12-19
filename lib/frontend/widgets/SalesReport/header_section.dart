import 'package:flutter/material.dart';
// Import the AdminSidebar
import 'package:kopilism/frontend/screens/admin/notifications/admin_notification.dart'; // Import the AdminNotifications page

class HeaderSection extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const HeaderSection({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side (Hamburger icon)
          GestureDetector(
            onTap: () {
              scaffoldKey.currentState?.openDrawer(); // Open the drawer
            },
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 29,
                maxHeight: 40,
              ),
              child: Image.asset(
                'assets/images/hamburgerIcon.png',
                semanticLabel: 'Menu Icon',
              ),
            ),
          ),
          // Center (Search Bar)
          Container(
            constraints: const BoxConstraints(
              maxWidth: 185,
              maxHeight: 50,
            ),
            child: Image.asset(
              'assets/images/SearchBar.png',
              semanticLabel: 'Search Bar Icon',
            ),
          ),
          // Right side (Notification icon and Filter icon)
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AdminNotification(message: '',)),
                  );
                },
                child: Container(
                  constraints: const BoxConstraints(
                    maxWidth: 40,
                    maxHeight: 40,
                  ),
                  child: Image.asset(
                    'assets/images/notification.png',
                    semanticLabel: 'Notification Icon',
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Container(
                constraints: const BoxConstraints(
                  maxWidth: 40,
                  maxHeight: 40,
                ),
                child: Image.asset(
                  'assets/images/filterIcon.png',
                  semanticLabel: 'Filter Icon',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}