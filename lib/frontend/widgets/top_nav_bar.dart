import 'package:flutter/material.dart';
import 'search_bar2.dart';

class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Open the parent Scaffold's drawer
        },
      ),
      title: const SearchBar2(),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.black),
          onPressed: () {
            // Handle notification button press
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
