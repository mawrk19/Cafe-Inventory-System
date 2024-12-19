import 'package:flutter/material.dart';

class RecentOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recent Orders',
            style: TextStyle(
              color: Color(0xFF2E2C2D),
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(height: 20),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildOrderCard('Matcha', '3000'),
                SizedBox(width: 20),
                _buildOrderCard('Chocolate', '3000'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderCard(String title, String price) {
    return Container(
      width: 150, // Fixed width for the cards
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xFFFFF4E6),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 121,
            color: Colors.white,
          ),
          SizedBox(height: 13),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E1E1E),
                ),
              ),
              SizedBox(height: 9),
              Text(
                'P$price per kg',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1E1E1E),
                ),
              ),
              SizedBox(height: 9),
              Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  'assets/images/cart_icon.png',
                  width: 40,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.shopping_cart);
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
