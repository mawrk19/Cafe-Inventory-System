import 'package:flutter/material.dart';
import 'package:kopilism/frontend/screens/sales_report_screen.dart'; // Import the ProductSalesReport screen

class BranchTab extends StatelessWidget {
  const BranchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 2.0), // Reduced overall horizontal padding to move tabs to the left
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start, // Aligns the tabs to the left
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0), // Adjusted horizontal padding
            child: _buildTab('Products', true, MediaQuery.of(context).size.width, context, () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductSalesReport()),
              );
            }, const Color(0xFFF0E2C5), Colors.black),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0), // Adjusted horizontal padding
            child: _buildTab('Branches', false, MediaQuery.of(context).size.width, context, null, const Color(0xFF3B2117), const Color(0xFFF0E2C5)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0), // Adjusted horizontal padding
            child: _buildDailyTab(MediaQuery.of(context).size.width),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String text, bool isActive, double screenWidth, BuildContext context, VoidCallback? onTap, Color backgroundColor, Color textColor) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.05, // Increased horizontal padding for larger container
          vertical: 15,
        ),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center( // Centers the text within the tab
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDailyTab(double screenWidth) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04, // Increased horizontal padding for larger container
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF3B2117),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centers content within the Daily tab
        children: [
          Text(
            'Daily',
            style: TextStyle(
              color: const Color(0xFFF0E2C5),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
            ),
          ),
          SizedBox(width: 5), // Reduced spacing for better fit
          Image.asset(
            'assets/images/arrow_down.png',
            width: screenWidth * 0.05, // Dynamically scale the image size
            height: screenWidth * 0.05,
          ),
        ],
      ),
    );
  }
}