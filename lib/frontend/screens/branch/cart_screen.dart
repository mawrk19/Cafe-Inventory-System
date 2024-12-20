import 'package:flutter/material.dart';
import 'package:kopilism/frontend/screens/branch/order_status.dart'; // Import the order status screen

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 127, 0, 39),
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 480),
                child: Column(
                  children: [
                    Container(
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
                      padding: EdgeInsets.fromLTRB(38, 21, 38, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Cart',
                                style: TextStyle(
                                  color: Color(0xFFFFF4E6),
                                  fontSize: 20,
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            OrdersScreen()),
                                  );
                                },
                                child: const Text(
                                  'Orders',
                                  style: TextStyle(
                                    color: Color(0xFFFFF4E6),
                                    fontSize: 20,
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 11),
                          Container(
                            height: 1,
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Color(0xFFFFF4E6),
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    CartItem(
                      title: 'Chocolate Powder 15Kg',
                      isDark: true,
                    ),
                    const SizedBox(height: 20),
                    CartItem(
                      title: 'Chocolate Powder 15Kg',
                      isDark: false,
                    ),
                    const SizedBox(height: 447),
                    const Text(
                      'Check Out',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 255,
                      padding: const EdgeInsets.fromLTRB(67, 16, 67, 95),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B2117),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'Checkout',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFFFF4E6),
                          fontSize: 24,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final String title;
  final bool isDark;

  const CartItem({
    Key? key,
    required this.title,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
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
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1E1E1E),
                fontSize: 15,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 56),
          Container(
            width: 27,
            height: 27,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF3B2117) : Colors.white,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 40),
          Container(
            width: 27,
            height: 27,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(
                    'https://cdn.builder.io/api/v1/image/assets/TEMP/0832336b8f366e21605188e9c89ab75788b4c0d496f4aa411ee89232f655b682?placeholderIfAbsent=true&apiKey=0a25a317372d4909b04d6b68b6e9350e'),
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
