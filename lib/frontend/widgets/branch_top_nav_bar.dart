import 'package:flutter/material.dart';

class BranchTopNavBar extends StatelessWidget {
  const BranchTopNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            blurRadius: 4,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
            child: Image.asset(
              'assets/images/hamburgerIcon.png',
              width: 24,
              height: 24,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.menu);
              },
            ),
          ),
          Text(
            'Branch Name', // You can replace this with the actual branch name
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(width: 24), // Placeholder to balance the layout
        ],
      ),
    );
  }
}
