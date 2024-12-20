import 'package:flutter/material.dart';
import 'package:kopilism/frontend/screens/branch/order_summary.dart'; // Import the order summary screen
import 'package:kopilism/frontend/widgets/branch_top_nav_bar.dart'; // Import the BranchTopNavBar widget

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              BranchTopNavBar(), // Add the BranchTopNavBar widget at the top
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 127, 0, 519),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF753D29),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.fromLTRB(79, 20, 27, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cart',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFFFFF4E6),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'Orders',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFFFFF4E6),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.only(top: 12),
                                height: 1,
                                color: const Color(0xFFFFF4E6),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    OrderItem(
                      orderId: 'ORDER0001',
                      date: 'Oct 12, 2024',
                      amount: 'P5000',
                      status: 'Pending',
                    ),
                    const SizedBox(height: 5),
                    OrderItem(
                      orderId: 'ORDER0001',
                      date: 'Oct 12, 2024',
                      amount: 'P5000',
                      status: 'Cancelled',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderItem extends StatelessWidget {
  final String orderId;
  final String date;
  final String amount;
  final String status;

  const OrderItem({
    Key? key,
    required this.orderId,
    required this.date,
    required this.amount,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(25, 26, 9, 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                orderId,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              _buildOrderDetail('15kg Matcha Powder'),
              _buildOrderDetail('15kg Chocolate Powder'),
              _buildOrderDetail('300 Cups'),
              _buildOrderDetail('9pck Straw'),
            ],
          ),
          Text(
            date,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OrderSummaryScreen()),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF3B2117),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                status,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFFFF4E6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderDetail(String text) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Inter',
        fontSize: 11,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}
