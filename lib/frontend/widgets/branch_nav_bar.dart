import 'package:flutter/material.dart';
import 'package:kopilism/frontend/screens/branch/branch_notifications.dart';
import 'package:kopilism/frontend/screens/branch/order_history.dart';
import 'package:kopilism/frontend/screens/branch/branch_home.dart';
import 'package:kopilism/frontend/screens/branch/branch_category.dart';
import 'package:kopilism/frontend/screens/branch/branch_orders.dart';

class BranchNavBar extends StatelessWidget {
  const BranchNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            blurRadius: 4,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(context, 'Notifications', 'assets/images/notification.png', BranchNotifications()),
            _buildNavItem(context, 'History', 'assets/images/history.png', OrderHistoryScreen()),
            _buildNavItem(context, 'Home', 'assets/images/home_icon.png', BranchHome()),
            _buildNavItem(context, 'Category', 'assets/images/hamburgerIcon.png', BranchCategory()),
            _buildNavItem(context, 'Orders', 'assets/images/orders_icon.png', BranchOrders()),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String label, String iconPath, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Semantics(
        button: true,
        label: '$label navigation button',
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
