import 'package:flutter/material.dart';
import 'package:kopilism/frontend/screens/admin/notifications/admin_notification.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(16.0), // Adjust the radius as needed
      ),
      child: AppBar(
        backgroundColor: const Color(0xFFB0814F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Scaffold.of(context).openDrawer(); // Open the parent Scaffold's drawer
          },
        ),
        title: const SizedBox.shrink(), // Leave the middle section blank
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AdminNotification(
                    message: 'No new notifications',
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
