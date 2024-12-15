import 'package:flutter/material.dart';

class EmployeeBottomNavBar extends StatelessWidget {
  const EmployeeBottomNavBar({super.key});

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
            _buildNavItem(context, 'Product', 'assets/images/product_icon.png', '/EmployeeCategory'),
            _buildNavItem(context, 'Customer', 'assets/images/customer_icon.png', '/EmployeeCustomer'),
            _buildNavItem(context, 'Barcode', 'assets/images/barcode_scanner.png', '/EmployeeBarcode'),
            _buildNavItem(context, 'Home', 'assets/images/home_icon.png', '/EmployeeHome'),
            _buildNavItem(context, 'Orders', 'assets/images/orders_icon.png', '/EmployeeOrders'),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, String label, String iconPath, String routeName) {
    return GestureDetector(
      onTap: () {
        // Check if the current route is already the desired route
        if (ModalRoute.of(context)?.settings.name != routeName) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            routeName,
            (Route<dynamic> route) => false, // Remove all previous routes
          );
        }
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